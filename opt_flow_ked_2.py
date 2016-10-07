#!/usr/bin/env python

# Python 2/3 compatibility
from __future__ import print_function

import numpy as np
import cv2
import sys
import os

def draw_flow(img, flow, step=16):
    h, w = img.shape[:2]
    y, x = np.mgrid[step/2:h:step, step/2:w:step].reshape(2,-1).astype(int)
    fx, fy = flow[y,x].T
    lines = np.vstack([x, y, x+fx, y+fy]).T.reshape(-1, 2, 2)
    lines = np.int32(lines + 0.5)
    vis = cv2.cvtColor(img, cv2.COLOR_GRAY2BGR)
    cv2.polylines(vis, lines, 0, (0, 255, 0))
    for (x1, y1), (x2, y2) in lines:
        cv2.circle(vis, (x1, y1), 1, (0, 255, 0), -1)
    return vis


frame1 = cv2.imread(sys.argv[1]);
frame2 = cv2.imread(sys.argv[2]);
frame1_crf0 = cv2.imread(sys.argv[3]);
frame2_crf0 = cv2.imread(sys.argv[4]);
logfile = open(sys.argv[5],'w');

gray1 = cv2.cvtColor(frame1, cv2.COLOR_BGR2GRAY)
gray2 = cv2.cvtColor(frame2, cv2.COLOR_BGR2GRAY)
gray1_crf0 = cv2.cvtColor(frame1_crf0, cv2.COLOR_BGR2GRAY)
gray2_crf0 = cv2.cvtColor(frame2_crf0, cv2.COLOR_BGR2GRAY)

flow = cv2.calcOpticalFlowFarneback(gray1, gray2, None, 0.5, 3, 15, 3, 5, 1.2, 0)
flow_crf0 = cv2.calcOpticalFlowFarneback(gray1_crf0, gray2_crf0, None, 0.5, 3, 15, 3, 5, 1.2, 0)

diff_flow = flow - flow_crf0
diff_score = np.sum(abs(diff_flow))
rel_score = diff_score/np.sum(abs(flow_crf0))
print(os.path.basename(sys.argv[1]),"  ",rel_score, file=logfile);
print(os.path.basename(sys.argv[1]),"  ",rel_score);

