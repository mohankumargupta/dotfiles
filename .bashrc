# 'c' alias: Search files and folders, then navigate to the destination directory
alias c='_fzf_cd'
_fzf_cd() {
    local target
    target=$(fd --hidden --exclude .git 2>/dev/null | fzf --prompt="Navigate: ")
    
    if [ -n "$target" ]; then
        if [ -d "$target" ]; then
            cd "$target"
        elif [ -f "$target" ]; then
            cd "$(dirname "$target")"
        fi
    fi
}

# 'm' alias: Search files only, then open the selection in the Micro editor
alias m='_fzf_micro'
_fzf_micro() {
    local file
    file=$(fd --type f --hidden --exclude .git 2>/dev/null | fzf --prompt="Edit with Micro: ")
    
    if [ -n "$file" ]; then
        micro "$file"
    fi
}

