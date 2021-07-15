#!/bin/bash
# Version: 2021-Jul-15 01:31:21

# version.bash [FILE]...
#
# List FILE's `Version`.

. "$(dirname "${0}")/_lib.bash"

for myInputFilePath
do
    myListFileVersion "${myInputFilePath}"
done
