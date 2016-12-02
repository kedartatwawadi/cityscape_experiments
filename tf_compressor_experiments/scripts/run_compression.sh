#!/bin/bash

INPUT_DIR=cityscapes/leftImg8bit/test_images
ENCODER=/home/kedar/code/tensorflow_code/models/compression/encoder.py
DECODER=/home/kedar/code/tensorflow_code/models/compression/decoder.py
MODEL_PATH=/home/kedar/code/tensorflow_code/models/compression/compression_residual_gru/residual_gru.pb
ITER=5
cd $INPUT_DIR
for f in *.png; do
	echo $f
	output_codes=../output_codes/"$f"_codes.npz
	python $ENCODER --input_image=$f --output_codes=$output_codes --iteration=$ITER --model=$MODEL_PATH
	echo "starting decoding..."
	output_dir=../output_codes/"$f"_dir
	python $DECODER --input_codes=$output_codes --iteration=$ITER --output_directory=$output_dir --model=$MODEL_PATH
done


