#!/bin/bash

source config.ini
val_dir=~/Videos/leftImg8bit/val
base_dir=~/Videos/leftImg8bit_sequence/frankfurt_videos/temp_folder_$codec/"$codec"_crf
code_path=/home/kedartatwawadi/code/video_compression/LRR/LRRTestOnCityScape.m
log_path=/home/kedartatwawadi/Videos/leftImg8bit_sequence/cityscape_experiments/logs/"$codec"_logs/log_obj_detect_exp_"$codec"_crf

cd $val_dir
rm -r frankfurt/

for crf in $crf_list
do
    cp -r $base_dir$crf/frankfurt $val_dir
    matlab -nodisplay -nodesktop -r "run $code_path; quit" | tee -a $log_path$crf.txt 
done
