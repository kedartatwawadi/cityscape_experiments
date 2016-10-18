#!/bin/bash

val_dir=~/Videos/leftImg8bit/val
base_dir=~/Videos/leftImg8bit_sequence/frankfurt_videos/temp_folder_x265/x265_crf
code_path=/home/kedartatwawadi/code/video_compression/LRR/LRRTestOnCityScape.m
log_path=/home/kedartatwawadi/Videos/leftImg8bit_sequence/cityscape_experiments/logs/log_obj_detect_exp_x265_crf

cd $val_dir
rm -r frankfurt/

for crf in `seq 0 8 32`
do
    cp -r $base_dir$crf/frankfurt $val_dir
    matlab -nodisplay -nodesktop -r "run $code_path; quit" | tee -a $log_path$crf.txt 
done
