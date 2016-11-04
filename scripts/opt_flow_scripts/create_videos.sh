#!/bin/bash

source ../config.ini

frame_dir=~/Videos/leftImg8bit_sequence/val/frankfurt
write_dir=/media/kedar/cfc96f03-783a-4353-be5f-c72a490aa372/kedar/frankfurt_videos/tempi/"$codec"_crf
max_frames=1499

cd $frame_dir
files=(*.png)
echo $frame_dir

for iter in `seq 0 30 $max_frames`
do
    start_frame_name=${files[iter]}
    echo $start_frame_name
    start_frame_num=$(echo $start_frame_name | sed 's/^frankfurt_000000_\([0-9]*\)_leftImg8bit.png$/\1/')
    echo $start_frame_num
    for crf in $crf_list
    do  
        mkdir -p "$write_dir$crf"
	#cd 	pwd
#        ffmpeg -r 17 -start_number $start_frame_num -i frankfurt_000000_%06d_leftImg8bit.png -vframes 30 -c:v libvpx-vp9 -crf $crf -b:v 0 -pix_fmt yuv444p "$write_dir$crf"/frankfurt_000000_$start_frame_num.webm   
        ffmpeg -r 17 -start_number $start_frame_num -i frankfurt_000000_%06d_leftImg8bit.png -vframes 30 -c:v libx265 -crf $crf  -pix_fmt yuv444p "$write_dir$crf"/frankfurt_$start_frame_num.mp4 
#        ffmpeg -r 17 -start_number $start_frame_num -i frankfurt_000000_%06d_leftImg8bit.png -vframes 30 -c:v libx264 -preset veryslow -crf $crf -pix_fmt yuv444p "$write_dir$crf"/frankfurt_000000_$start_frame_num.mp4 

        #ffmpeg -r 17 -start_number $start_frame_num -i frankfurt_000000_%06d_leftImg8bit.png -vframes 30 -vcodec libvpx-vp9 -vf "yadif,hqdn3d=1.5:1.5:6:6" -crf $crf -pix_fmt yuv444p $write_dir$crf/frankfurt_000000_$start_frame_num.webm    
    done

done
