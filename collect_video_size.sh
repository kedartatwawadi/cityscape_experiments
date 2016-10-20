#!/bin/bash

source config.ini
#vid_dir=~/Videos/leftImg8bit_sequence/frankfurt_videos/x265_crf
vid_dir=/media/kedar/cfc96f03-783a-4353-be5f-c72a490aa372/kedar/frankfurt_videos/"$codec"_crf
log_dir=~/Videos/leftImg8bit_sequence/cityscape_experiments/logs/vp9_logs/log_vid_sizes_vp9_crf
crf_list="0 2 4 6 8 16 24 32"
for crf in $crf_list
do  
	cd $vid_dir$crf
	logfile=$log_dir$crf.txt
	du *.webm > $logfile
done
