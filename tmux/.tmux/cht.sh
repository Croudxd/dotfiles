#!/bin/bash

read -p "Enter Query: " query

if [ -z "$query" ]; then
    exit 0
fi

# Clean the query (spaces to +)
clean_query=$(echo "$query" | tr ' ' '+')
target_url="cheat.sh/$clean_query"

# Debug print (so you know it's working)
echo "Fetching $target_url..."

# Fetch content to a variable first to check for errors
# We use curl with a 5-second timeout to prevent hanging
if ! result=$(curl -s --max-time 5 "$target_url"); then
    echo "Error: Curl failed. Check your internet connection."
    read -p "Press Enter to close..."
    exit 1
fi

# Check if cheat.sh returned an empty response
if [ -z "$result" ]; then
    echo "Error: Got empty response from cheat.sh."
    read -p "Press Enter to close..."
    exit 1
fi

# If we get here, we have data.
# Open the RESULT in a new popup using `less`
# We use 'printf' to ensure the data is passed safely
tmux display-popup -E -w 80% -h 80% -b rounded -T " $query " \
    "printf '%s' \"$result\" | less -R"
