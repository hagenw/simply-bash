#
# Bash completion definition for activate
#
_activate() {
    local current environments
    current="${COMP_WORDS[COMP_CWORD]}"
    environments="$(envs)"
    COMPREPLY=( $(compgen -W "${environments}" -- ${current}) )
    return 0
}
complete -F _activate activate
