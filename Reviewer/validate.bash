#!/bin/bash

# SYNOPSIS
#
# validate.bash FILE

# DESCRIPTION
#
# Validate FILE's format; then list violations.

# FILE
#
# FILE must be a readable regular file.

# Import the shared library.
. "`dirname "$0"`"/_lib.bash

# Get FILE's path.
readonly myFilePath=$1

#
myExitIfNotRegularFile "$myFilePath"

#
myExitIfNotReadable "$myFilePath"

# Exit if FILE is empty.
if [ ! -s "$myFilePath" ]
then
    myEcho "Information: Empty: \`$myFilePath\`"
    exit 0
fi

# Verify that FILE's first byte is printable.
if [[ ! "`head --bytes=1 "$myFilePath"`" =~ ^[[:print:]]$ ]]
then
    myEcho "Violation: First byte not printable: \`$myFilePath\`"
fi

# Verify that FILE's last byte is newline.
if [ "`tail --bytes=1 "$myFilePath" | od --format=c`" != $'0000000  \\n\n0000001' ]
then
    myEcho "Violation: Last byte not newline: \`$myFilePath\`"
fi

# Verify that FILE does not contain carriage return.
if grep --silent $'\r' "$myFilePath"
then
    myEcho "Violation: With carriage return: \`$myFilePath\`"
fi

# Verify that FILE does not contain trailing whitespace.
if grep --regexp=[[:space:]]$ --silent "$myFilePath"
then
    myEcho "Violation: With trailing whitespace: \`$myFilePath\`"
fi
