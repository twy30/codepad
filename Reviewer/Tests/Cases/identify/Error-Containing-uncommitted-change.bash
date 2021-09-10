. "`dirname "$0"`"/../../../../Bash/lib.bash
myCdToInvokingFileFolder
readonly myTestFile=untracked.6e0b7a22-bd77-4e26-9105-47f5eac406ce
> "$myTestFile"
trap 'rm "$myTestFile"' EXIT
../../../identify.bash "$myTestFile"
