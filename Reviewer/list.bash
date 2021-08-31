#!/bin/bash

# SYNOPSIS
#
# list.bash [OPTION]... [--] FOLDER

# DESCRIPTION
#
# List Git-committed files under FOLDER.

# OPTION
#
# -a, --minimum-Git-commit-age=DAYS
#
#   List only files whose latest commits are older than DAYS.
#
# -o, --only-oldest
#
#   List only files whose latest commits are the oldest.
#
# -t, --test-friendly
#
#   Be test-friendly.

# FOLDER
#
# Folder must be in a Git repository.

# Import the shared library.
. "`dirname "$0"`"/_lib.bash

# Process the arguments.
if ! myArguments=`getopt --longoptions=minimum-Git-commit-age:,only-oldest,test-friendly --name="$myBaseName" --options=a:ot -- "$@"`
then
    exit 1
fi
readonly myArguments
eval set -- "$myArguments"
declare -i myMinimumGitCommitAgeInSeconds=0
while true
do
    case "$1" in
        --)
            shift
            break
        ;;

        -a|--minimum-Git-commit-age)
            if [[ "$2" =~ ^[[:digit:]]+$ ]]
            then
                myMinimumGitCommitAgeInSeconds=$(($2 * 86400))
            fi
            shift
        ;;

        -o|--only-oldest)
            readonly myOnlyOldestSwitch=
        ;;

        -t|--test-friendly)
            readonly myTestFriendlySwitch=
        ;;
    esac
    shift
done
readonly myMinimumGitCommitAgeInSeconds

# Get FOLDER's path.
readonly myFolderPath=$1
if [ ! -d "$myFolderPath" ]
then
    myEcho "Error: Not a folder: \`"$myFolderPath"\`" >&2
    exit 1
fi
readonly myRealFolderPath=`realpath "$myFolderPath"`

# Set the working folder.  Git commands require this.
readonly myOriginalWorkingFolderPath=`pwd`
cd "$myRealFolderPath"

#
myExitIfWorkingFolderNotInGitRepository "$myFolderPath"

# Get FOLDER's files and their Git commit ages.
declare -i myFileGitCommitAgeInSeconds
declare -A myFileGitCommitAgesInSeconds
function myGetFileGitCommitAgeInSeconds {
    local -r myFilePath=$1

    if [ -v myTestFriendlySwitch ]
    then
        basename "$myFilePath"
    else
        echo "$(($myNowInSeconds - `git log --format=format:%ct --max-count=1 -- "$myFilePath"`))"
    fi
}
readonly -f myGetFileGitCommitAgeInSeconds
declare -i myMaximumFileGitCommitAgeInSeconds=0
declare -ir myNowInSeconds=`date +%s`
mapfile -d '' < <(git ls-tree --name-only -r -z HEAD -- "$myRealFolderPath")
for myFilePath in "${MAPFILE[@]}"
do
    myFileGitCommitAgeInSeconds=`myGetFileGitCommitAgeInSeconds "$myFilePath"`
    if [ $myMinimumGitCommitAgeInSeconds -le $myFileGitCommitAgeInSeconds ]
    then
        myFileGitCommitAgesInSeconds[$myFilePath]=$myFileGitCommitAgeInSeconds
        if [ $myMaximumFileGitCommitAgeInSeconds -lt $myFileGitCommitAgeInSeconds ]
        then
            myMaximumFileGitCommitAgeInSeconds=$myFileGitCommitAgeInSeconds
        fi
    fi
done
readonly myFileGitCommitAgesInSeconds
readonly myMaximumFileGitCommitAgeInSeconds

# Output.
function myOutput {
    local myFilePath
    if [ -v myOnlyOldestSwitch ]
    then
        for myFilePath in "${!myFileGitCommitAgesInSeconds[@]}"
        do
            if [ ${myFileGitCommitAgesInSeconds[$myFilePath]} -eq $myMaximumFileGitCommitAgeInSeconds ]
            then
                realpath --relative-to="$myOriginalWorkingFolderPath" "$myFilePath"
            fi
        done
    else
        for myFilePath in "${!myFileGitCommitAgesInSeconds[@]}"
        do
            realpath --relative-to="$myOriginalWorkingFolderPath" "$myFilePath"
        done
    fi
}
readonly -f myOutput
myOutput | sort
