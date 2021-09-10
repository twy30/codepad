. "`dirname "$0"`"/../../lib.bash
myCdToInvokingFileFolder
mkdir Results
date --iso-8601=ns > Results/file.feb4f196-19fa-446e-a824-d62062d7ccac
trap 'rm --recursive Results' EXIT
myListTestResultChanges
