#!/bin/bash
# Version: 2021-Jul-06 19:39:20

# list.bash _Input_Folder_Path_
#
# List files by their versions.

myInputFolderPath=${1:-.}

if [ ! -d "${myInputFolderPath}" ]
then
    echo "$(basename "${0}"): \`${myInputFolderPath}\` must be a folder." >&2
    exit 2
fi

export myFileVersionRegexp='^[^V]*Version: [[:digit:]]{4}-[[:alpha:]]{3}-[[:digit:]]{2} [[:digit:]]{2}:[[:digit:]]{2}:[[:digit:]]{2}$'

function myGetFileVersion {
    local myInputFilePath=${1}

    if [ ! -f "${myInputFilePath}" ]
    then
        echo "$(basename "${0}"): \`${myInputFilePath}\` must be a file." >&2
        return 1
    fi

    local myInputFileVersion=
    local myInputFileName=$(basename "${myInputFilePath}")
    local myInputFileExtensionName=${myInputFileName##*.}
    case "${myInputFileExtensionName}" in
        'bash')
            myInputFileVersion=$(head --lines=2 "${myInputFilePath}" | tail --lines=1)
        ;;

        'md')
            myInputFileVersion=$(head --lines=2 "${myInputFilePath}" | tail --lines=1)
        ;;
    esac

    local myInputFileSortableVersion='0000000000000000000'
    if [[ "${myInputFileVersion}" =~ ${myFileVersionRegexp} ]]
    then
        myInputFileSortableVersion=${myInputFileVersion##*Version: }
        myInputFileSortableVersion=${myInputFileSortableVersion/Jan/01}
        myInputFileSortableVersion=${myInputFileSortableVersion/Feb/02}
        myInputFileSortableVersion=${myInputFileSortableVersion/Mar/03}
        myInputFileSortableVersion=${myInputFileSortableVersion/Apr/04}
        myInputFileSortableVersion=${myInputFileSortableVersion/May/05}
        myInputFileSortableVersion=${myInputFileSortableVersion/Jun/06}
        myInputFileSortableVersion=${myInputFileSortableVersion/Jul/07}
        myInputFileSortableVersion=${myInputFileSortableVersion/Aug/08}
        myInputFileSortableVersion=${myInputFileSortableVersion/Sep/09}
        myInputFileSortableVersion=${myInputFileSortableVersion/Oct/10}
        myInputFileSortableVersion=${myInputFileSortableVersion/Nov/11}
        myInputFileSortableVersion=${myInputFileSortableVersion/Dec/12}
        myInputFileSortableVersion=$(echo -n "${myInputFileSortableVersion}" | sed --regexp-extended 's/[[:alpha:]]{3}/00/')
    fi

    echo "${myInputFileSortableVersion} ${myInputFilePath}"
}
export -f myGetFileVersion

find "${myInputFolderPath}" -type f -not -name '*.log' -exec bash -c 'myGetFileVersion "${0}"' '{}' \; | sort --reverse
