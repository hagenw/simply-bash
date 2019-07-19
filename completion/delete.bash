#
# Bash completion definition for delete
#
_delete() {
    local current environments
    current="${COMP_WORDS[COMP_CWORD]}"
    environments="$(envs)"
    COMPREPLY=( $(compgen -W "${environments}" -- ${current}) )
    return 0
}
complete -F _delete delete
