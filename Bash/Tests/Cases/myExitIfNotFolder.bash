. "`dirname "$0"`"/../../lib.bash
myCdToInvokingFileFolder
myExitIfNotFolder .
echo 'Success'
myExitIfNotFolder
echo 'Error: Failure' >&2
