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

t() {
    # Ensure a URL was provided
    if [ -z "$1" ]; then
        echo "Error: Please provide a GitHub folder URL."
        return 1
    fi

    # Regex to extract: user (1), repo (2), branch (3), and subfolder path (4)
    if [[ "$1" =~ github\.com/([^/]+)/([^/]+)/tree/([^/]+)/(.*) ]]; then
        local user="${BASH_REMATCH[1]}"
        local repo="${BASH_REMATCH[2]}"
        local branch="${BASH_REMATCH[3]}"
        local subdir="${BASH_REMATCH[4]}"
        
        # Execute tiged using the current directory (.) as the destination
        npx tiged --force "$user/$repo/$subdir#$branch" .
    else
        echo "Error: Invalid GitHub subfolder URL format."
        echo "Expected format: https://github.com"
        return 1
    fi
}


