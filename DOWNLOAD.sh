#!/bin/bash
# This script will download find_orb's dependencies into the 
# same directory one level up from this repository. Then end result
# will look as follows:
# ls ..
#   find_orb
#   jpl_eph
#   lunar
#   miscell
#   sat_code
repos=("lunar" "jpl_eph" "sat_code" "miscell")

# Make sure the supporting repos have been downloaded.
echo "Cloning required repositories."
for repo in "${repos[@]}"; do
    if [ ! -d ../$repo ]
    then
        git clone https://github.com/Bill-Gray/$repo.git ../$repo
    else
        echo "$repo already exists."
    fi
done
