#!/bin/bash
# Version: 2021-Jul-06 19:39:35

# to-do.bash _Output_Folder_Path_
#
# Create the `To-Do` and `Doing` logs.

myOutputFolderPath=${1}

if [ ! -d "${myOutputFolderPath}" ]
then
    echo "$(basename "${0}"): \`${myOutputFolderPath}\` must be a folder." >&2
    exit 2
fi

function myCreateFileIfNotExist {
    local myOutputFilePath=${1}

    if [ -e "${myOutputFilePath}" ]
    then
        echo "$(basename "${0}"): \`${myOutputFilePath}\` already exists." >&2
        exit 1
    fi

    > "${myOutputFilePath}"
}

myCreateFileIfNotExist "${myOutputFolderPath}/zzzzzzz-my-log-2-To-Do.md"
myCreateFileIfNotExist "${myOutputFolderPath}/zzzzzzz-my-log-3-Doing.md"
