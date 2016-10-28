#!/bin/bash

source config.ini
#vid_dir=~/Videos/leftImg8bit_sequence/frankfurt_videos/x265_crf
log_dir=~/Videos/leftImg8bit_sequence/cityscape_experiments/logs/"$codec"_logs/
for crf in $crf_list
do  

	logfile="$log_dir"log_opt_flow_deepflow2_exp_"$codec"_crf"$crf".txt
	python avg_opt_flow.py $logfile #> "$log_dir"average_file_sizes_"$codec".txt
done
