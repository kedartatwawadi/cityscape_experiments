#!/bin/bash

base_dir=~/Videos/leftImg8bit_sequence/frankfurt_videos/x265_crf
crf0_dir=~/Videos/leftImg8bit_sequence/frankfurt_videos/x265_crf0/optical_flow_frames
log_path=~/Videos/leftImg8bit_sequence/cityscape_experiments/logs/log_opt_flow_deepflow2_exp_x265_crf
opt_flow_code_path=/home/kedar/code/video_compression/DeepFlow_release2.0/deepflow2
code_path=~/Videos/leftImg8bit_sequence/cityscape_experiments/compare_flow.py

for crf in 2 4 6 8 16 24
do
    cd $base_dir$crf/optical_flow_frames
    files=(*.png)
    for iter in `seq 0 2 97`
    do
	rm flow.flo flow_crf0.flo
        f1=${files[iter]}
        f2=${files[iter+1]}
        #echo $f1
        #echo $f2
        f3=$crf0_dir/$f1
        f4=$crf0_dir/$f2
        log_file=$log_path$crf.txt
        #echo $f3
        #echo $f4
        #echo $log_file
	$opt_flow_code_path $f1 $f2 flow.flo
	$opt_flow_code_path $f3 $f4 flow_crf0.flo

        python $code_path $f1 flow_crf0.flo flow.flo $log_file 
    done
done
