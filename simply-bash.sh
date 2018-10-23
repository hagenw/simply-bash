# Simply-bash main file
# Source this file in your ~/.bashrc. Afterwards all scripts are available and
# all libraries can be added by `include library.sh`

readonly SIMPLY_BASH_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)

PATH="${PATH}:${SIMPLY_BASH_PATH}"

# $1 - library file
# NOTE: include needs to be a function that gets sourced. If it would be a bash
#       script `source` would not work.
include() {
    local file=$1
    source "${SIMPLY_BASH_PATH}/${file}"
}

# Load python environment functions `activate`, `envs`, `create`
include 'pyenvs.sh'

# Load all completions
include 'completion/activate-completion.bash'
include 'completion/delete-completion.bash'
include 'completion/envs-completion.bash'
include 'completion/is-completion.bash'

# Make visible in other functions
export SIMPLY_BASH_PATH
export -f include
