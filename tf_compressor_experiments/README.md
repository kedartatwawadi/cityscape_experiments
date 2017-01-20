## Introduction
This is a summary of experiments on the google tensorflow image compressor. One of the aims is to adapt it for video data with different loss functions (loss functions more suitable for autonomous driving: eg: optical flow based loss function).

### Intuition
The Encoder processes blocks of 32x32 and performs "conceptual compression" of the block. Every block is compressed using the other neighboring blocks as priors, using the gated recurrent units (a slightly modified form of RNN). For speed They also add residual connections, but I dont think this makes mcuh of an impact on the understanding. But, probably allows deeper networks in practice. 

Both the decoder and encoder networks are trained together (unlike autoencoders, they need not be the same). As described in the paer & the blog (https://research.googleblog.com/2016/09/image-compression-with-neural-networks.html):

1. The initial residual, R[0], corresponds to the original image I: R[0] = I.
2. Set i=1 for to the first iteration.
3. Iteration[i] takes R[i-1] as input and runs the encoder and binarizer to compress the image into B[i].
4. Iteration[i] runs the decoder on B[i] to generate a reconstructed image P[i].
5. The residual for Iteration[i] is calculated: R[i] = I - P[i].
6. Set i=i+1 and go to Step 3 (up to the desired number of iterations).
 
The compressed image is now represented by the concatenation of B[1] through B[N]
Thus, the size linearly increases with number of iterations. 

### Improvements
With the perspective of video compression, we can at least improve the compression ratio by approximately saving a couple iteration of data (practically this should be about 10%-20%), by using motion vector predicted frame (coarse prediction). Thus, we extract one part of the video codecs & directly reuse it.
 
##Experiments
### Experiment 1
This was mainly about getting the code to work. There have been some issues, for which I have raised an issue on the google github repo: (https://github.com/tensorflow/models/issues/704). Right now working with some workarounds. 

Performance: 
1. Input Image 
	- Size: 
	- 

2. Output Image 
	- Number of iterations: 
	- Size: 
	- Quality (with msssi quality metric)
	  (https://ece.uwaterloo.ca/~z70wang/publications/msssim.html)

We take a look at images for 5 iterations:
(this remains fixed inspite of image size etc. for this network)

| Iteration | BPP | Compression Ratio | msssim | 
|---: |---: |---: | ---: | 
|0 | 0.125 | 192:1| 0.88 | 
|1 | 0.250 | 96:1| 0.95 | 
|2 | 0.375 | 64:1| 0.97 | 
|3 | 0.500 | 48:1| 0.98 | 
|4 | 0.625 | 38.4:1| 0.984 | 

Comparison with JPEG (every frame individually)

| Iteration | Compression Ratio | msssim | 
|---: |---: |---: | ---: | 
|1 | 50:1| 0.96 | 
|2 | 40:1| 0.97 | 
|3 | 36:1| 0.98 | 
|4 | 23:1| 0.984 | 

![image0](experiments/stuttgart_00_000000_000002_leftImg8bit.png_dir/image_00.png)
![image1](experiments/stuttgart_00_000000_000002_leftImg8bit.png_dir/image_01.png)
![image2](experiments/stuttgart_00_000000_000002_leftImg8bit.png_dir/image_02.png)
![image3](experiments/stuttgart_00_000000_000002_leftImg8bit.png_dir/image_03.png)
![image4](experiments/stuttgart_00_000000_000002_leftImg8bit.png_dir/image_04.png)


### Experiment 2
This experiment was on the videos, by directly feeding in image samples. We use 5 iterations for simplicity right now (the computations are linear in number of iterations, and take a lot of time).

I modified the loss function to be L2 ( The aim was eventually to change it to optical flow loss). The training procedure followed was as follows. 

1. Run every image for 15 full iterations
2. Pick the next 30 frames and repeat the experiment for every frame
3. Pick a random short snippet of cityscape video of 30 frames and retrain

This training is still for the image compressor, and not for the video. The results were overall  (However, unfair to compare with JPEG, as it does not train for the loss function). 

| Iteration | BPP | Compression Ratio | L2 (relative) | 
|---: |---: |---: | ---: | 
|3 | 0.500 | 48:1| 0.989 | 
|4 | 0.625 | 38.4:1| 0.992 | 

For Optical Flow based loss function, we use DeepFlow2 Optical Flow (http://thoth.inrialpes.fr/src/deepflow/) for the need of easily differentiable/backpropagable iterations. Need some time to do this, as DeepFlow2 (or most of the Optical Flow based implementations) are not implemented in TensorFlow




### Experiment 3
This experiment was by feeding direct differences of frames (and not motion vector adjusted differences). The improvement is variable and largely dependent on the motion. For most of the cases, there is an improvement by 1-2 iterations (percentage improvement is variable).

I also tried Motion Vector adjusted difference between frames. However, the prediction is per macroblock in x264, and some macroblocks can be non-causal. Thus, directly extracting the predictor part from codecs might not be possible.

### TODO
1. Analyze if Non-causality significantly improves the compression.
2. Understand if these modifications can lead to significant video compression
3. Add a causal motion vector based frame predictor: https://arxiv.org/pdf/1502.04681.pdf



 
