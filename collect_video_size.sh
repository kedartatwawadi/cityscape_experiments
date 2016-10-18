#!/bin/bash

#vid_dir=~/Videos/leftImg8bit_sequence/frankfurt_videos/x265_crf
vid_dir=/media/kedar/cfc96f03-783a-4353-be5f-c72a490aa372/kedar/frankfurt_videos/vp9_crf
log_dir=~/Videos/leftImg8bit_sequence/cityscape_experiments/logs/log_vid_sizes_vp9_crf

for crf in 0 2 4 6 8 16 24 32
do  
	cd $vid_dir$crf
	logfile=$log_dir$crf.txt
	du *.webm > $logfile
done
