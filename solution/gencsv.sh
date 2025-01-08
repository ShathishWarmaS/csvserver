#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <start_index> <end_index>"
    exit 1
fi

start=$1
end=$2
output_file="inputFile"

# Overwrite the file (or create if it doesn't exist)
> $output_file

# Generate the sequence with random numbers
for i in $(seq "$start" "$end"); do
    echo "$i, $RANDOM" >> "$output_file"
done

echo "File $output_file generated successfully."