#!/bin/bash

# SYNOPSIS
#
# apply-page-template.bash TEMPLATE [PAGE]...

# DESCRIPTION
#
# Apply TEMPLATE to PAGE.

# TEMPLATE
#
# The template file's path.

# PAGE
#
# The page file's path.

# Import the shared library.
. "`dirname "$0"`"/../Bash/lib.bash

# Get TEMPLATE's path.
readonly myTemplateFilePath=$1
myExitIfNotRegularFile "$myTemplateFilePath"
readonly myRealTemplateFilePath=`realpath "$myTemplateFilePath"`

shift
myAddPageFilePaths "$@"

myCdToInvokingFileFolder

./publish-lib.bash

Lib/ConsoleApp/bin/myPublish/ConsoleApp ApplyPageTemplate "$myRealTemplateFilePath" "${myPageFilePaths[@]}"
