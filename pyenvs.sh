# Python virtual environments library
#
# Commands for handling virtual environments with conda or virtualenv+pip:
# * envs
# * create
# * activate
# * deactivate
#
# For further documentation have a look in the README.md


# Default tool to manage virtual environments
export PYENVS_TOOL="pip"
export PYENVS_DIR="${HOME}/.envs"


# Switch between tools and list available virtual environments
# $1 - optional arguments
envs() {
    local tool=$1
    local nargs=$#
    local usage

    read -r -d '' usage <<- EOF
			Usage: envs [OPTIONS]

			List the available virtual environments.

			Options:
			    help       show this help message
			    conda      switch to conda and list environments
			    pip        switch to virtualenv and list environments
			    tool       show the tool currently used for environments
			EOF

    if is gt "${nargs}" 1; then
        echo "${usage}"
        return
    fi

    # List available envs
    if is equal "${nargs}" 0; then
        ls "${PYENVS_DIR}"
        return
    fi

    # Switch between conda and pip
    if is equal "${tool}" "pip"; then
        export PYENVS_TOOL="pip"
        export PYENVS_DIR="${HOME}/.envs"
        echo "# pip environments:"
        envs
    elif is equal "${tool}" "conda"; then
        export PYENVS_TOOL="conda"
        export PYENVS_DIR="${HOME}/.conda/envs"
        echo "# conda environments:"
        envs
    elif is equal "${tool}" "tool"; then
        echo "${PYENVS_TOOL}"
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

    if is dir "${PYENVS_DIR}/${env}"; then
        if is equal "${PYENVS_TOOL}" "pip"; then
            source "${PYENVS_DIR}/${env}/bin/activate"
        elif is equal "${PYENVS_TOOL}" "conda"; then
            source activate "${env}"
        fi
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
			Usage: create ENVNAME [VERSION]

			Create virtual environment ENVNAME and activate it.
			Optional you can specify the python VERSION to use, e.g.
			'2.7'. It uses conda or virtualenv as set by ´envs conda´ or
			´envs pip´.
			EOF

    if is lt "${nargs}" 1 || is gt "${nargs}" 2; then
        echo "${usage}"
        return
    fi

    if is not substring "${version:0:1}" "23"; then
        error 'The python version has to start with "2" or "3"'
    fi

    if is equal "${PYENVS_TOOL}" "pip"; then
        virtualenv \
            --python="/usr/bin/python${version}" \
            --no-site-packages "${PYENVS_DIR}/${env}"
    elif is equal "${PYENVS_TOOL}" "conda"; then
        conda create \
            --prefix "${PYENVS_DIR}/${env}" \
            python="${version}"
    fi
    activate "${env}"
}
