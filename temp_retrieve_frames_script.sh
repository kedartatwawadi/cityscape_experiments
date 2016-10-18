#!/bin/bash

vid_dir=/media/kedar/cfc96f03-783a-4353-be5f-c72a490aa372/kedar/frankfurt_videos/vp9_crf
temp_dir=~/Videos/leftImg8bit_sequence/temp_folder_vp9/vp9_crf

for crf in 0 2 4 6 8 16 24 32
do
    cd $vid_dir$crf/frankfurt
    mkdir -p $temp_dir$crf/frankfurt
    cp *.png  $temp_dir$crf/frankfurt   
done

