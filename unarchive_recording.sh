#!/bin/sh

set -e

usage () {
    echo "usage: ${0##*/} recording_archive"
}

[ $# -eq 1 ] || ( echo "error: Invalid number of arguments."; usage; exit -1 )
[ -f "$1" ] || ( echo "error: \"$1\" not a valid file path."; usage; exit -2 )
[ "$(file -b --mime-type "$1")" == "application/x-7z-compressed" ] || ( echo "error: \"$1\" doesn't appear to be a .7z archive."; exit -3 )

command -v flac >/dev/null 2>&1 || { echo >&2 "flac encoder doesn't appear to be installed.  Aborting."; exit 1; }
command -v 7zr >/dev/null 2>&1 || { echo >&2 "7zr doesn't appear to be installed.  Aborting."; exit 1; }

DIR=$(dirname "$1")
FILE=$(basename "$1")
pushd "$DIR"

7zr x -oextract_temp "$FILE"
find extract_temp -type f -iname "*.flac" -exec flac -d --delete-input-file {} \;

popd