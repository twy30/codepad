# The shared library.

readonly myBaseName=`basename "$0"`

function myCdToInvokingFileFolder {
    cd "`dirname "$0"`"
}
readonly -f myCdToInvokingFileFolder

function myListTestResultChanges {
    git status --porcelain Results/
}
readonly -f myListTestResultChanges

declare -a myPageFilePaths

function myPurgeTestResults {
    rm --recursive Results
    mkdir Results
}
readonly -f myPurgeTestResults

function myRunTest {
    local -r myTestPath=$1

    local -r myResultPath=Results/$myTestPath
    mkdir --parents "$myResultPath"
    bash Cases/"$myTestPath" > "$myResultPath"/stdout.log 2> "$myResultPath"/stderr.log
}
readonly -f myRunTest

# ---

function myAddPageFilePaths {
    local myPath
    for myPath
    do
        myPageFilePaths+=("`realpath "$myPath"`")
    done
}
readonly -f myAddPageFilePaths

function myAddPageFilePaths_PagesFolder {
    local myPath=$1

    mapfile -d '' < <(find "$myPath" -mindepth 1 -maxdepth 1 -type f -name '*.html' -print0)
    myPageFilePaths+=(${MAPFILE[@]})
    mapfile -d '' < <(find "$myPath" -mindepth 2 -maxdepth 2 -type f -name 'index.html' -print0)
    myPageFilePaths+=(${MAPFILE[@]})
}
readonly -f myAddPageFilePaths_PagesFolder

function myAddPageFilePaths_RootPageFolder {
    local myPath=$1

    myPageFilePaths+=("$myPath"/index.html)
    myPageFilePaths+=("$myPath"/404.html)
}
readonly -f myAddPageFilePaths_RootPageFolder

function myEcho {
    local -r myMessage=$1

    echo "$myBaseName: $myMessage"
}
readonly -f myEcho

# ---

function myExitIfNotFolder {
    local -r myPath=$1

    if [ ! -d "$myPath" ]
    then
        myEcho "Error: Not a folder: \`"$myPath"\`" >&2
        exit 1
    fi
}
readonly -f myExitIfNotFolder

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
