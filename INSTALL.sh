#!/bin/bash
echo "Building find_orb and its dependencies."

repos=("lunar" "jpl_eph" "sat_code" "miscell")

# Make sure the supporting repos have been downloaded.
for repo in "${repos[@]}"; do
    if [ ! -d ../$repo ]
    then
        echo "Could not find the $repo repository!"
        echo "Please make sure you are in the find_orb repository and have run DOWNLOAD.sh."
        exit
    fi
done

# Make each dependency and find_orb
cd ../lunar \
    && make \
    && make install 
cd ../jpl_eph \
    && make libjpl.a \
    && make install 
cd ../lunar \
    && make integrat 
cd ../sat_code \
    && make sat_id \
    && make install 
cd ../find_orb \
    && make \
    && make install 

# Download DE430 if it hasn't already been downloaded.
JPL_EPH_FILE=~/.find_orb/linux_p1550p2650.430t
if [ ! -f "$JPL_EPH_FILE" ]; then 
    cd ~/.find_orb \
        && wget ftp://ssd.jpl.nasa.gov/pub/eph/planets/Linux/de430t/linux_p1550p2650.430t
fi

# Add executables to PATH
export PATH="$PATH:~/bin"
