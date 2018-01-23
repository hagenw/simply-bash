# Simply-bash main file
# Source this file in your ~/.bashrc. Afterwards all scripts are available and
# all libraries can be added by `include library.sh`

readonly SIMPLY_BASH_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)

include() {
    local file=$1

    source "${SIMPLY_BASH_PATH}/${file}"
}

PATH="${PATH}:${SIMPLY_BASH_PATH}"
