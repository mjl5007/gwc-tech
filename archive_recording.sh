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
