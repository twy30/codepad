#!/bin/bash

# SYNOPSIS
#
# identify.bash FILE

# DESCRIPTION
#
# List FILE's identity information.

# FILE
#
# * FILE must be in a Git repository.
# * FILE must not have any uncommitted change.

# Import the shared library.
. "`dirname "$0"`"/_lib.bash

# Get FILE's path.
readonly myFilePath=$1
myExitIfNotRegularFile "$myFilePath"
readonly myRealFilePath=`realpath "$myFilePath"`

# Set the working folder.
cd "`dirname "$myRealFilePath"`"

#
myExitIfWorkingFolderNotInGitRepository "$myFilePath"

# Exit if FILE has any uncommitted change, including "untracked".
if [ "`git status --porcelain -- "$myRealFilePath"`" ]
then
    myEcho "Error: With some uncommitted change: \`$myFilePath\`" >&2
    exit 1
fi

# Output.
echo ---
echo "Path: `git ls-files --full-name -- "$myRealFilePath"`"
echo "Version: `git log --format=format:%H --max-count=1 -- "$myRealFilePath"`"
echo ---
