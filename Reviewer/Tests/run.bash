#!/bin/bash
# Version: 2021-Aug-05 23:46:49

# run.bash
#
# Run all tests; then list test result changes.

cd "$(dirname "${0}")"

# Purge test results.
rm --recursive .Test-Results/*

# Run tests.

function myRunTest {
    local -r myCommand=${1}
    local -r myTestCaseName=${2}
    local -r myLogName=${3:-${myTestCaseName//\//.}}

    ${myCommand} .Test-Cases/${myTestCaseName}/* > ".Test-Results/${myLogName}.stdout.log" 2> ".Test-Results/${myLogName}.stderr.log"
}

## Test `myRunTest`.

myRunTest 'ls' 'Tests/run/myRunTest'
myRunTest 'ls' 'Tests/run/myRunTest' 'Tests.run.myRunTest.non-default-log-name'

## Test `list.bash`.

myRunTest '../list.bash' '_lib/valid-files' 'list.valid-files'
myRunTest '../list.bash' 'list/excluded-items'
myRunTest '../list.bash' 'list/folder-contents'
myRunTest '../list.bash' 'list/MMM-to-MM'

## Test `review.bash`

myRunTest '../review.bash' '_lib/valid-files' 'review.valid-files'
myRunTest '../review.bash' 'review/missing-elements'
myRunTest '../review.bash' 'review/skipped-items'
myRunTest '../review.bash' 'review/spellchecking'
myRunTest '../review.bash' 'review/trailing-whitespaces'

# List test result changes.
git status --porcelain .Test-Results/
