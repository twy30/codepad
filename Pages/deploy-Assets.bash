#!/bin/bash

# SYNOPSIS
#
# deploy-Assets.bash FOLDER

# DESCRIPTION
#
# Deploy the Assets to FOLDER.

# FOLDER
#
# The folder containing the "Assets" folder.

# Import the shared library.
. "`dirname "$0"`"/../Bash/lib.bash

# Get FOLDER's path.
readonly myFolderPath=$1
myExitIfNotFolder "$myFolderPath"
readonly myRealFolderPath=`realpath "$myFolderPath"`

myCdToInvokingFileFolder

# Deploy Assets.
readonly myDeployedAssetsFolderPath="$myRealFolderPath"/Assets
if [ -e "$myDeployedAssetsFolderPath" ]
then
    rm --recursive "$myDeployedAssetsFolderPath"
fi
cp --recursive Assets "$myRealFolderPath"
