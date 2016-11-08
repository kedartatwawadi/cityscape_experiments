# Colored Video Compression
The current set of experiments were on video compression of the colored videos. The colored videos were obtained by demosaicing of the raw videos provided earlier. 
20 videos were demosaiced and then used for experimentation. We performed similar set of experiments, including trying out various quality values, different denoising filters etc.

## Demosaicing
There were some issues as discussed earlier. I am employing a hacky way right now to obtain the colored videos from the raw videos, as ffmpeg does not support an inbuilt demosaic filter. Currently using a matlab script to run image-by-image to convert the raw frames into colored ones. Also, need to adjust the gain factors by trial-and-error to get the color more realistic. This should afect the color to some extent, but the compression results, I think should not matter much. 

Some examples of the demosaiced frames are below. Clearly, there seems to be lot of saturation in the frames (which might be a result of low-quality demosaicing). Which can be improved. On another note, better cameras, more fine-tuned for autonomous driving with non-Bayer arrangement can be possibly used.

1. Raw Frame

![raw frame](images/image34.png)

2. Demosaiced frames

![frame1](images/demosaic_image42.png)
![frame2](images/demosaic_image335.png)
![frame3](images/demosaic_image462.png)

The results are summarised below:
## Experiments

### File Size Experiment
We experimented on 80 videos of approximate size of 650MB raw videos each. (Total 52GB).
After demosaicing, we retain the frame size of 640x480 (which is one of the standard ways in which Bayer demosaicing is performed). Here, we are introducing more data, as now we have 3 channels instead of 1 greyscale channel.
For most of the demosaicing experiments, it is possible to obtain the original video perfectly (upto loss in RGB -> YUV encoding).
The average file sizes are shown below:


 | raw | x264 | x265 | vp9
--- | --- | --- | --- | ---
mosaiced (original) | 650MB | 20MB | 20.5MB | 20MB 
demosaiced  |  | 42M   | 43M   | 43M

Some observations:

1. After compression, The demosaiced file sizes are larger because we are introducing some data due to interpolation. Although this is 3 times more information, it is observed that after compression it is more than the mosaiced dataset by a factor of 2. 
Thus suggests that we can compress demosaiced data in a better way.
2. The compression ratios are much better than the cityscape datascape numbers. 



The file size logs are added to the logs/ford_logs/
### Denoise Experiment
We tested with a few filters (most of them state-of-the-art). Which include hqdn3d, and its various variants based on spatial and temporal settings.
Also planning to test out the new NLMeans denoiser. However, which exact denoiser to use can be decided after consultation with the computer vision team. 

1. Hqdn3d with conservative settings 

![denoise](https://docs.google.com/spreadsheets/d/1ApCN0lHEm9iqc4ftGyucQbUI8iKzediZ777BcaHSqHU/pubchart?oid=289480964&format=image)

As we observe, the difference becomes less pronounced as the CRF level increases. This is expected, considering lossy versions would try to remove unwanted noise first. But, CRF levels should not be direclty compared here, as they are relative to lossless version which would for sure be much better for the denoised video.

## TODO
1. Mosaiced file video size
2. Difference of reconstructed mosaic video from demosaic
