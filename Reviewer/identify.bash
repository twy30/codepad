#!/bin/bash

# identify.bash FILE...
#
# List FILE's identity information.

. "$(dirname "${0}")/_lib.bash"

function myIdentifyCommand {
    local myFilePath
    local -r myWorkingFolderPath=$(pwd)
    for myFilePath
    do
        if [ ! -f "${myFilePath}" ]
        then
            continue
        fi
        local myFileRealPath=$(realpath "${myFilePath}")
        cd "$(dirname "${myFileRealPath}")"
        myEcho "Git Path   : \`$(git ls-files --full-name "${myFileRealPath}")\`"
        myEcho "Git Commit : \`$(git log -1 --format='format:%H' "${myFileRealPath}")\`"
        myEcho "sha512sum  : \`$(sha512sum < "${myFileRealPath}")\`"
        cd "${myWorkingFolderPath}"
    done
}

myIdentifyCommand "${@}"
