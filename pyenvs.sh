# Python virtual environments library

# Path of all virtual environments
readonly ENVDIR="${HOME}/.envs"

# List available virtual environments
envs() {
    ls "${ENVDIR}"
}

# Activate selected virtual environment for python
# $1 - name of environment
activate() {
    local env=$1
    local nargs=$#

    if is not equal "${nargs}" 1; then
        echo 'Usage: activate $ENV_NAME'
        return
    fi

    if is dir "${ENVDIR}/${env}"; then
        source "${ENVDIR}/${env}/bin/activate"
    else
        error "Virtual environment ${env} does not exist!"
    fi
}

# Create a virtual environment for python and activate it
# $1 - name of environment
# $2 - optional python interpreter, default: "python3"
create() {
    local env=$1
    local python=${2:-python3}
    local nargs=$#

    if is lt "${nargs}" 1 || is gt "${nargs}" 2; then
        echo 'Usage: create $ENVNAME [$PYTHON_INTERPRETER]'
        return
    fi

    if is equal "${python}" "python2" || is equal "${python}" "python3"; then
        python="/usr/bin/${python}"
    else
        error 'The second argument must be "python2" or "python3"'
    fi

    virtualenv --python="${python}" --no-site-packages "${ENVDIR}/${env}"
    activate "${env}"
}
