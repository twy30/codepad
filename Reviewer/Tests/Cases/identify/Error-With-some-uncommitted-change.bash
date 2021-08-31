cd "`dirname "$0"`"
readonly myTestFile=untracked.6e0b7a22-bd77-4e26-9105-47f5eac406ce
> "$myTestFile"
../../../identify.bash "$myTestFile"
rm "$myTestFile"
