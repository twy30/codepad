#!/bin/bash

# SYNOPSIS
#
# run.bash

# DESCRIPTION
#
# Run all tests; then list all test result changes.

# Set working folder.
cd "`dirname "$0"`"

# Purge all test results.
rm --recursive Results
mkdir Results

# Run tests.
function myRunTest {
    local -r myTestPath=$1

    local -r myResultPath=Results/$myTestPath
    mkdir --parents "$myResultPath"
    bash Cases/"$myTestPath" > "$myResultPath"/stdout.log 2> "$myResultPath"/stderr.log
}
readonly -f myRunTest
myRunTest _lib/Error-Not-a-regular-file.bash
myRunTest _lib/Error-Not-in-a-Git-repository.bash
myRunTest _lib/Error-Not-readable.bash
myRunTest identify/Error-With-some-uncommitted-change.bash
myRunTest identify/identify.bash
myRunTest list/Error-Not-a-folder.bash
myRunTest list/list-a.bash
myRunTest list/list-minimum-Git-commit-age.bash
myRunTest list/list-o.bash
myRunTest list/list-only-oldest.bash
myRunTest spellcheck/spellcheck_no-word-regexp.bash
myRunTest spellcheck/spellcheck.bash
myRunTest Tests/run/myRunTest.bash
myRunTest validate/Information-Empty.bash
myRunTest validate/validate.bash
myRunTest validate/Violation-First-byte-not-printable.bash
myRunTest validate/Violation-Last-byte-not-newline.bash
myRunTest validate/Violation-With-carriage-return.bash
myRunTest validate/Violation-With-trailing-whitespace.bash

# List all test result changes.
git status --porcelain Results/
