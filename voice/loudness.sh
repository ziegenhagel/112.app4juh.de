#!/bin/bash

# Check if ffmpeg is installed
if ! command -v ffmpeg &>/dev/null; then
    echo "ffmpeg is not installed. Please install it first."
    exit 1
fi

# Create a temporary directory to store the processed files
temp_dir=$(mktemp -d)

# Loop through all .mp3 files in the current directory
for file in *.mp3; do
    # Set the output file name
    output_file="${temp_dir}/${file}"

    # Increase the loudness to 0 dB using the loudnorm filter
    ffmpeg -i "$file" -af "loudnorm=I=-16:TP=-1.5:LRA=11" "$output_file"

    # Rename the output file to the original file name
    mv "$output_file" "$file"
done

# Clean up temporary directory
rmdir "$temp_dir"

echo "Loudness adjustment completed."
