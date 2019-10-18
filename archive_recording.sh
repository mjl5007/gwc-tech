#!/bin/sh

if [[ $# -ne 1 ]]; then
    echo "error: Invalid number of arguments."
    echo "usage: ${0##*/} path_to_recording_folder"
    exit -1
fi
