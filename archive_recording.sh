#!/bin/sh

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
DIR="$1"

command -v flac >/dev/null 2>&1 || { echo >&2 "flac encoder doesn't appear to be installed.  Aborting."; exit 1; }

find $DIR -type f -iname "*.wav" -exec flac -4V --keep-foreign-metadata {} \;
