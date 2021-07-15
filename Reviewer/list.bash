#!/bin/bash
# Version: 2021-Jul-15 01:31:52

# list.bash [FILE]...
#
# List FILE by its `Version`.
#
# * `.log` files are excluded.
# * Directory contents are listed recursively.
# * Unreadable files are excluded.

readonly myDirName=$(dirname "${0}")

. "${myDirName}/_lib.bash"

function myGetFileVersionList {
    for myInputFilePath
    do
        if [ ! -r "${myInputFilePath}" ]
        then
            continue
        fi

        if [ -d "${myInputFilePath}" ]
        then
            find "${myInputFilePath}" -type f -not -name '*.log' -print0 | xargs --null "${myDirName}/version.bash"
        elif [ -f "${myInputFilePath}" -a "$(myGetExtensionName "${myInputFilePath}")" != 'log' ]
        then
            myListFileVersion "${myInputFilePath}"
        fi
    done
}

myGetFileVersionList "${@}" | sort --reverse
