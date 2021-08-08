#!/bin/bash
# Version: 2021-Aug-08 01:52:02

# Shared code.

function myEcho {
    local -r myMessage=${1}

    echo "$(basename "${0}"): ${myMessage}"
}

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
                myEcho "no \`${myFunctionName}\`" >&2
            fi
        fi
    fi
}

readonly myVersionSample='yyyy-MMM-dd HH:mm:ss'

readonly my_bash_HeaderStart=$'#!/bin/bash\n# Version: '
function myGet_bash_FileVersion {
    local -r myFilePath=${1}

    head --bytes=$((${#my_bash_HeaderStart} + ${#myVersionSample})) "${myFilePath}" | tail --bytes=${#myVersionSample}
}

readonly my_cs_HeaderStart=$'// Version: '
function myGet_cs_FileVersion {
    local -r myFilePath=${1}

    head --bytes=$((${#my_cs_HeaderStart} + ${#myVersionSample})) "${myFilePath}" | tail --bytes=${#myVersionSample}
}

readonly my_csproj_HeaderStart=$'<!--\nVersion: '
function myGet_csproj_FileVersion {
    local -r myFilePath=${1}

    head --bytes=$((${#my_csproj_HeaderStart} + ${#myVersionSample})) "${myFilePath}" | tail --bytes=${#myVersionSample}
}

readonly my_css_HeaderStart=$'/*\nVersion: '
function myGet_css_FileVersion {
    local -r myFilePath=${1}

    head --bytes=$((${#my_css_HeaderStart} + ${#myVersionSample})) "${myFilePath}" | tail --bytes=${#myVersionSample}
}

readonly my_gitignore_HeaderStart=$'# Version: '
function myGet_gitignore_FileVersion {
    local -r myFilePath=${1}

    head --bytes=$((${#my_gitignore_HeaderStart} + ${#myVersionSample})) "${myFilePath}" | tail --bytes=${#myVersionSample}
}

readonly my_html_HeaderStart=$'<!DOCTYPE html>\n<!-- Version QARATi`HL$m<xWb&6Bykj0Ra$El$%nov7BYjO*u>I -->\n<!-- Version: '
function myGet_html_FileVersion {
    local -r myFilePath=${1}

    head --bytes=$((${#my_html_HeaderStart} + ${#myVersionSample})) "${myFilePath}" | tail --bytes=${#myVersionSample}
}

readonly my_js_HeaderStart=$'// Version: '
function myGet_js_FileVersion {
    local -r myFilePath=${1}

    head --bytes=$((${#my_js_HeaderStart} + ${#myVersionSample})) "${myFilePath}" | tail --bytes=${#myVersionSample}
}

readonly my_md_HeaderStart=$'---\nVersion: '
function myGet_md_FileVersion {
    local -r myFilePath=${1}

    head --bytes=$((${#my_md_HeaderStart} + ${#myVersionSample})) "${myFilePath}" | tail --bytes=${#myVersionSample}
}

readonly myVersionRegexp='^([[:digit:]]{4}-)(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)(-[[:digit:]]{2} [[:digit:]]{2}:[[:digit:]]{2}:[[:digit:]]{2})$'
