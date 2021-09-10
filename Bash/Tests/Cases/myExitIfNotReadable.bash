. "`dirname "$0"`"/../../lib.bash
myCdToInvokingFileFolder
readonly myTestFilePath=not-readable.80162f5c-b163-4528-a795-c4e419c7f2f0
> "$myTestFilePath"
myExitIfNotReadable "$myTestFilePath"
echo 'Success'
chmod -r "$myTestFilePath"
trap 'rm "$myTestFilePath"' EXIT
myExitIfNotReadable "$myTestFilePath"
echo 'Error: Failure' >&2
