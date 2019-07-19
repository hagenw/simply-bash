#
# Bash completion definition for is.
#
_is () {
    local cur prev not articles opts
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    not=" not "
    articles=" a an the "
    opts=" file dir directory link symlink existing readable writeable "
    opts+="executable available installed empty number older newer "
    opts+="gt lt ge le equal matching substring true false "

    if is substring " ${prev} " "${opts}"; then
        COMPREPLY=()
    elif is substring " ${prev} " "${articles}"; then
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
    elif is substring " ${prev} " "${not}"; then
        COMPREPLY=( $(compgen -W "${articles}${opts}" -- ${cur}) )
    else
        COMPREPLY=( $(compgen -W "${not}${articles}${opts}" -- ${cur}) )
    fi
    return 0
}
complete -F _is is
