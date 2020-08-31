#!/bin/bash
# Removes binaries, header files, data files installed by 
# find_orb. Does not remove the supporting repositories
# If -g flag is passed, will also delete supporting git repositories.
BIN=~/bin
INCLUDE=~/include
LIB=~/lib

repos=false
while getopts "g" option
do
    case "${option}" in
        g) repos=true;;
    esac
done

echo "Uninstalling find_orb."
rm -rf -v ~/.find_orb

# Remove binaries from ~/bin/
array=("astcheck" "find_orb" "fo" "sat_id")
for i in "${array[@]}"
do
    rm -v $BIN/$i
done

# Remove header files from ~/include/
array=("afuncs.h" "cgi_func.h" "date.h" "jpleph.h" \
       "mpc_func.h" "showelem.h" "watdefs.h" \
       "brentmin.h" "comets.h" "get_bin.h" \
       "lunar.h" "norad.h" "vislimit.h")
for i in "${array[@]}"
do
    rm -v $INCLUDE/$i
done

# Remove supporting libraries
array=("libjpl.a" "liblunar.a" "libsatell.a")
for i in "${array[@]}"
do
    rm -v $LIB/$i
done

# If desired, remove git repositories
array=("lunar" "jpl_eph" "sat_code" "miscell")
if [ repos==true ]
then
    for repo in "${array[@]}"; do
        if [ -f ../$repo ]
        then
            rm -rf -v ../$repo
        fi
    done
fi
exit