# Cityscape Experiments
These are the results of the experiments with the cityscape dataset.

The experiments were conducted with the frankfurt part of the cityscape dataset.
## Dataset

1. The Frankfurt dataset contains around 80,000 frames, consisting of 3 stages (which we will refer to as long stages)
This part of the dataset was used mainly for compression experiments, as ground truth is not available for ll the frames.
2. A subset of the Frankfurt dataset: 50 sequences of 30 frames each, was used for majority of the experiments. 
Every 20th frame in the 30 frame have ground truth pixel-level object segmentation information 
(both object type and class information).

Sample (frame): 

![Sample Frame](sample_data/frankfurt_000000_000293_leftImg8bit.png)

Sample ground truth:

![Sample GT](sample_data/frankfurt_000000_000294_gtFine_color.png)

## Experiments
1. **Compression vs distortion experient**
2. **Impact of denoising**
3. **Optical Flow experiments**
4. **Object Detection/Segmentation experiment**

The raw results are in the logs folder. While all the scripts are in the main folder. 

1. [logs](logs): contains logs
2. [create_videos.sh](create_videos.sh): Script for creating videos from consecutive frames
3. [retrieve_frames.sh](retrieve_frames.sh): Retrieve the 20th frame (and 19th frame) for experiments and comparison with ground truth
4. [run_obj_detect.sh](run_obj_detect.sh): Run object detection experiment which compares the result with the GT. We use the the [LRR](https://github.com/golnazghiasi/LRR) (Laplacian Pyramid Reconstruction and Refinement for Semantic Segmentation) algorithm, one of the best amongst the benchmarks on the Cityscape datasets.

### Compression vs distortion experiment (Total memory for 50 videos together)
x265 is approximately 1.5-2 times better than x264. 
However, x265,vp9 are an order of magnitude slower than x264.
(Having some issues with vp9. Will try to sort them out over the weekend)
These results are for 30 frame snippets (average over 50 snippets)

CRF| x264 |x265 | vp9
--- | --- | --- | ---
crf0| 44M | 26M | -
crf8| 18M | 10M | -
crf16| 5M | 3.5K | -
crf24| 1.5M | 920K | -
crf32| 480K | 400K | -

#### Compression experiment for longer duration videos 
These experiments are for 5min video blocks (5100 frames at 17fps)
CRF| x264 
--- | ---  
crf0| 7.2GB 
crf8| 2.35GB 
crf16| 560MB
crf24| 150MB 
crf32| 50MB

(per frame wise: This is better than 30 frame compression by: 20-25%)
### Impact of denoising
There is approximately 20-25% saving on denoising, with very less impact on algorithms.

CRF| x264 |x264_denoise
--- | --- | --- 
crf0| 44M | 32M  
crf8| 18M | 12M
crf16| 5M | 3.8M
crf24| 1.5M | 1.3M
crf32| 480K |460K

### Optical Flow experiments
For fair comparison, we only consider dense optical flow algorithms (as it is unclear how should we compare feature-based optical flow algorithms). Attempted the following Optical Flow algorithms. However, was able to successfully conduct the **Farneback's algorithm.**

1. [Farneback's Algorithm](http://docs.opencv.org/2.4/modules/video/doc/motion_analysis_and_object_tracking.html): The results are for this algorithm (openCV implementation)

CRF| x264 |denoise_x264
--- | --- | ---
crf0| 0 | 0 
crf8| 0.027 | -
crf16| 0.056 | -
crf24| 0.123 | -
crf32| 0.28 | -

Its observed that the specific hqdn3d denoiser does not result in significant gains (as compared with the experiments with Ford videos). Probably different denoiser might work. Also, the noise seems really low in the videos

2. [SimpleFlow](http://graphics.berkeley.edu/papers/Tao-SAN-2012-05/): For some frames (even lossless, gives incorrect flow (nan), and is probably unreliable

3. [DeepFLow2](http://thoth.inrialpes.fr/src/deepflow/): The results are shown below:

CRF| x264 |denoise_x264
--- | --- | ---
crf0| 0 | 0 
crf8| 0.038 | 0.040
crf16| 0.081 | 0.080
crf24| 0.185 | 0.16
crf32| 0.31 | 0.28 

4. [EpicFLow](http://thoth.inrialpes.fr/src/epicflow/): Experiments are in progress


### Object Detection/Segmentation experiment

(Experiments with x264. Other vcodecs TBD)
Algorithms used:

1. [LRR](https://github.com/golnazghiasi/LRR): (Laplacian Pyramid Reconstruction and Refinement for Semantic Segmentation) algorithm, one of the best amongst the benchmarks on the Cityscape datasets.

CRF|meanIU |pixelAcc | meanAcc
--- | --- | --- | ---
crf0|71.27| 95.04 | 82.07 
crf8|70.86 | 94.97 | 81.70
crf16| 70.32 | 94.69 | 81.27
crf24| 62.17 | 90.66 | 77.79
crf32| 47.50 | 79.23 | 67.53

The relevant parameters are:

1. **meanIU:** mean intersection-over-union metric [IoU](https://www.cityscapes-dataset.com/benchmarks/) 
2. **pixelAcc:** Pixel Level Accuracy
3. **meanAcc:** Average Accuracy (not exactly sure what this is)

