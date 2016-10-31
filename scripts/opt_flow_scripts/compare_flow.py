# Python 2/3 compatibility
from __future__ import print_function

import sys
import numpy as np
import os


def readFlow(fn):
    """ Read .flo file in Middlebury format"""
    # Code adapted from:
    # http://stackoverflow.com/questions/28013200/reading-middlebury-flow-files-with-python-bytes-array-numpy

    # WARNING: this will work on little-endian architectures (eg Intel x86) only!
    with open(fn, 'rb') as f:
        magic = np.fromfile(f, np.float32, count=1)
        if 202021.25 != magic:
            print(magic)
	    print('Magic number incorrect. Invalid .flo file')
	    return None
        else:
            w = np.fromfile(f, np.int32, count=1)
            h = np.fromfile(f, np.int32, count=1)
            #print 'Reading %d x %d flo file' % (w, h)
            data = np.fromfile(f, np.float32, count=2*w*h)
            # Reshape data into 3D array (columns, rows, bands)
            return np.resize(data, (h, w, 2))


flow_crf0 = readFlow(sys.argv[2])
flow = readFlow(sys.argv[3])
logfile = open(sys.argv[4],'a');

diff_flow = flow - flow_crf0
diff_score = np.sum(abs(diff_flow))
print(diff_score)

rel_score = diff_score/np.sum(abs(flow_crf0))
print(os.path.basename(sys.argv[1]),"  ",rel_score, file=logfile);
print(os.path.basename(sys.argv[1]),"  ",rel_score);


