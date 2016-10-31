#!/bin/bash

source config.ini

vid_dir=/media/kedar/cfc96f03-783a-4353-be5f-c72a490aa372/kedar/frankfurt_videos/"$codec"_crf
temp_dir=~/Videos/leftImg8bit_sequence/temp_folder_$codec/"$codec"_crf

for crf in $crf_list
do
    cd $vid_dir$crf/frankfurt
    mkdir -p $temp_dir$crf/frankfurt
    cp *.png  $temp_dir$crf/frankfurt   
done

