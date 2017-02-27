#!/bin/bash

# This script generates the .skip files needed for each part of the
# experiement.  These are used with the cppmt tracking pipeline
# to set the frame on which to supply the initial bounding box


participants=$(find Attention/P??_*.txt  -printf "%f\n" | cut -c1-3)

echo $participants
for p in $participants; do
	echo generating skipfiles for $p

./abc-display-tool/abc-extractAttention.py --attentionfile Attention/${p}_attention.txt  --skipfile TrackingV2/cppMTPart1/${p}_front.skip --participant ${p} --event start1 --externaleventfile Attention/transitionAnnotations.csv ; 



./abc-display-tool/abc-extractAttention.py --attentionfile Attention/${p}_attention.txt  --skipfile TrackingV2/cppMTPart2/${p}_front.skip --participant ${p} --event start2 --externaleventfile Attention/transitionAnnotations.csv ; 

done;
