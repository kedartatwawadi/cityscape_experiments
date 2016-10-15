#!/bin/bash

vid_dir=~/Videos/leftImg8bit_sequence/frankfurt_videos/x265_crf
log_dir=~/Videos/leftImg8bit_sequence/cityscape_experiments/logs/log_vid_sizes_x265_crf
for crf in 0 2 4 6 8 16 24 32
do  
	cd $vid_crf$crf
	logfile=$log_dir$crf.txt
	du *.mp4 > $logfile
done
