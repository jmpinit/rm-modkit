#!/bin/bash

# Tries to safely update customized system files after a ReMarkable update
# has overwritten them

set -o errexit

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
REMARKABLE_IMAGE_PATH=/usr/share/remarkable

# Usage: safe_file_replace SOURCE_FILE DESTINATION_FILE
# Only copies if destination and source exist
# Returns error code otherwise
safe_file_replace() {
  SOURCE_FILE=$1
  DEST_FILE=$2

  if [ ! -f "$SOURCE_FILE" ]; then
    return 1
  fi

  if [ ! -f "$DEST_FILE" ]; then
    return 1
  fi

  cp "$SOURCE_FILE" "$DEST_FILE"
}

install_image() {
  IMAGE_NAME=$1

  safe_file_replace "$SCRIPT_DIR/images/$IMAGE_NAME" "$REMARKABLE_IMAGE_PATH/$IMAGE_NAME"
}

for image in "$SCRIPT_DIR/images"/*.png; do
  IMAGE_NAME=$(basename $image)
  install_image "$IMAGE_NAME"
done

