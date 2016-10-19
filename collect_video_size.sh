#!/bin/bash

#vid_dir=~/Videos/leftImg8bit_sequence/frankfurt_videos/x265_crf
vid_dir=/media/kedar/cfc96f03-783a-4353-be5f-c72a490aa372/kedar/frankfurt_videos/x264_crf
log_dir=~/Videos/leftImg8bit_sequence/cityscape_experiments/logs/log_vid_sizes_x264_crf

for crf in 2 4 6
do  
	cd $vid_dir$crf
	logfile=$log_dir$crf.txt
	du *.mp4 > $logfile
done
