#!/bin/bash
# Version: 2021-Aug-08 06:40:41

# review.bash [FILE]...
#
# List feedback for FILE.

. "$(dirname "${0}")/_lib.bash"

function myReview_bash_File {
    local -r myFilePath=${1}

    if [ "$(head --bytes=${#my_bash_HeaderStart} "${myFilePath}")" != "${my_bash_HeaderStart}" ]
    then
        myEchoWarning "${myFilePath}" 'header start'
    fi

    if [[ ! "$(myGet_bash_FileVersion "${myFilePath}")" =~ ${myVersionRegexp} ]]
    then
        myEchoWarning "${myFilePath}" 'version'
    fi

    local -r my_bash_HeaderEnd=$'\n\n'
    if [ "$(head --bytes=$((${#my_bash_HeaderStart} + ${#myVersionSample} + ${#my_bash_HeaderEnd})) "${myFilePath}" | tail --bytes=${#my_bash_HeaderEnd} | od --format=x1)" != "$(echo -n "${my_bash_HeaderEnd}" | od --format=x1)" ]
    then
        myEchoWarning "${myFilePath}" 'header end'
    fi
}

function myReview_cs_File {
    local -r myFilePath=${1}

    if [ "$(head --bytes=${#my_cs_HeaderStart} "${myFilePath}")" != "${my_cs_HeaderStart}" ]
    then
        myEchoWarning "${myFilePath}" 'header start'
    fi

    if [[ ! "$(myGet_cs_FileVersion "${myFilePath}")" =~ ${myVersionRegexp} ]]
    then
        myEchoWarning "${myFilePath}" 'version'
    fi

    local -r my_cs_HeaderEnd=$'\n\n'
    if [ "$(head --bytes=$((${#my_cs_HeaderStart} + ${#myVersionSample} + ${#my_cs_HeaderEnd})) "${myFilePath}" | tail --bytes=${#my_cs_HeaderEnd} | od --format=x1)" != "$(echo -n "${my_cs_HeaderEnd}" | od --format=x1)" ]
    then
        myEchoWarning "${myFilePath}" 'header end'
    fi
}

function myReview_csproj_File {
    local -r myFilePath=${1}

    if [ "$(head --bytes=${#my_csproj_HeaderStart} "${myFilePath}")" != "${my_csproj_HeaderStart}" ]
    then
        myEchoWarning "${myFilePath}" 'header start'
    fi

    if [[ ! "$(myGet_csproj_FileVersion "${myFilePath}")" =~ ${myVersionRegexp} ]]
    then
        myEchoWarning "${myFilePath}" 'version'
    fi

    local -r my_csproj_HeaderEnd=$'\n\n'
    if [ "$(head --bytes=$((${#my_csproj_HeaderStart} + ${#myVersionSample} + ${#my_csproj_HeaderEnd})) "${myFilePath}" | tail --bytes=${#my_csproj_HeaderEnd} | od --format=x1)" != "$(echo -n "${my_csproj_HeaderEnd}" | od --format=x1)" ]
    then
        myEchoWarning "${myFilePath}" 'header end'
    fi
}

function myReview_css_File {
    local -r myFilePath=${1}

    if [ "$(head --bytes=${#my_css_HeaderStart} "${myFilePath}")" != "${my_css_HeaderStart}" ]
    then
        myEchoWarning "${myFilePath}" 'header start'
    fi

    if [[ ! "$(myGet_css_FileVersion "${myFilePath}")" =~ ${myVersionRegexp} ]]
    then
        myEchoWarning "${myFilePath}" 'version'
    fi

    local -r my_css_HeaderEnd=$'\n\n'
    if [ "$(head --bytes=$((${#my_css_HeaderStart} + ${#myVersionSample} + ${#my_css_HeaderEnd})) "${myFilePath}" | tail --bytes=${#my_css_HeaderEnd} | od --format=x1)" != "$(echo -n "${my_css_HeaderEnd}" | od --format=x1)" ]
    then
        myEchoWarning "${myFilePath}" 'header end'
    fi
}

