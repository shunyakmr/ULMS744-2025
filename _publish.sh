#! /bin/bash

# clear
# rm -r *_cache *_files

# render
quarto render

# track changes
git add .
git commit -m "$1"

# publish
git push

# Make it executable (first time only)
# chmod +x _publish.sh