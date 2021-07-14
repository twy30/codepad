#!/bin/bash
# Version: 2021-Jul-13 16:16:56

# Shared code.

readonly myBaseName=$(basename "${0}")
if [ -t 1 ]
then
    readonly myBrightYellow=$'\e[93m'
    readonly myReset=$'\e[m'
fi

readonly myBashHeaderStart=$'#!/bin/bash\n# Version: '
readonly myDefaultSortableInputFileVersion='0000000000000000000'
readonly myFileVersionExample='0000-XXX-00 00:00:00'
readonly myFileVersionRegexp='^[[:digit:]]{4}-[[:alpha:]]{3}-[[:digit:]]{2} [[:digit:]]{2}:[[:digit:]]{2}:[[:digit:]]{2}$'
readonly myMarkdownHeaderStart=$'---\nVersion: '

readonly myBashVersionEndOffset=$((${#myBashHeaderStart} + ${#myFileVersionExample}))
readonly myMarkdownVersionEndOffset=$((${#myMarkdownHeaderStart} + ${#myFileVersionExample}))

function myGetExtensionName {
    local -r myInputPath=${1}

    local -r myInputBaseName=$(basename "${myInputPath}")
    if [[ "${myInputBaseName}" == *.* ]]
    then
        echo -n "${myInputBaseName##*.}"
    fi
}

function myGetBashFileVersion {
    local -r myInputFilePath=${1}

    echo -n "$(head --bytes=${myBashVersionEndOffset} "${myInputFilePath}" | tail --bytes=${#myFileVersionExample})"
}

function myGetMarkdownFileVersion {
    local -r myInputFilePath=${1}

    echo -n "$(head --bytes=${myMarkdownVersionEndOffset} "${myInputFilePath}" | tail --bytes=${#myFileVersionExample})"
}

function myEcho {
    local myString=${1}

    echo "${myBaseName}: ${myString}"
}

function myGetFileVersion {
    local -r myInputFilePath=${1}

    if [ ! -f "${myInputFilePath}" -o ! -r "${myInputFilePath}" ]
    then
        echo -n "${myDefaultSortableInputFileVersion}"
        return 1
    fi

    case "$(myGetExtensionName "${myInputFilePath}")" in
        'bash')
            local -r myInputFileVersion=$(myGetBashFileVersion "${myInputFilePath}")
        ;;

        'md')
            local -r myInputFileVersion=$(myGetMarkdownFileVersion "${myInputFilePath}")
        ;;
    esac

    if [[ "${myInputFileVersion}" =~ ${myFileVersionRegexp} ]]
    then
        local mySortableInputFileVersion=${myInputFileVersion}
        mySortableInputFileVersion=${mySortableInputFileVersion/Jan/01}
        mySortableInputFileVersion=${mySortableInputFileVersion/Feb/02}
        mySortableInputFileVersion=${mySortableInputFileVersion/Mar/03}
        mySortableInputFileVersion=${mySortableInputFileVersion/Apr/04}
        mySortableInputFileVersion=${mySortableInputFileVersion/May/05}
        mySortableInputFileVersion=${mySortableInputFileVersion/Jun/06}
        mySortableInputFileVersion=${mySortableInputFileVersion/Jul/07}
        mySortableInputFileVersion=${mySortableInputFileVersion/Aug/08}
        mySortableInputFileVersion=${mySortableInputFileVersion/Sep/09}
        mySortableInputFileVersion=${mySortableInputFileVersion/Oct/10}
        mySortableInputFileVersion=${mySortableInputFileVersion/Nov/11}
        mySortableInputFileVersion=${mySortableInputFileVersion/Dec/12}
        mySortableInputFileVersion=$(echo -n "${mySortableInputFileVersion}" | sed --regexp-extended 's/[[:alpha:]]{3}/00/')
        echo -n "${mySortableInputFileVersion}"
    else
        echo -n "${myDefaultSortableInputFileVersion}"
    fi
}

function myGetFileVersionView {
    local -r myInputFilePath=${1}

    echo "$(myGetFileVersion "${myInputFilePath}") ${myInputFilePath}"
}
