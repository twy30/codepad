#!/bin/bash
# Version: 2021-Jul-13 16:16:36

# list.bash [FILE]...
#
# List FILE by its `Version`.
#
# * `.log` files are excluded.
# * Directory contents are listed recursively.

. "$(dirname "${0}")/_lib.bash"

function myGetFileVersionList {
    for myInputFilePath
    do
        if [ ! -r "${myInputFilePath}" ]
        then
            continue
        fi

        if [ -d "${myInputFilePath}" ]
        then
            find "${myInputFilePath}" -type f -not -name '*.log' -print0 | xargs --null ./version.bash
        elif [ -f "${myInputFilePath}" -a "$(myGetExtensionName "${myInputFilePath}")" != 'log' ]
        then
            echo "$(myGetFileVersionView "${myInputFilePath}")"
        fi
    done
}

myGetFileVersionList "${@}" | sort --reverse
