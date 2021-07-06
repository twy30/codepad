#!/bin/bash
# Version: 2021-Jul-06 19:39:30

# spellcheck.bash [_Input_File_Path_1_ _Input_File_Path_2_ ...]
#
# Spellcheck input files' filenames and contents.

function mySpellcheckFile {
    local myInputFilePath=${1}

    if [ ! -f "${myInputFilePath}" ]
    then
        echo "$(basename "${0}"): \`${myInputFilePath}\` must be a file." >&2
        return 1
    fi

    echo -n "${myInputFilePath}" | grep --color=auto --word-regexp "$(echo -n "${myInputFilePath}" | aspell list | sort --unique)"

    aspell list < "${myInputFilePath}" | sort --unique | grep --color=auto --file=- --line-number --word-regexp "${myInputFilePath}"
}

for myInputFilePath in "${@}"
do
    mySpellcheckFile "${myInputFilePath}"
done
