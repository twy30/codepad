#!/bin/bash

# SYNOPSIS
#
# apply-template-template.bash TEMPLATE [PAGE]...

# DESCRIPTION
#
# Apply TEMPLATE to PAGE.

# TEMPLATE
#
# The template file's path.

# PAGE
#
# The page files' paths.

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

Lib/ConsoleApp/bin/myPublish/ConsoleApp ApplyTemplateTemplate "$myRealTemplateFilePath" "${myPageFilePaths[@]}"
