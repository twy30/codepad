#!/bin/bash

# SYNOPSIS
#
# publish-lib.bash [OPTION]...

# DESCRIPTION
#
# Publish Lib (if there is a newer version).

# OPTION
#
# -f, --force
#
#   Always publish.

# Import the shared library.
. "`dirname "$0"`"/../Bash/lib.bash

# Process the arguments.
if ! myArguments=`getopt --longoptions=force --name="$myBaseName" --options=f -- "$@"`
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

        -f|--force)
            readonly myForceSwitch=
        ;;
    esac
    shift
done

myCdToInvokingFileFolder

# Publish Lib.
readonly myLibVersion=`git log --format=format:%H --max-count=1 -- Lib/ConsoleApp/`
readonly myPublishFolderPath=Lib/ConsoleApp/bin/myPublish
readonly myPublishRecordPath="$myPublishFolderPath"/myLibVersion."$myLibVersion"
if [ ! -f "$myPublishRecordPath" -o -v myForceSwitch ]
then
    if [ -d "$myPublishFolderPath" ]
    then
        rm --recursive "$myPublishFolderPath"
    fi
    dotnet publish --configuration Release --output "$myPublishFolderPath" Lib/ConsoleApp
    date --iso-8601=ns > "$myPublishRecordPath"
fi
