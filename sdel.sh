#!/bin/bash
# ==========================================================================
# @file    sdel.sh
# @brief   shell script to secure delete files
# @author  Tamas Dezso <dezso.t.tamas@gmail.com>
# @date    May 30, 2017
#
# In case [g]shred is available, FILE(s) given as command line
# arguments are going to be securely deleted, otherwise a simple
# remove command (rm -f) will take place.
# ==========================================================================

# check whether [g]shred is available to delete with
sdel="rm -f"
command -v gshred >/dev/null 2>&1 && sdel="gshred -zvun 5"
command -v  shred >/dev/null 2>&1 && sdel="shred -zvun 5"

# read user input and perform delete
echo -n "Delete ($sdel) file(s): $@? (y/N) "; read is_sdel
[[ "${is_sdel:0:1}" =~ [yY] ]] && $sdel "$@"
