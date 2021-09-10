#!/bin/bash

# SYNOPSIS
#
# spellcheck.bash FILE

# DESCRIPTION
#
# Spellcheck FILE's path and contents.

# FILE
#
# FILE must be a readable regular file.

# Import the shared library.
. "`dirname "$0"`"/../Bash/lib.bash

# Get FILE's path.
readonly myFilePath=$1

# Spellcheck FILE's path.
readonly myPathTypos=`echo -n "$myFilePath" | aspell --mode=none list | sort --unique`
if [ "$myPathTypos" ]
then
    if ! echo -n "$myFilePath" | grep --color=auto --word-regexp "$myPathTypos"
    then
        echo -n "$myFilePath" | grep --color=auto "$myPathTypos"
    fi
    myEcho $'Path typo(s):\n'"$myPathTypos"
fi

myExitIfNotRegularFile "$myFilePath"

myExitIfNotReadable "$myFilePath"

# Spellcheck FILE's contents.
readonly myContentsTypos=`aspell --mode=none list < "$myFilePath" | sort --unique`
if [ "$myContentsTypos" ]
then
    if ! echo -n "$myContentsTypos" | grep --color=auto --file=- --line-number --word-regexp "$myFilePath"
    then
        echo -n "$myContentsTypos" | grep --color=auto --file=- --line-number "$myFilePath"
    fi
    myEcho $'Contents typo(s):\n'"$myContentsTypos"
fi
