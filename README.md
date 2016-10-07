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



### Cmopression vs distortion experiment

### Impact of denoising

### Optical Flow experiments

### Object Detection/Segmentation experiment

(Experiments with x264. Other vcodecs TBD)

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

