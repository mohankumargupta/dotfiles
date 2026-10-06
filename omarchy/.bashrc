

# Function to pipe file content into wl-copy
c() {
    if [ -f "$1" ]; then
        wl-copy < "$1"
    else
        echo "Error: '$1' is not a valid file." >&2
        return 1
    fi
}

# Enable standard filename autocompletion for the 'c' function
complete -o filenames -A file c

