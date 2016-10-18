#!/bin/bash

vid_dir=~/Videos/leftImg8bit_sequence/frankfurt_videos/x265_crf
temp_dir=~/Videos/leftImg8bit_sequence/temp_folder_x265/x265_crf

for crf in 0 2 4 6 8 16 24 32
do
    cd $vid_dir$crf/frankfurt
    mkdir -p $temp_dir$crf/frankfurt
    cp *.png  $temp_dir$crf/frankfurt   
done

