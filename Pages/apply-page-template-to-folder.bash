#!/bin/bash

# SYNOPSIS
#
# apply-page-template-to-folder.bash TEMPLATE FOLDER

# DESCRIPTION
#
# Apply TEMPLATE to FOLDER.

# TEMPLATE
#
# The template file's path.

# FOLDER
#
# The root page folder's path.

# Import the shared library.
. "`dirname "$0"`"/../Bash/lib.bash

# Get TEMPLATE's path.
readonly myTemplateFilePath=$1
myExitIfNotRegularFile "$myTemplateFilePath"
readonly myRealTemplateFilePath=`realpath "$myTemplateFilePath"`

# Get FOLDER's path.
readonly myRootPageFolderPath=$2
myExitIfNotFolder "$myRootPageFolderPath"
readonly myRealRootPageFolderPath=`realpath "$myRootPageFolderPath"`

myAddPageFilePaths_RootPageFolder "$myRealRootPageFolderPath"
myAddPageFilePaths_PagesFolder "$myRealRootPageFolderPath"/Pages

myCdToInvokingFileFolder

./apply-page-template.bash "$myRealTemplateFilePath" "${myPageFilePaths[@]}"
