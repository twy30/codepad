#!/bin/bash
# Version: 2021-Jul-13 16:17:21

# run.bash
#
# Run all tests; then list test result changes.

cd "$(dirname "${0}")"

# Purge test results.
rm --recursive Results/*

# Run tests.

function myRunTest {
    local -r myTestCommand=${1}
    local -r myTestCase=${2}

    local -r myTestName=${myTestCase//\//.}
    eval "${myTestCommand} Cases/${myTestCase}/*" > "Results/${myTestName}.stdout.log" 2> "Results/${myTestName}.stderr.log"
}

myRunTest 'echo' 'run'

#myRunTest '../review.bash' '_lib/skip/non-file'
myRunTest '../review.bash' 'review/Bash/validate-header-end'
myRunTest '../review.bash' 'review/Bash/validate-header-start'
myRunTest '../review.bash' 'review/Bash/validate-version'
myRunTest '../review.bash' 'review/end/with-1-newline'
myRunTest '../review.bash' 'review/Markdown/validate-header-end'
myRunTest '../review.bash' 'review/Markdown/validate-header-start'
myRunTest '../review.bash' 'review/Markdown/validate-version'
myRunTest '../review.bash' 'review/no/carriage-return'
myRunTest '../review.bash' 'review/no/trailing-whitespace'
myRunTest '../review.bash' 'review/skip/empty-file'
myRunTest '../review.bash' 'review/spellcheck/file-contents'
myRunTest '../review.bash' 'review/spellcheck/file-path'

myRunTest '../version.bash' '_lib/skip/non-file'
myRunTest '../version.bash' 'version/MMM'
myRunTest '../version.bash' 'version/version'

chmod u-r Cases/_lib/skip/unreadable-file/unreadable
#myRunTest '../review.bash' '_lib/skip/unreadable-file'
myRunTest '../version.bash' '_lib/skip/unreadable-file'
chmod u+r Cases/_lib/skip/unreadable-file/unreadable

# List test result changes.
git status --porcelain Results/
