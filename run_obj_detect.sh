#!/bin/bash

val_dir=~/Videos/leftImg8bit/val
base_dir=~/Videos/leftImg8bit_sequence/frankfurt_videos/temp_folder_vp9/vp9_crf
code_path=/home/kedartatwawadi/code/video_compression/LRR/LRRTestOnCityScape.m
log_path=/home/kedartatwawadi/Videos/leftImg8bit_sequence/cityscape_experiments/logs/vp9_logs/log_obj_detect_exp_vp9_crf

cd $val_dir
rm -r frankfurt/

for crf in 0 2 4 6 8 16 24 32
do
    cp -r $base_dir$crf/frankfurt $val_dir
    matlab -nodisplay -nodesktop -r "run $code_path; quit" | tee -a $log_path$crf.txt 
done
