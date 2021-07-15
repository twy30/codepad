#!/bin/bash
# Version: 2021-Jul-15 01:32:02

# Shared code.

function myGetExtensionName {
    local -r myInputFilePath=${1}

    local -r myInputFileBaseName=$(basename "${myInputFilePath}")
    if [[ "${myInputFileBaseName}" = *.* ]]
    then
        echo -n "${myInputFileBaseName##*.}"
    fi
}

readonly myBashHeaderStart=$'#!/bin/bash\n# Version: '
readonly myFileVersionExample='0000-XXX-00 00:00:00'
readonly myBashVersionEndOffset=$((${#myBashHeaderStart} + ${#myFileVersionExample}))

function myGetBashFileVersion {
    local -r myInputFilePath=${1}

    echo -n "$(head --bytes=${myBashVersionEndOffset} "${myInputFilePath}" | tail --bytes=${#myFileVersionExample})"
}

readonly myMarkdownHeaderStart=$'---\nVersion: '
readonly myMarkdownVersionEndOffset=$((${#myMarkdownHeaderStart} + ${#myFileVersionExample}))

function myGetMarkdownFileVersion {
    local -r myInputFilePath=${1}

    echo -n "$(head --bytes=${myMarkdownVersionEndOffset} "${myInputFilePath}" | tail --bytes=${#myFileVersionExample})"
}

readonly myDefaultSortableInputFileVersion='0000000000000000000'
readonly myFileVersionRegexp='^([[:digit:]]{4}-)(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)(-[[:digit:]]{2} [[:digit:]]{2}:[[:digit:]]{2}:[[:digit:]]{2})$'
readonly -A myMMMtoMM=( \
    ['Jan']='01'        \
    ['Feb']='02'        \
    ['Mar']='03'        \
    ['Apr']='04'        \
    ['May']='05'        \
    ['Jun']='06'        \
    ['Jul']='07'        \
    ['Aug']='08'        \
    ['Sep']='09'        \
    ['Oct']='10'        \
    ['Nov']='11'        \
    ['Dec']='12')

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
        echo -n "${BASH_REMATCH[1]}${myMMMtoMM["${BASH_REMATCH[2]}"]}${BASH_REMATCH[3]}"
    else
        echo -n "${myDefaultSortableInputFileVersion}"
    fi
}

function myListFileVersion {
    local -r myInputFilePath=${1}

    echo "$(myGetFileVersion "${myInputFilePath}") ${myInputFilePath}"
}
