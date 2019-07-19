#
# Bash completion definition for envs
#
_envs() {
    local current arguments
    current="${COMP_WORDS[COMP_CWORD]}"
    arguments="conda virtualenv help tool size location list"
    COMPREPLY=( $(compgen -W "${arguments}" -- ${current}) )
    return 0
}
complete -F _envs envs
