#!/bin/bash
# Version: 2021-Jul-13 16:15:00

# version.bash [FILE]...
#
# List FILE's `Version`.

. "$(dirname "${0}")/_lib.bash"

for myInputFilePath
do
    echo "$(myGetFileVersionView "${myInputFilePath}")"
done
