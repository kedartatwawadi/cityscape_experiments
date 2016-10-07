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

Sample ground truth:

![Sample GT](sample_data/frankfurt_000000_000294_gtFine_color.png)

## Experiments
1. **Compression vs distortion experient**
2. **Impact of denoising**
3. **Optical Flow experiments**
4. **Object Detection/Segmentation experiment**

The raw results are in the logs folder. While all the scripts are in the main folder. 
1. [logs](logs): contains logs



#### Cmopression vs distortion experiment

#### Impact of denoising

#### Optical Flow experiments

#### object Detection/Segmentation experiment
