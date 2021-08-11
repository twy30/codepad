#!/bin/bash

# review.bash FILE...
#
# List feedback for FILE.

function myEchoWarning {
    local -r myFilePath=${1}
    local -r myMessage=${2}

    if [ -t 1 ]
    then
        local -r mySelectGraphicRendition=$'\e[93m'
        local -r mySelectGraphicRenditionReset=$'\e[m'
    fi
    echo "$(basename "${0}"): \`${myFilePath}\`: ${mySelectGraphicRendition}${myMessage}${mySelectGraphicRenditionReset}"
}

function myEchoMisspelledWords {
    local -r myMisspelledWords=${1}
    local -r myFilePath=${2}
    local -r myHighlightCommand=${3}

    if [ "${myMisspelledWords}" ]
    then
        myEchoWarning "${myFilePath}" "misspelling"
        echo "${myMisspelledWords}"
        eval "${myHighlightCommand}"
    fi
}

function myReviewCommand {
    local myFilePath
    for myFilePath
    do
        myEchoMisspelledWords "$(echo -n "${myFilePath}" | aspell --mode=none list | sort --unique)" "${myFilePath}" 'echo -n "${myFilePath}" | grep --color=auto --word-regexp "${myMisspelledWords}"'

        if [ ! -f "${myFilePath}" ]
        then
            myEchoWarning "${myFilePath}" 'folder'
            continue
        fi

        if [ ! -s "${myFilePath}" ]
        then
            myEchoWarning "${myFilePath}" 'empty'
            continue
        fi

        myEchoMisspelledWords "$(aspell --mode=none list < "${myFilePath}" | sort --unique)" "${myFilePath}" 'echo -n "${myMisspelledWords}" | grep --color=auto --file=- --line-number --word-regexp "${myFilePath}"'

        if [[ ! "$(head --bytes=1 "${myFilePath}")" =~ ^[[:print:]]$ ]]
        then
            myEchoWarning "${myFilePath}" 'file-start printable'
        fi

        if [ "$(tail --bytes=1 "${myFilePath}" | od --format=x1)" != "$(echo -n $'\n' | od --format=x1)" ]
        then
            myEchoWarning "${myFilePath}" 'file-end newline'
        fi

        if grep --silent $'\r' "${myFilePath}"
        then
            myEchoWarning "${myFilePath}" 'carriage return'
        fi

        if grep --regexp='[[:space:]]$' --silent "${myFilePath}"
        then
            myEchoWarning "${myFilePath}" 'trailing whitespace'
        fi
    done
}

myReviewCommand "${@}"
