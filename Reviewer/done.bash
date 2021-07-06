#!/bin/bash
# Version: 2021-Jul-06 19:39:15

# done.bash _Input_File_Path_
#
# Archive the `Doing` logs:
#
# 1. Append `_Input_File_Path_`'s contents to
#    `$(dirname _Input_File_Path_)/zzzzzzz-my-log-1-Done.md`.
# 2. Empty `_Input_File_Path_`'s contents.

myInputFilePath=${1}

if [ ! -f "${myInputFilePath}" ]
then
    echo "$(basename "${0}"): \`${myInputFilePath}\` must be a file." >&2
    exit 1
fi

myOutputFilePath="$(dirname "${myInputFilePath}")/zzzzzzz-my-log-1-Done.md"
cat "${myInputFilePath}" >> "${myOutputFilePath}"
if [ "${?}" -eq 0 ]
then
    > "${myInputFilePath}"
else
    exit 1
fi
