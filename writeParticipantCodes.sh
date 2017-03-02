#!/bin/bash

find ./Groundtruth/P??_groundtruth.csv -printf "%f\n" | cut -c1-3 > participantcodes.csv


