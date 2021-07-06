#!/bin/bash
# Version: 2021-Jul-06 19:39:48

# run.bash
#
# Run all tests and list `Outputs` changes (if any).

pushd "$(dirname "${0}")" > /dev/null

rm --recursive Outputs/
mkdir Outputs/

mkdir Outputs/done
echo '1. To create the `Done` log file.' > Outputs/done/zzzzzzz-my-log-3-Doing.md
../done.bash Outputs/done/zzzzzzz-my-log-3-Doing.md
echo '2. To append to the `Done` log file.' > Outputs/done/zzzzzzz-my-log-3-Doing.md
../done.bash Outputs/done/zzzzzzz-my-log-3-Doing.md

../list.bash Inputs/list/ > Outputs/list.log

../spellcheck.bash Inputs/spellcheck/* > Outputs/spellcheck.log

mkdir Outputs/to-do
../to-do.bash Outputs/to-do

../validate.bash Inputs/validate/* > Outputs/validate.log

git status Outputs/

popd > /dev/null
