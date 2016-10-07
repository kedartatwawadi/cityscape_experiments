#!/bin/bash

base_dir=~/Videos/leftImg8bit_sequence/frankfurt_videos/x264_crf
crf0_dir=~/Videos/leftImg8bit_sequence/frankfurt_videos/x264_crf0/optical_flow_frames
log_path=/home/kedartatwawadi/Videos/leftImg8bit_sequence/cityscape_experiments/logs/log_opt_flow_exp_x264_crf
code_path=/home/kedartatwawadi/Videos/leftImg8bit_sequence/cityscape_experiments/opt_flow_ked_2.py

for crf in `seq 8 8 32`
do
    cd $base_dir$crf/optical_flow_frames
    files=(*.png)
    for iter in `seq 0 2 99`
    do
        f1=${files[iter]}
        f2=${files[iter+1]}
        #echo $f1
        #echo $f2
        f3=$crf0_dir/$f1
        f4=$crf0_dir/$f2
        log_file=$log_path$crf
        #echo $f3
        #echo $f4
        #echo $log_file
        python $code_path $f1 $f2 $f3 $f4 $log_file$crf.txt
    done
done
