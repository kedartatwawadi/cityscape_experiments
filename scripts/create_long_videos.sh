#/bin/bash

frame_dir=/media/kedar/New\ Volume/leftImg8bit_allFrames_frankfurt/leftImg8bit_allFrames/val/frankfurt
write_dir=/media/kedar/New\ Volume/leftImg8bit_allFrames_frankfurt/leftImg8bit_allFrames/frankfurt_videos/x264_long_veryslow_crf

max_frames=22926
nframes=5100
cd /media/kedar/New\ Volume/leftImg8bit_allFrames_frankfurt/leftImg8bit_allFrames/val/frankfurt
pwd
files=(frankfurt_000000_*.png)
echo ${files[0]}


for iter in `seq 0 $nframes $max_frames`
do
    start_frame_name=${files[iter]}
    echo $start_frame_name
    start_frame_num=$(echo $start_frame_name | sed 's/^frankfurt_000000_\([0-9]*\)_leftImg8bit.png$/\1/')
    echo $start_frame_num
    for crf in "0 8 16 24"
    do  
        mkdir -p "$write_dir$crf"
        ffmpeg -r 17 -start_number $start_frame_num -i frankfurt_000000_%06d_leftImg8bit.png -vframes $nframes -vcodec libx264 -preset veryslow -crf $crf -pix_fmt yuv444p "$write_dir$crf"/frankfurt_000000_$start_frame_num.mp4    
        #ffmpeg -r 17 -start_number $start_frame_num -i frankfurt_000000_%06d_leftImg8bit.png -vframes 1500 -vcodec libx264 -vf "yadif,hqdn3d=1.5:1.5:6:6" -crf $crf -pix_fmt yuv444p $write_dir$crf/frankfurt_000000_$start_frame_num.mp4    

    done
done
