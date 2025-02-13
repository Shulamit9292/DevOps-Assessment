#!/bin/bash

show_help() {
    echo "Usage: extract [-h] [-r] [-v] file [file...]"
    echo "-h  Show help"
    echo "-r  Recursive mode"
    echo "-v  Verbose mode"
}

recursive=false
verbose=false

while getopts "hrv" opt; do
    case $opt in
        h) show_help; exit 0 ;;
        r) recursive=true ;;
        v) verbose=true ;;
        *) show_help; exit 1 ;;
    esac
done
shift $((OPTIND -1))

extract_file() {
    local file="$1"
    local type=$(file --mime-type -b "$file")

    case "$type" in
        application/gzip) gunzip -f "$file" ;;
        application/x-bzip2) bunzip2 -f "$file" ;;
        application/zip) unzip -o "$file" ;;
        application/x-compress) uncompress -f "$file" ;;
        *) [[ "$verbose" == true ]] && echo "Skipping: $file (unknown type)" ;;
    esac
}

if [[ "$recursive" == true ]]; then
    find . -type f -exec bash -c 'extract_file "$0"' {} \;
else
    for file in "$@"; do
        extract_file "$file"
    done
fi
