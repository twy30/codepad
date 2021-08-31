. "`dirname "$0"`"/../../../_lib.bash
cd "`dirname "$0"`"
readonly myTestFilePath=not-readable.80162f5c-b163-4528-a795-c4e419c7f2f0
> "$myTestFilePath"
chmod -r "$myTestFilePath"
trap 'rm "$myTestFilePath"' EXIT
myExitIfNotReadable "$myTestFilePath"
