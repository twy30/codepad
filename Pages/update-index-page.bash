#!/bin/bash

# SYNOPSIS
#
# update-index-page.bash FOLDER

# DESCRIPTION
#
# Update index.html under FOLDER.

# FOLDER
#
# The folder containing:
# 1. index.html
# 2. Pages

# Import the shared library.
. "`dirname "$0"`"/../Bash/lib.bash

# Get FOLDER's path.
readonly myFolderPath=$1
myExitIfNotFolder "$myFolderPath"
readonly myRealFolderPath=`realpath "$myFolderPath"`

myIndexPageFilePath="$myRealFolderPath"/index.html

myAddPageFilePaths_PagesFolder "$myRealFolderPath"/Pages

myCdToInvokingFileFolder

./publish-lib.bash

Lib/ConsoleApp/bin/myPublish/ConsoleApp UpdateIndexPage "$myIndexPageFilePath" "${myPageFilePaths[@]}"
