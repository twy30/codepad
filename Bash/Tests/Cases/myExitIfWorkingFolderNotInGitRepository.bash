. "`dirname "$0"`"/../../lib.bash
myCdToInvokingFileFolder
myExitIfWorkingFolderNotInGitRepository .
echo 'Success'
readonly myTestFolder=/
cd "$myTestFolder"
myExitIfWorkingFolderNotInGitRepository "$myTestFolder"
echo 'Error: Failure' >&2
