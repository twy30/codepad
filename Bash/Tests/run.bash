#!/bin/bash

# SYNOPSIS
#
# run.bash

# DESCRIPTION
#
# Run all tests; then list all test result changes.

# Import the shared library.
. "`dirname "$0"`"/../lib.bash

myCdToInvokingFileFolder

myExitIfNotFolder Results

myPurgeTestResults

myRunTest myCdToInvokingFileFolder.bash
myRunTest myEcho.bash
myRunTest myExitIfNotFolder.bash
myRunTest myExitIfNotReadable.bash
myRunTest myExitIfNotRegularFile.bash
myRunTest myExitIfWorkingFolderNotInGitRepository.bash
myRunTest myListTestResultChanges.bash
myRunTest myPurgeTestResults.bash
myRunTest myRunTest-Test.bash

myListTestResultChanges
