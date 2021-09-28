#!/bin/bash

# Import the shared library.
. "`dirname "$0"`"/../Bash/lib.bash

myExitIfWorkingFolderNotInGitRepository .

find "`git rev-parse --show-toplevel`" \( -type d -name '.git' -prune \) -o \( -type d \! -perm 775 -ls \) -o \( -type f \! -perm 664 -ls \)
