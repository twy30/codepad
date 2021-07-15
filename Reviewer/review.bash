#!/bin/bash
# Version: 2021-Jul-15 01:31:30

# review.bash [FILE]...
#
# List feedback for FILE.

. "$(dirname "${0}")/_lib.bash"

readonly myBaseName=$(basename "${0}")

function myEcho {
    local -r myString=${1}

    echo "${myBaseName}: ${myString}"
}

readonly myBashHeaderEnd=$'\n\n'
readonly myMarkdownHeaderEnd=$'\n---\n\n'

if [ -t 1 ]
then
    readonly myBrightYellow=$'\e[93m'
    readonly myReset=$'\e[m'
fi

readonly myBashHeaderEndOffSet=$((${#myBashHeaderStart} + ${#myFileVersionExample} + ${#myBashHeaderEnd}))
readonly myMarkdownHeaderEndOffset=$((${#myMarkdownHeaderStart} + ${#myFileVersionExample} + ${#myMarkdownHeaderEnd}))

for myInputFilePath
do
    myEcho "\`${myInputFilePath}\`"

    echo -n "${myInputFilePath}" | grep --color=auto --word-regexp "$(echo -n "${myInputFilePath}" | aspell --mode=none list | sort --unique)"

    if [ ! -f "${myInputFilePath}" ]
    then
        myEcho "Skip non-regular file \`${myInputFilePath}\`."
        continue
    fi

    if [ ! -r "${myInputFilePath}" ]
    then
        myEcho "Skip unreadable file \`${myInputFilePath}\`."
        continue
    fi

    if [ ! -s "${myInputFilePath}" ]
    then
        myEcho "Skip empty file \`${myInputFilePath}\`."
        continue
    fi

    aspell --mode=none list < "${myInputFilePath}" | sort --unique | grep --color=auto --file=- --line-number --word-regexp "${myInputFilePath}"

    if [ "$(tail --bytes=1 "${myInputFilePath}" | hexdump -C)" != $'00000000  0a                                                |.|\n00000001' ]
    then
        myEcho "\`${myInputFilePath}\` ${myBrightYellow}ends with 0 newline${myReset}."
    elif [ "$(tail --bytes=2 "${myInputFilePath}" | hexdump -C)" == $'00000000  0a 0a                                             |..|\n00000002' ]
    then
        myEcho "\`${myInputFilePath}\` ${myBrightYellow}ends with more than 1 newline${myReset}."
    fi

    if grep --silent $'\r' "${myInputFilePath}"
    then
        myEcho "\`${myInputFilePath}\` ${myBrightYellow}contains at least 1 carriage return${myReset}."
    fi

    if grep --regexp='\s$' --silent "${myInputFilePath}"
    then
        myEcho "\`${myInputFilePath}\` ${myBrightYellow}contains at least 1 trailing whitespace${myReset}."
    fi

    case "$(myGetExtensionName "${myInputFilePath}")" in
        'bash')
            if [ "$(head --bytes=${#myBashHeaderStart} "${myInputFilePath}")" != "${myBashHeaderStart}" ]
            then
                myEcho "\`${myInputFilePath}\`'s ${myBrightYellow}header-start is invalid${myReset}."
            fi

            if [[ ! "$(myGetBashFileVersion "${myInputFilePath}")" =~ $myFileVersionRegexp ]]
            then
                myEcho "\`${myInputFilePath}\`'s ${myBrightYellow}version is invalid${myReset}."
            fi

            if [ "$(head --bytes=${myBashHeaderEndOffSet} "${myInputFilePath}" | tail --bytes=${#myBashHeaderEnd} | hexdump -C)" != $'00000000  0a 0a                                             |..|\n00000002' ]
            then
                myEcho "\`${myInputFilePath}\`'s ${myBrightYellow}header-end is invalid${myReset}."
            fi
        ;;

        'md')
            if [ "$(head --bytes=${#myMarkdownHeaderStart} "${myInputFilePath}")" != "${myMarkdownHeaderStart}" ]
            then
                myEcho "\`${myInputFilePath}\`'s ${myBrightYellow}header-start is invalid${myReset}."
            fi

            if [[ ! "$(myGetMarkdownFileVersion "${myInputFilePath}")" =~ $myFileVersionRegexp ]]
            then
                myEcho "\`${myInputFilePath}\`'s ${myBrightYellow}version is invalid${myReset}."
            fi

            if [ "$(head --bytes=${myMarkdownHeaderEndOffset} "${myInputFilePath}" | tail --bytes=${#myMarkdownHeaderEnd} | hexdump -C)" != $'00000000  0a 2d 2d 2d 0a 0a                                 |.---..|\n00000006' ]
            then
                myEcho "\`${myInputFilePath}\`'s ${myBrightYellow}header-end is invalid${myReset}."
            fi
        ;;
    esac
done
