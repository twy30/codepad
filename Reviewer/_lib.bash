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
    local -r myLocal_FilePath=$1

    if [ ! -r "$myLocal_FilePath" ]
    then
        myEcho "Error: Not readable: \`$myLocal_FilePath\`" >&2
        exit 1
    fi
}
readonly -f myExitIfNotReadable

function myExitIfNotRegularFile {
    local -r myLocal_FilePath=$1

    if [ ! -f "$myLocal_FilePath" ]
    then
        myEcho "Error: Not a regular file: \`$myLocal_FilePath\`" >&2
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
