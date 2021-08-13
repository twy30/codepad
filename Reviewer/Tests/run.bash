#!/bin/bash

# run.bash
#
# Run all tests; then list test result changes.

cd "$(dirname "${0}")"

# Purge test results.
rm --recursive Test-Results/*

# Run tests.

function myRunTest {
    local -r myCommand=${1}
    local -r myTestCaseName=${2}
    local -r myLogName=${3:-${myTestCaseName//\//.}}

    "${myCommand}" Test-Cases/"${myTestCaseName}"/* > "Test-Results/${myLogName}.stdout.log" 2> "Test-Results/${myLogName}.stderr.log"
}

myRunTest '../identify.bash' '_lib/baseline' 'identify.baseline'
myRunTest '../identify.bash' 'identify/skipping'

myRunTest '../review.bash' '_lib/baseline' 'review.baseline'
myRunTest '../review.bash' 'review/file-end-bytes'
myRunTest '../review.bash' 'review/file-start-bytes'
myRunTest '../review.bash' 'review/skipping'
myRunTest '../review.bash' 'review/spellchecking'
myRunTest '../review.bash' 'review/trailing-white-spaces'

# List test result changes.
git status --porcelain Test-Results/
