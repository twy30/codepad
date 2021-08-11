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

    local -r myLogName=${myTestCaseName//\//.}
    "${myCommand}" Test-Cases/"${myTestCaseName}"/* > "Test-Results/${myLogName}.stdout.log" 2> "Test-Results/${myLogName}.stderr.log"
}

myRunTest '../review.bash' 'baseline'
myRunTest '../review.bash' 'file-end-bytes'
myRunTest '../review.bash' 'file-start-bytes'
myRunTest '../review.bash' 'skipping'
myRunTest '../review.bash' 'spellchecking'
myRunTest '../review.bash' 'trailing-white-spaces'

# List test result changes.
git status --porcelain Test-Results/
