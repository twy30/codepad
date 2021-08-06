#!/bin/bash
# Version: 2021-Aug-05 20:41:45

# list.bash [FILE]...
#
# List and sort FILE by its `Version` property.  If FILE is a folder,
# its contents will be listed recursively.
#
# `.?*`, `bin`, and `obj` folders are excluded.
#
# `*.log` files are excluded.

. "$(dirname "${0}")/_lib.bash"

function myListCommand {
    local myFilePath
    local -Ar myMMMtoMM=(['Jan']='01' ['Feb']='02' ['Mar']='03' ['Apr']='04' ['May']='05' ['Jun']='06' ['Jul']='07' ['Aug']='08' ['Sep']='09' ['Oct']='10' ['Nov']='11' ['Dec']='12')
    for myFilePath
    do
        if [ -d "${myFilePath}" ]
        then
            find "${myFilePath}" \
                \( -type d \( -name '.?*' -o -name 'bin' -o -name 'obj' \) -prune \) \
                -o \( -type f \! -name '*.log' -print0 \) \
            | ( mapfile -d ''; myListCommand "${MAPFILE[@]}" )
        elif [ -f "${myFilePath}" ]
        then
            if [[ "$(myActByFileType "${myFilePath}" 'myGet_' '_FileVersion')" =~ ${myVersionRegexp} ]]
            then
                echo -n "${BASH_REMATCH[1]}${myMMMtoMM[${BASH_REMATCH[2]}]}${BASH_REMATCH[3]}"
            else
                echo -n '0000-00-00 00:00:00'
            fi

            echo " ${myFilePath}"
        fi
    done
}

myListCommand "${@}" | sort --reverse
