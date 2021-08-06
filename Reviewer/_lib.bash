#!/bin/bash
# Version: 2021-Aug-05 20:01:50

# Shared code.

function myActByFileType {
    local -r myFilePath=${1}
    local -r myFunctionNamePrefix=${2}
    local -r myFunctionNameSuffix=${3}

    local -r myFileBaseName=$(basename "${myFilePath}")
    if [[ "${myFileBaseName}" != *.* ]]
    then
        return
    fi

    local -r myFileExtensionName=${myFileBaseName##*.}
    if [[ "${myFileExtensionName}" =~ ^[[:alpha:]]+$ ]]
    then
        ${myFunctionNamePrefix}${myFileExtensionName}${myFunctionNameSuffix} "${myFilePath}"
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
