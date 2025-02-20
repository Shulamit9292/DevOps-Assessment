#!/bin/bash

# Default values for flags
recursive=false
verbose=false

decrompressed_count=0
not_decompressed_count=0

# Function to display help message
show_help() {
    echo "Usage: extract [-h] [-r] [-v] file [file...]"
    echo "Options:"
    echo "  -h    Show help message"
    echo "  -r    Recursive mode (traverse directories)"
    echo "  -v    Verbose mode (print decompressed files and warnings)"
    exit 0
}

# Function to extract a single file
extract_file() {
    local file=$1
    local filetype=$(file -b --mime-type "$file")  # Detect file type based on MIME

    case "$filetype" in
        application/gzip)
            gunzip -f "$file" && ((decompressed_count++)) && $verbose && echo "Extracted: $file" ;;
        application/x-bzip2)
            bunzip2 -f "$file" && ((decompressed_count++)) && $verbose && echo "Extracted: $file" ;;
        application/zip)
            unzip -o "$file" && ((decompressed_count++)) && $verbose && echo "Extracted: $file" ;;
        application/x-compress)
            uncompress -f "$file" && ((decompressed_count++)) && $verbose && echo "Extracted: $file" ;;
        *)
            ((not_decompressed_count++))
            $verbose && echo "Warning: '$file' is not compressed or in an unsupported format"
        ;;
    esac
}

# Function to process directories in recursive mode
process_directory() {
    local dir=$1
    find "$dir" -type f | while read -r file; do
        extract_file "$file"
    done
}

# Parsing command-line options
while getopts ":hrv" opt; do
  case ${opt} in
    h ) show_help ;;  # Show help and exit
    r ) recursive=true ;;  # Enable recursive mode
    v ) verbose=true ;;  # Enable verbose output
    * ) show_help ;;  # Invalid option
  esac
done
shift $((OPTIND -1))  # Shift positional parameters to remove processed options

# If no files are provided, show an error and exit
if [ $# -eq 0 ]; then
    echo "Error: No files provided"
    show_help
fi

# Iterate over provided arguments and process files/directories
for target in "$@"; do
    if [ -d "$target" ] && [ "$recursive" = true ]; then
        process_directory "$target"  # Process entire directory if recursive mode is enabled
    elif [ -f "$target" ]; then
        extract_file "$target"  # Process a single file
    else
        $verbose && echo "Skipping '$target': Not a valid file or directory"
    fi
done

# Print summary
echo "Decompressed: $decompressed_count files"
echo "Not decompressed: $not_decompressed_count files"
exit $not_decompressed_count
