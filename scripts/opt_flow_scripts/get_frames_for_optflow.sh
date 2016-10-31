#!/bin/bash

source config.ini
vid_dir=/media/kedar/cfc96f03-783a-4353-be5f-c72a490aa372/kedar/frankfurt_videos/"$codec"_crf
offset=19
extn="_leftImg8bit.png"
vid_extn=".mp4"
for crf in $crf_list
do
    cd $vid_dir$crf
    files=(*$vid_extn)
    echo $vid_dir
    
    rm -r $vid_dir$crf/optical_flow_frames 
    mkdir -p $vid_dir$crf/optical_flow_frames
     
    for iter in `seq 0 1 49`
    do   
        vid_name=${files[iter]}
        echo $vid_name
        extract_frame_num=$(echo $vid_name | sed 's/^frankfurt_000000_lossles_flag_\([0-9]*\).mp4$/\1/')
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
for crf in $crf_list
do
    cd $vid_dir$crf
    files=(*$vid_extn)
    echo $vid_dir
    
    for iter in `seq 0 1 49`
    do   
        vid_name=${files[iter]}
        echo $vid_name
        extract_frame_num=$(echo $vid_name | sed 's/^frankfurt_000000_lossles_flag_\([0-9]*\).mp4$/\1/')
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

