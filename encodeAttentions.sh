#!/bin/bash

# Copy the CppMT tracking data to the DIS folder, and encode attentions
mkdir Groundtruth

participants=$(find ./Attention/P??_attention.txt  -printf "%f\n" | cut -c1-3)

echo $participants

for p in $participants; do


	echo Encoding participant: $p;

#	cp ../spot_the_difference/attention/${p}_attention.txt ./Attention/

	./abc-display-tool/abc-extractAttention.py --attentionfile ./Attention/${p}_attention.txt --outputfile ./Groundtruth/${p}_groundtruth.csv --participant ${p}

done;


