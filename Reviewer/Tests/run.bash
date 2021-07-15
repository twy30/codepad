#!/bin/bash
# Version: 2021-Jul-15 01:32:10

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
    local -r myTestLogName=${3:-${myTestCase//\//.}}

    eval "${myTestCommand} Cases/${myTestCase}/*" > "Results/${myTestLogName}.stdout.log" 2> "Results/${myTestLogName}.stderr.log"
}

## Test `myRunTest`.

myRunTest 'echo' 'Tests/run'
myRunTest 'echo' 'Tests/run' 'Tests.run.explicit-test-log-name'

## Test `list`.

myRunTest '../list.bash' 'list/extension-names'
myRunTest '../list.bash' 'list/folders'
myRunTest '../list.bash' 'list/sorting'

## Test `review`.

myRunTest '../review.bash' '_lib/Bash/version-strings' 'review.Bash.version-strings'
myRunTest '../review.bash' '_lib/file-types' 'review.file-types'
myRunTest '../review.bash' '_lib/Markdown/version-strings' 'review.Markdown.version-strings'
myRunTest '../review.bash' 'review/Bash'
myRunTest '../review.bash' 'review/Bash/header-end-strings'
myRunTest '../review.bash' 'review/Bash/header-start-strings'
myRunTest '../review.bash' 'review/carriage-return-characters'
myRunTest '../review.bash' 'review/end-of-file-newlines'
myRunTest '../review.bash' 'review/file-sizes'
myRunTest '../review.bash' 'review/Markdown'
myRunTest '../review.bash' 'review/Markdown/header-end-strings'
myRunTest '../review.bash' 'review/Markdown/header-start-strings'
myRunTest '../review.bash' 'review/spellcheck/file-contents'
myRunTest '../review.bash' 'review/spellcheck/file-paths'
myRunTest '../review.bash' 'review/trailing-whitespaces'

## Test `version`.

myRunTest '../version.bash' '_lib/Bash/version-strings' 'version.Bash.version-strings'
myRunTest '../version.bash' '_lib/file-types' 'version.file-types'
myRunTest '../version.bash' '_lib/Markdown/version-strings' 'version.Markdown.version-strings'
myRunTest '../version.bash' 'version/extension-names'
myRunTest '../version.bash' 'version/MMM-to-MM'

## Test file readability

chmod u-r Cases/_lib/file-readability/unreadable.bash
myRunTest '../list.bash' '_lib/file-readability' 'list.file-readability'
myRunTest '../review.bash' '_lib/file-readability' 'review.file-readability'
myRunTest '../version.bash' '_lib/file-readability' 'version.file-readability'
chmod u+r Cases/_lib/file-readability/unreadable.bash

# List test result changes.
git status --porcelain Results/
