#!/bin/bash
# Version: 2021-Jul-06 19:39:41

# validate.bash [_Input_File_Path_1_ _Input_File_Path_2_ ...]
#
# Validate input files' formats.

myFileVersionRegexp='^[[:digit:]]{4}-[[:alpha:]]{3}-[[:digit:]]{2} [[:digit:]]{2}:[[:digit:]]{2}:[[:digit:]]{2}$'

function myValidateFile {
    local myInputFilePath=${1}

    if [ ! -f "${myInputFilePath}" ]
    then
        echo "$(basename "${0}"): \`${myInputFilePath}\` must be a file." >&2
        return 1
    fi

    local myInputFileName=$(basename "${myInputFilePath}")
    local myInputFileExtensionName=${myInputFileName##*.}
    case "${myInputFileExtensionName}" in
        'bash')
            if [ $'#!/bin/bash\n# Version: ' != "$(head --bytes=23 "${myInputFilePath}")" ]
            then
                echo "${myInputFilePath}: Incorrect header start"
            fi

            if [[ ! "$(head --bytes=43 "${myInputFilePath}" | tail --bytes=20)" =~ $myFileVersionRegexp ]]
            then
                echo "${myInputFilePath}: Incorrect version"
            fi

            if [ $'0000000 0a0a                                   \n0000002' != "$(head --bytes=45 "${myInputFilePath}" | tail --bytes=2 | hexdump)" ]
            then
                echo "${myInputFilePath}: Incorrect header end"
            fi
        ;;

        'md')
            if [ $'---\nVersion: ' != "$(head --bytes=13 "${myInputFilePath}")" ]
            then
                echo "${myInputFilePath}: Incorrect header start"
            fi

            if [[ ! "$(head --bytes=33 "${myInputFilePath}" | tail --bytes=20)" =~ $myFileVersionRegexp ]]
            then
                echo "${myInputFilePath}: Incorrect version"
            fi

            if [ $'0000000 2d0a 2d2d 0a0a                         \n0000006' != "$(head --bytes=39 "${myInputFilePath}" | tail --bytes=6 | hexdump)" ]
            then
                echo "${myInputFilePath}: Incorrect header end"
            fi
        ;;
    esac

    if [ $'0000000 000a                                   \n0000001' != "$(tail --bytes=1 "${myInputFilePath}" | hexdump)" ]
    then
        echo "${myInputFilePath}: Missing end-of-file newline"
    fi

    grep --silent $'\r' "${myInputFilePath}"
    if [ "${?}" -eq 0 ]
    then
        echo "${myInputFilePath}: Unexpected carriage return"
    fi

    grep --regexp='\s$' --silent "${myInputFilePath}"
    if [ "${?}" -eq 0 ]
    then
        echo "${myInputFilePath}: Unexpected trailing whitespace"
    fi
}

for myInputFilePath in "$@"
do
    myValidateFile "${myInputFilePath}"
done
