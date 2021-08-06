#!/bin/bash
# Version: 2021-Aug-05 23:03:00

# review.bash [FILE]...
#
# List feedback for FILE.

. "$(dirname "${0}")/_lib.bash"

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
    local -r myFilePath=${1}
    local -r myMisspelledWords=${2}

    if [ "${myMisspelledWords}" ]
    then
        myEchoWarning "${myFilePath}" "misspelling"
        echo "${myMisspelledWords}"
    fi
}

function myReview_bash_File {
    local -r myFilePath=${1}

    if [ "$(head --bytes=${#my_bash_HeaderStart} "${myFilePath}")" != "${my_bash_HeaderStart}" ]
    then
        myEchoWarning "${myFilePath}" 'header start'
    fi

    if [[ ! "$(myGet_bash_FileVersion "${myFilePath}")" =~ ${myVersionRegexp} ]]
    then
        myEchoWarning "${myFilePath}" 'version'
    fi

    local -r my_bash_HeaderEnd=$'\n\n'
    if [ "$(head --bytes=$((${#my_bash_HeaderStart} + ${#myVersionSample} + ${#my_bash_HeaderEnd})) "${myFilePath}" | tail --bytes=${#my_bash_HeaderEnd} | od --format=x1)" != "$(echo -n "${my_bash_HeaderEnd}" | od --format=x1)" ]
    then
        myEchoWarning "${myFilePath}" 'header end'
    fi
}

function myReview_md_File {
    local -r myFilePath=${1}

    if [ "$(head --bytes=${#my_md_HeaderStart} "${myFilePath}")" != "${my_md_HeaderStart}" ]
    then
        myEchoWarning "${myFilePath}" 'header start'
    fi

    if [[ ! "$(myGet_md_FileVersion "${myFilePath}")" =~ ${myVersionRegexp} ]]
    then
        myEchoWarning "${myFilePath}" 'version'
    fi

    local -r my_md_HeaderEnd=$'\n---\n\n'
    if [ "$(head --bytes=$((${#my_md_HeaderStart} + ${#myVersionSample} + ${#my_md_HeaderEnd})) "${myFilePath}" | tail --bytes=${#my_md_HeaderEnd} | od --format=x1)" != "$(echo -n "${my_md_HeaderEnd}" | od --format=x1)" ]
    then
        myEchoWarning "${myFilePath}" 'header end'
    fi
}

function myReviewCommand {
    local -r myNewline=$'\n'
    local myFilePath
    local myMisspelledWords
    for myFilePath
    do
        myMisspelledWords=$(echo -n "${myFilePath}" | aspell --mode=none list | sort --unique)
        myEchoMisspelledWords "${myFilePath}" "${myMisspelledWords}"
        if [ "${myMisspelledWords}" ]
        then
            echo -n "${myFilePath}" | grep --color=auto --word-regexp "${myMisspelledWords}"
        fi

        if [ ! -f "${myFilePath}" ]
        then
            continue
        fi

        if [ ! -s "${myFilePath}" ]
        then
            continue
        fi

        myMisspelledWords=$(aspell --mode=none list < "${myFilePath}" | sort --unique)
        myEchoMisspelledWords "${myFilePath}" "${myMisspelledWords}"
        if [ "${myMisspelledWords}" ]
        then
            echo -n "${myMisspelledWords}" | grep --color=auto --file=- --line-number --word-regexp "${myFilePath}"
        fi

        if [ "$(tail --bytes=${#myNewline} "${myFilePath}" | od --format=x1)" != "$(echo -n "${myNewline}" | od --format=x1)" ]
        then
            myEchoWarning "${myFilePath}" 'end-of-file newline'
        fi

        if grep --silent $'\r' "${myFilePath}"
        then
            myEchoWarning "${myFilePath}" 'carriage return'
        fi

        if grep --regexp='[[:space:]]$' --silent "${myFilePath}"
        then
            myEchoWarning "${myFilePath}" 'trailing whitespace'
        fi

        myActByFileType "${myFilePath}" 'myReview_' '_File'
    done
}

myReviewCommand "${@}"
