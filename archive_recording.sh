#!/bin/sh

set -e

usage () {
    echo "usage: ${0##*/} path_to_recording_folder"
}

if [[ $# -ne 1 ]]; then
    echo "error: Invalid number of arguments."
    usage
    exit -1
fi

if [ ! -d "$1" ]; then
    echo "error: \"$1\" not a valid directory path."
    usage
    exit -2
fi

command -v flac >/dev/null 2>&1 || { echo >&2 "flac encoder doesn't appear to be installed.  Aborting."; exit 1; }
command -v 7zr >/dev/null 2>&1 || { echo >&2 "7zr doesn't appear to be installed.  Aborting."; exit 1; }

cd "$1"
DIR=$(basename "$(pwd)")
cd ..

echo "Compressing *.wav files in $(pwd)/$DIR ...\n"

NUM_WAVS=$(find "$DIR" -type f -iname "*.wav" | wc -l)
if [ $NUM_WAVS -eq 0 ]; then
    echo "warning: no *.wav files found."
else
    find "$DIR" -type f -iname "*.wav" -exec flac -4V --keep-foreign-metadata --delete-input-file {} \;
fi

ARCHIVE_NAME="$DIR.7z"
echo "Archiving directory to file $ARCHIVE_NAME ...\n"

if [ -f "$ARCHIVE_NAME" ]; then
    echo "error: 7z archive $ARCHIVE_NAME already exists; aborting."
else
    7zr a "$ARCHIVE_NAME" "$DIR"
fi
