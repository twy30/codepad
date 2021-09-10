. "`dirname "$0"`"/../../lib.bash
myCdToInvokingFileFolder
mkdir Results
date --iso-8601=ns > Results/file.e2bd9ba6-3115-4b69-9a62-1cead8c6d27f
trap 'rm --recursive Results' EXIT
myPurgeTestResults
git status --porcelain Results/
