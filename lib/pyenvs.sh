# Python virtual environments library
#
# Commands for handling virtual environments with conda or virtualenv:
# * envs
# * create
# * activate
# * deactivate
# * delete
#
# For further documentation have a look in the README.md


# Folders for storing the environments
export PYENVS_DIR_VIRTUALENV="${HOME}/.envs"
export PYENVS_DIR_CONDA="${HOME}/.conda/envs"

# Default tool to manage virtual environments
export PYENVS_TOOL="virtualenv"


# Switch between tools and list available virtual environments
# $1 - optional arguments
envs() {
    local command=$1
    local nargs=$#
    local usage

    read -r -d '' usage <<- EOF
		Usage: envs [OPTIONS]

		Handle Python virtual environments.

		Options:
		    help        show this help message
		    list        list environments (default command)
		    conda       switch to conda and list environments
		    virtualenv  switch to virtualenv and list environments
		    tool        show the tool currently used for environments
		    size        disk size of environments
		    location    dir where environments are stored

		Related external programs:
		    create ENVNAME [PYTHON_VERSION]
		    activate ENVNAME
		    deactivate
		    delete ENVNAME
		EOF

    if is gt "${nargs}" 1; then
        echo "${usage}"
        return
    fi

    # List available envs
    if is equal "${nargs}" 0; then
        ls "$(_envdir)"
        return
    fi
    if is equal "${command}" "list"; then
        ls "$(_envdir)"
    # Switch between conda and virtualenv
    elif is equal "${command}" "virtualenv"; then
        export PYENVS_TOOL="virtualenv"
        echo "# virtualenv environments:"
        envs
    elif is equal "${command}" "conda"; then
        export PYENVS_TOOL="conda"
        echo "# conda environments:"
        envs
    # Show current active tool (conda or virtualenv)
    elif is equal "${command}" "tool"; then
        echo "${PYENVS_TOOL}"
    # Show disk size
    elif is equal "${command}" "size"; then
        du -hs "$(_envdir)" | cut -f1
    # Show dir location
    elif is equal "${command}" "location"; then
        _envdir
    else
        echo "${usage}"
        return
    fi
}


# Activate selected virtual environment for python
# $1 - name of environment
activate() {
    local env=$1
    local nargs=$#
    local usage

    read -r -d '' usage <<- EOF
		Usage: activate ENVNAME

		Activate virtual environment ENVNAME.
		EOF

    if is not equal "${nargs}" 1; then
        echo "${usage}"
        return
    fi

    if is dir "$(_envdir)/${env}"; then
        if is equal "${PYENVS_TOOL}" "virtualenv"; then
            source "${PYENVS_DIR_VIRTUALENV}/${env}/bin/activate"
        elif is equal "${PYENVS_TOOL}" "conda"; then
            source activate "${env}"
            deactivate() { source deactivate; }
        fi
    else
        error "Virtual environment ${env} does not exist!"
    fi
}


# Delete virtual environment for python
# $1 - name of environment
delete() {
    local env=$1
    local nargs=$#
    local usage

    read -r -d '' usage <<- EOF
		Usage: delete ENVNAME

		Delete virtual environment ENVNAME.
		EOF

    if is not equal "${nargs}" 1; then
        echo "${usage}"
        return
    fi

    if is dir "$(_envdir)/${env}"; then
        rm -rf "$(_envdir)/${env}"
    else
        error "Virtual environment ${env} does not exist!"
    fi
}


# Create a virtual environment for python and activate it
# $1 - name of environment
# $2 - optional python version, default: "3"
create() {
    local env=$1
    local version=${2:-3}
    local nargs=$#
    local usage

    read -r -d '' usage <<- EOF
		Usage: create ENVNAME [PYTHON_VERSION]

		Create virtual environment ENVNAME and activate it.
		Optional you can specify the PYTHON_VERSION to use, e.g.
		'2.7'. It uses conda or virtualenv as set by ´envs conda´ or
		´envs virtualenv´.
		EOF

    if is lt "${nargs}" 1 || is gt "${nargs}" 2; then
        echo "${usage}"
        return
    fi

    if is not substring "${version:0:1}" "23"; then
        error 'The python version has to start with "2" or "3"'
    fi

    if is equal "${PYENVS_TOOL}" "virtualenv"; then
        virtualenv \
            --python="/usr/bin/python${version}" \
            "${PYENVS_DIR_VIRTUALENV}/${env}"
    elif is equal "${PYENVS_TOOL}" "conda"; then
        conda create \
            --yes \
            --prefix "${PYENVS_DIR_CONDA}/${env}" \
            python="${version}"
    fi
    activate "${env}"
}


# Helper function to select environment dir
_envdir() {
    if is equal "${PYENVS_TOOL}" "virtualenv"; then
        echo "${PYENVS_DIR_VIRTUALENV}"
    elif is equal "${PYENVS_TOOL}" "conda"; then
        echo "${PYENVS_DIR_CONDA}"
    fi
}
