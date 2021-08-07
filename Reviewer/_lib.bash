#!/bin/bash
# Version: 2021-Aug-06 21:53:11

# Shared code.

function myActByFileType {
    local -r myFilePath=${1}
    local -r myFunctionNamePrefix=${2}
    local -r myFunctionNameSuffix=${3}

    local -r myFileBaseName=$(basename "${myFilePath}")
    if [[ "${myFileBaseName}" = *.* ]]
    then
        local -r myFileExtensionName=${myFileBaseName##*.}
        if [[ "${myFileExtensionName}" =~ ^[[:alpha:]]+$ ]]
        then
            local -r myFunctionName=${myFunctionNamePrefix}${myFileExtensionName}${myFunctionNameSuffix}
            if [ "$(type -t "${myFunctionName}")" = 'function' ]
            then
                "${myFunctionName}" "${myFilePath}"
            else
                echo "$(basename "${0}"): no \`${myFunctionName}\`" >&2
            fi
        fi
    fi
}

readonly my_bash_HeaderStart=$'#!/bin/bash\n# Version: '
readonly myVersionSample='yyyy-MMM-dd HH:mm:ss'
function myGet_bash_FileVersion {
    local -r myFilePath=${1}

    head --bytes=$((${#my_bash_HeaderStart} + ${#myVersionSample})) "${myFilePath}" | tail --bytes=${#myVersionSample}
}

readonly my_md_HeaderStart=$'---\nVersion: '
function myGet_md_FileVersion {
    local -r myFilePath=${1}

    head --bytes=$((${#my_md_HeaderStart} + ${#myVersionSample})) "${myFilePath}" | tail --bytes=${#myVersionSample}
}

readonly myVersionRegexp='^([[:digit:]]{4}-)(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)(-[[:digit:]]{2} [[:digit:]]{2}:[[:digit:]]{2}:[[:digit:]]{2})$'
