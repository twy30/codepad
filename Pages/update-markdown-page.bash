#!/bin/bash

# SYNOPSIS
#
# update-markdown-page.bash FOLDER

# DESCRIPTION
#
# Update Markdown contents under FOLDER/Pages.

# FOLDER
#
# The folder containing the Pages folder.

# Import the shared library.
. "`dirname "$0"`"/../Bash/lib.bash

# Get FOLDER's path.
readonly myFolderPath=$1
myExitIfNotFolder "$myFolderPath"
readonly myRealFolderPath=`realpath "$myFolderPath"`

myAddPageFilePaths_PagesFolder "$myRealFolderPath"/Pages

myCdToInvokingFileFolder

./publish-lib.bash

Lib/ConsoleApp/bin/myPublish/ConsoleApp UpdateMarkdownPage "${myPageFilePaths[@]}"
