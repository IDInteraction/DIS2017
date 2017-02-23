#!/bin/bash

# Copy the CppMT tracking data to the DIS folder

participants=$(find ../spot_the_difference/cppmtTracking/P??_front*.csv  -printf "%f\n" | cut -c1-3)

echo $participants

for p in $participants; do
	echo Copying participant: $p;

	cp ../spot_the_difference/cppmtTracking/${p}_front.csv  ./Tracking/${p}_part1_front_cppMT.csv;
	gzip ./Tracking/${p}_part1_front_cppMT.csv;


	cp ../spot_the_difference/cppmtTrackingPart2/${p}_front.csv  ./Tracking/${p}_part2_front_cppMT.csv;
	gzip ./Tracking/${p}_part2_front_cppMT.csv;

done;

