#!/bin/bash

# Set the root directory where the search begins
TCF_ROOT="/path/to/your/GIT/REPO_NAME"  # Update this with your actual path

# Set the file extension to search for
fileExt="*.tcf"  # Change this if needed

echo "Searching for files with extension $fileExt in $TCF_ROOT and its subfolders..."

# Use the find command to search recursively for files matching the extension
find "$TCF_ROOT" -type f -name "$fileExt" | while read file; do
    /path/to/ldra/LDRAunit_C_CPP_9.8.6/Conunit "$file" -regress -quit
done
