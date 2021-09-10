#!/bin/bash

# SYNOPSIS
#
# run.bash

# DESCRIPTION
#
# Run all tests; then list all test result changes.

# Import the shared library.
. "`dirname "$0"`"/../../Bash/lib.bash

myCdToInvokingFileFolder

myExitIfNotFolder Results

myPurgeTestResults

myRunTest identify/Error-Containing-uncommitted-change.bash
myRunTest identify/identify.bash
myRunTest list/list-a.bash
myRunTest list/list-minimum-Git-commit-age.bash
myRunTest list/list-o.bash
myRunTest list/list-only-oldest.bash
myRunTest spellcheck/spellcheck_no-word-regexp.bash
myRunTest spellcheck/spellcheck.bash
myRunTest validate/Information-Empty.bash
myRunTest validate/validate.bash
myRunTest validate/Violation-Containing-carriage-return.bash
myRunTest validate/Violation-Containing-trailing-whitespace.bash
myRunTest validate/Violation-First-byte-not-printable.bash
myRunTest validate/Violation-Last-byte-not-newline.bash

myListTestResultChanges