function myReview_gitignore_File {
    local -r myFilePath=${1}

    if [ "$(head --bytes=${#my_gitignore_HeaderStart} "${myFilePath}")" != "${my_gitignore_HeaderStart}" ]
    then
        myEchoWarning "${myFilePath}" 'header start'
    fi

    if [[ ! "$(myGet_gitignore_FileVersion "${myFilePath}")" =~ ${myVersionRegexp} ]]
    then
        myEchoWarning "${myFilePath}" 'version'
    fi

    local -r my_gitignore_HeaderEnd=$'\n\n'
    if [ "$(head --bytes=$((${#my_gitignore_HeaderStart} + ${#myVersionSample} + ${#my_gitignore_HeaderEnd})) "${myFilePath}" | tail --bytes=${#my_gitignore_HeaderEnd} | od --format=x1)" != "$(echo -n "${my_gitignore_HeaderEnd}" | od --format=x1)" ]
    then
        myEchoWarning "${myFilePath}" 'header end'
    fi
}

function myReview_html_File {
    local -r myFilePath=${1}

    if [ "$(head --bytes=${#my_html_HeaderStart} "${myFilePath}")" != "${my_html_HeaderStart}" ]
    then
        myEchoWarning "${myFilePath}" 'header start'
    fi

    if [[ ! "$(myGet_html_FileVersion "${myFilePath}")" =~ ${myVersionRegexp} ]]
    then
        myEchoWarning "${myFilePath}" 'version'
    fi

    local -r my_html_HeaderEnd=$' -->\n<!-- Version Ddv9CJi*WdVFd/5hW2o`hdrt;D7OhiD1;8dAuaJ9r -->\n\n'
    if [ "$(head --bytes=$((${#my_html_HeaderStart} + ${#myVersionSample} + ${#my_html_HeaderEnd})) "${myFilePath}" | tail --bytes=${#my_html_HeaderEnd} | od --format=x1)" != "$(echo -n "${my_html_HeaderEnd}" | od --format=x1)" ]
    then
        myEchoWarning "${myFilePath}" 'header end'
    fi
}

function myReview_js_File {
    local -r myFilePath=${1}

    if [ "$(head --bytes=${#my_js_HeaderStart} "${myFilePath}")" != "${my_js_HeaderStart}" ]
    then
        myEchoWarning "${myFilePath}" 'header start'
    fi

    if [[ ! "$(myGet_js_FileVersion "${myFilePath}")" =~ ${myVersionRegexp} ]]
    then
        myEchoWarning "${myFilePath}" 'version'
    fi

    local -r my_js_HeaderEnd=$'\n\n'
    if [ "$(head --bytes=$((${#my_js_HeaderStart} + ${#myVersionSample} + ${#my_js_HeaderEnd})) "${myFilePath}" | tail --bytes=${#my_js_HeaderEnd} | od --format=x1)" != "$(echo -n "${my_js_HeaderEnd}" | od --format=x1)" ]
    then
        myEchoWarning "${myFilePath}" 'header end'
    fi
}

function myReview_md_File {
    local -r myFilePath=${1}

    if [ "$(head --bytes=${#my_md_HeaderStart} "${myFilePath}")" != "${my_md_HeaderStart}" ]
    then
        myEchoWarning "${myFilePath}" 'header start'
    fi

    if [[ ! "$(myGet_md_FileVersion "${myFilePath}")" =~ ${myVersionRegexp} ]]
    then
        myEchoWarning "${myFilePath}" 'version'
    fi

    local -r my_md_HeaderEnd=$'\n---\n\n'
    if [ "$(head --bytes=$((${#my_md_HeaderStart} + ${#myVersionSample} + ${#my_md_HeaderEnd})) "${myFilePath}" | tail --bytes=${#my_md_HeaderEnd} | od --format=x1)" != "$(echo -n "${my_md_HeaderEnd}" | od --format=x1)" ]
    then
        myEchoWarning "${myFilePath}" 'header end'
    fi
}

function myReviewCommand {
    local myFilePath
    local -r myNewline=$'\n'
    for myFilePath
    do
        if [ ! -f "${myFilePath}" ]
        then
            continue
        fi

        if [ "$(tail --bytes=${#myNewline} "${myFilePath}" | od --format=x1)" != "$(echo -n "${myNewline}" | od --format=x1)" ]
        then
            myEchoWarning "${myFilePath}" 'end-of-file newline'
        fi

        if grep --silent $'\r' "${myFilePath}"
        then
            myEchoWarning "${myFilePath}" 'carriage return'
        fi

        if grep --regexp='[[:space:]]$' --silent "${myFilePath}"
        then
            myEchoWarning "${myFilePath}" 'trailing whitespace'
        fi

        myActByFileType "${myFilePath}" 'myReview_' '_File'
    done
}

myReviewCommand "${@}"
