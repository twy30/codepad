#!/bin/bash
# Version: 2021-Aug-08 06:40:51

# spellcheck.bash [FILE]...
#
# Spellcheck FILE's path and contents.

. "$(dirname "${0}")/_lib.bash"

function myEchoMisspelledWords {
    local -r myFilePath=${1}
    local -r myMisspelledWords=${2}

    if [ "${myMisspelledWords}" ]
    then
        myEchoWarning "${myFilePath}" "misspelling"
        echo -n "${myMisspelledWords}" | sha512sum
        echo "${myMisspelledWords}"
    fi
}

function mySpellcheckCommand {
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

        myMisspelledWords=$(aspell --mode=none list < "${myFilePath}" | sort --unique)
        myEchoMisspelledWords "${myFilePath}" "${myMisspelledWords}"
        if [ "${myMisspelledWords}" ]
        then
            echo -n "${myMisspelledWords}" | grep --color=auto --file=- --line-number --word-regexp "${myFilePath}"
        fi
    done
}

mySpellcheckCommand "${@}"
