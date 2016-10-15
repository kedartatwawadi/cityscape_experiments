#!/bin/bash

vid_dir=~/Videos/leftImg8bit_sequence/frankfurt_videos/x265_crf
offset=19
extn="_leftImg8bit.png"

for crf in 0 2 4 6 8 16 24
do
    cd $vid_dir$crf
    files=(*.mp4)
    echo $vid_dir
    
    rm -r $vid_dir$crf/optical_flow_frames 
    mkdir -p $vid_dir$crf/optical_flow_frames
     
    for iter in `seq 0 1 49`
    do   
        vid_name=${files[iter]}
        echo $vid_name
        extract_frame_num=$(echo $vid_name | sed 's/^frankfurt_000000_\([0-9]*\).mp4$/\1/')
        extract_fram_num=$(echo "$extract_frame_num#10")
        ((extract_frame_num = 10#$extract_frame_num + $offset))
        extract_frame_num=$(printf "%06d" $extract_frame_num)
        echo $extract_frame_num
        extract_frame_name="frankfurt_000000_$extract_frame_num$extn"
        echo $extract_frame_name

        ffmpeg -i $vid_name -vf "select='eq(\n,$offset)'" -vsync vfr $vid_dir$crf/optical_flow_frames/$extract_frame_name
        #ffmpeg -r 17 -start_number $start_frame_num -i frankfurt_000000_%06d_leftImg8bit.png -vframes 30 -vcodec libx264 -pix_fmt yuv444p $write_dir$crf/frankfurt_000000_$start_frame_num.mp4    
    done

done



offset=18
for crf in 0 2 4 6 8 16 24
do
    cd $vid_dir$crf
    files=(*.mp4)
    echo $vid_dir
    
    for iter in `seq 0 1 49`
    do   
        vid_name=${files[iter]}
        echo $vid_name
        extract_frame_num=$(echo $vid_name | sed 's/^frankfurt_000000_\([0-9]*\).mp4$/\1/')
        extract_fram_num=$(echo "$extract_frame_num#10")
        ((extract_frame_num = 10#$extract_frame_num + $offset))
        extract_frame_num=$(printf "%06d" $extract_frame_num)
        echo $extract_frame_num
        extract_frame_name="frankfurt_000000_$extract_frame_num$extn"
        echo $extract_frame_name

        mkdir -p $vid_dir$crf/optical_flow_frames
        ffmpeg -i $vid_name -vf "select='eq(\n,$offset)'" -vsync vfr $vid_dir$crf/optical_flow_frames/$extract_frame_name
        #ffmpeg -r 17 -start_number $start_frame_num -i frankfurt_000000_%06d_leftImg8bit.png -vframes 30 -vcodec libx264 -pix_fmt yuv444p $write_dir$crf/frankfurt_000000_$start_frame_num.mp4    
    done

done

