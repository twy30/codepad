#!/bin/bash

# SYNOPSIS
#
# identify.bash [OPTION]... [--] FILE

# DESCRIPTION
#
# List FILE's identity information.

# OPTION
#
# -t, --test-friendly
#
#   Be test-friendly.

# FILE
#
# * FILE must be in a Git repository.
# * FILE must not have any uncommitted change.

# Import the shared library.
. "`dirname "$0"`"/_lib.bash

# Process the arguments.
if ! myArguments=`getopt --longoptions=test-friendly --name="$myBaseName" --options=t -- "$@"`
then
    exit 1
fi
readonly myArguments
eval set -- "$myArguments"
while true
do
    case "$1" in
        --)
            shift
            break
        ;;

        -t|--test-friendly)
            readonly myTestFriendlySwitch=
        ;;
    esac
    shift
done

# Get FILE's path.
readonly myFilePath=$1
myExitIfNotRegularFile "$myFilePath"
readonly myRealFilePath=`realpath "$myFilePath"`

# Set the working folder.  Git commands require this.
cd "`dirname "$myRealFilePath"`"

#
myExitIfWorkingFolderNotInGitRepository "$myFilePath"

# Exit if FILE has any uncommitted change, including "untracked".
if [ "`git status --porcelain -- "$myRealFilePath"`" ]
then
    myEcho "Error: With some uncommitted change: \`$myFilePath\`" >&2
    exit 1
fi

# Use a hardcoded timestamp when testing.
if [ -v myTestFriendlySwitch ]
then
    readonly myTimestamp=`date --date=@0 --iso-8601=seconds --utc`
else
    readonly myTimestamp=`date --iso-8601=seconds`
fi

# Output.
echo ---
echo "Timestamp: $myTimestamp"
echo "Path: `git ls-files --full-name -- "$myRealFilePath"`"
echo "Version: `git log --format=format:%H --max-count=1 -- "$myRealFilePath"`"
echo ---
