#
# Bash completion definition for envs
#
_envs() {
    local current arguments
    current="${COMP_WORDS[COMP_CWORD]}"
    arguments="conda pip help tool"
    COMPREPLY=( $(compgen -W "${arguments}" -- ${current}) )
    return 0
}
complete -F _envs envs
