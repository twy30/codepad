# Shared code.

function myEcho {
    local -r myMessage=${1}

    echo "$(basename "${0}"): ${myMessage}"
}
