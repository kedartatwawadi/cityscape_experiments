#!/bin/bash

#base_dir=~/Videos/leftImg8bit_sequence/frankfurt_videos/x265_crf
#crf0_dir=~/Videos/leftImg8bit_sequence/frankfurt_videos/x265_crf0/optical_flow_frames
base_dir=/media/kedar/cfc96f03-783a-4353-be5f-c72a490aa372/kedar/frankfurt_videos/vp9_crf
crf0_dir=/media/kedar/cfc96f03-783a-4353-be5f-c72a490aa372/kedar/frankfurt_videos/vp9_cr0/optical_flow_frames
log_path=~/Videos/leftImg8bit_sequence/cityscape_experiments/logs/log_opt_flow_exp_vp9_crf
code_path=~/Videos/leftImg8bit_sequence/cityscape_experiments/opt_flow_ked_2.py

for crf in 0
do
    cd $base_dir$crf/optical_flow_frames
    files=(*.png)
    
    for iter in `seq 0 2 0`
    do
        f1=${files[iter]}
        f2=${files[iter+1]}
        echo $f1
        echo $f2
        f3=$crf0_dir/$f1
        f4=$crf0_dir/$f2
        log_file=$log_path$crf.txt
        
	#f1=$base_dir$crf/optical_flow_frames/$f1
	#f2=$base_dir$crf/optical_flow_frames/$f2

	echo $f3
        echo $f4
        echo $log_file
        python $code_path $f1 $f2 $f3 $f4 $log_file
    done
done
