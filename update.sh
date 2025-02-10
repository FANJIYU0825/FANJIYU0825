#!/bin/bash

# Get the current day of the week (1 = Monday, 7 = Sunday)
DAY_OF_WEEK=$(date +"%u")

# Convert number (1-7) to weekday name
DAY_NAME=$(date +"%A")

# Detect OS type and set sed command accordingly
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS requires an empty string after -i
    sed -i '' "s|Today is \[\]|Today is $DAY_NAME|" README.md
else
    # Linux version
    sed -i "s|Today is \[\]|Today is $DAY_NAME|" README.md
fi

# Print confirmation message
echo "Updated README.md with today's day: $DAY_NAME"

DAY_OF_WEEK_NAME=$(date +"%A")
GIF_DIR="gifs/day_of_week/${DAY_OF_WEEK_NAME}"

echo "Looking for GIFs in: $GIF_DIR"
# Check if the directory exists and has GIFs
if [[ -d "$GIF_DIR" ]]; then
    echo "Directory exists: $GIF_DIR"
    
    # Debug: List files
    ls -l "$GIF_DIR"/*.gif 2>/dev/null

    if [[ $(ls "$GIF_DIR"/*.gif 2>/dev/null | wc -l) -gt 0 ]]; then
        # Select a random GIF
        SELECTED_DAY_OF_WEEK_GIF=$(ls gifs/day_of_week/${DAY_OF_WEEK_NAME}/*.gif | sort -R | head -n 1)

        echo "Selected GIF: $SELECTED_DAY_OF_WEEK_GIF"
        
        # Set it as an environment variable
        echo "SELECTED_DAY_OF_WEEK_GIF=$SELECTED_DAY_OF_WEEK_GIF" 
    else
        echo "⚠️ No GIFs found in $GIF_DIR"
    fi
else
    echo "❌ Directory does NOT exist: $GIF_DIR"
fi
