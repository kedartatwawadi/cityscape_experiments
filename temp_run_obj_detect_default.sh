#!/bin/bash

source config.ini
val_dir=~/Videos/leftImg8bit/val
base_dir=~/Videos/leftImg8bit_sequence/val/
code_path=/home/kedartatwawadi/code/video_compression/LRR/LRRTestOnCityScape.m
log_path=/home/kedartatwawadi/Videos/leftImg8bit_sequence/cityscape_experiments/logs/default_obj_detect_lossless.txt

cd $val_dir
rm -r frankfurt/

cp -r $base_dir/frankfurt $val_dir
matlab -nodisplay -nodesktop -r "run $code_path; quit" | tee -a $log_path 

