. "`dirname "$0"`"/../../lib.bash
readonly myWorkingFolderPathBeforeTest=`pwd`
readonly myExpectedWorkingFolderPathAfterTest=`realpath "$(dirname "$0")"`
myCdToInvokingFileFolder
readonly myActualWorkingFolderPathAfterTest=`pwd`
if [ "$myActualWorkingFolderPathAfterTest" = "$myWorkingFolderPathBeforeTest" ]
then
    echo 'Error: Inconclusive' >&2
fi
if [ "$myActualWorkingFolderPathAfterTest" != "$myExpectedWorkingFolderPathAfterTest" ]
then
    echo 'Error: Failure' >&2
fi
