. "`dirname "$0"`"/../../lib.bash
myCdToInvokingFileFolder
myExitIfNotRegularFile myExitIfNotRegularFile.bash
echo 'Success'
myExitIfNotRegularFile
echo 'Error: Failure' >&2
