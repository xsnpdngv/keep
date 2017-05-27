#!/bin/bash
# script to secure delete files

# select a command to delete with
sdel="rm -f"
command -v gshred >/dev/null 2>&1 && sdel="gshred -zvun 5"
command -v  shred >/dev/null 2>&1 && sdel="shred -zvun 5"

# read user input and perform delete
echo -n "Secure delete: $@? (y/N) "
read is_sdel
[ "$is_sdel" = "y" -o "$is_sdel" = "Y" ] && \
$sdel "$@"
