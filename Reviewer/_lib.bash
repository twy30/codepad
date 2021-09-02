# DESCRIPTION
#
# The shared library.

readonly myBaseName=`basename "$0"`

# ---

function myEcho {
    local -r myMessage=$1

    echo "$myBaseName: $myMessage"
}
readonly -f myEcho

# ---

function myExitIfNotReadable {
    local -r myPath=$1

    if [ ! -r "$myPath" ]
    then
        myEcho "Error: Not readable: \`$myPath\`" >&2
        exit 1
    fi
}
readonly -f myExitIfNotReadable

function myExitIfNotRegularFile {
    local -r myPath=$1

    if [ ! -f "$myPath" ]
    then
        myEcho "Error: Not a regular file: \`$myPath\`" >&2
        exit 1
    fi
}
readonly -f myExitIfNotRegularFile

function myExitIfWorkingFolderNotInGitRepository {
    local -r myErrorMessageItemName=$1

    if [ "`git rev-parse --is-inside-work-tree 2> /dev/null`" != true ]
    then
        myEcho "Error: Not in a Git repository: \`$myErrorMessageItemName\`" >&2
        exit 1
    fi
}
readonly -f myExitIfWorkingFolderNotInGitRepository
