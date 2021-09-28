#!/bin/bash

# ```Log
# Version: 1.58.2 (system setup)
# Commit: c3f126316369cd610563c75b1b1725e0679adfb3
# Date: 2021-07-14T22:10:15.214Z
# Electron: 12.0.13
# Chrome: 89.0.4389.128
# Node.js: 14.16.0
# V8: 8.9.255.25-electron.0
# OS: Windows_NT x64 10.0.19043
# ```
#
# ```JSON
# "files.exclude": {
#   "**/.git": true,
#   "**/.svn": true,
#   "**/.hg": true,
#   "**/CVS": true,
#   "**/.DS_Store": true
# }
# ```

# Import the shared library.
. "`dirname "$0"`"/../Bash/lib.bash

myExitIfWorkingFolderNotInGitRepository .

find "`git rev-parse --show-toplevel`" \( -name '.git' -o -name '.svn' -o -name '.hg' -o -name 'CVS' -o -name '.DS_Store' \)
