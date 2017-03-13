#!/bin/bash

# Generate the tracking files needed for the DIS extended abstract:


participants=$(find ./video/P??_front.mp4 -printf "%f\n" | cut -c1-3)

echo $participants


mkdir Tracking

# We run CppMT tracking on each part of the experiment separately, 
# since there's a risk of the bounding box drifted.  For each we run
# CppMT tracking until the very end of the video
# (This isn't efficient, TODO: extract the relavent frames from the video
# and only run on these)
for a in 1 2; do
mkdir cppMTPart${a}
# Generate frame skip times
for p in $participants; do
	./abc-display-tool/abc-extractAttention.py --attentionfile Attention/${p}_attention.txt --participant $p --externaleventfile Attention/transitionAnnotations.csv --event start${a} --skipfile  cppMTPart${a}/${p}_front.skip;

done;
# Initalise tracking for these participants
#idi-init-tracking `pwd`/video/ `pwd`/cppMTPart${a}/

# Or copy pre-specified bounding boxes
echo "Copying pre-supplied bounding boxes"
for p in $participants; do
	cp InitialBoundingBoxes/part${a}/${p}_front.bbox cppMTPart${a}/
done;

done;

for a in 1 2; do

	idi-track `pwd`/video/ `pwd`/cppMTPart${a}/
done;

# Copy and rename the tracking files
for a in 1 2; do
for p in $participants; do
        echo Copying participant: $p;

        cp ./cppMTPart${a}/${p}_front.csv  ./Tracking/${p}_part${a}_front_cppMT.csv;
        gzip ./Tracking/${p}_part${a}_front_cppMT.csv;



done;
done;

# Run the Openface tracker
echo "Running openface"
docker run -it --rm --name=openface --user `id -u` --volume `pwd`/video/:/idinteraction/videos:ro --volume `pwd`/Tracking/:/idinteraction/output idinteraction/openface:2.1
echo "Compressing openface"
for o in ./Tracking/*.openface; do
	gzip $o;
done;

