import numpy as np
import sys
import csv


filename=sys.argv[1]
reader=csv.reader(open(filename),delimiter=' ')
file_size_list=[]
for row in reader:
	file_size_list.append(row[4])

file_size_array = np.asarray(file_size_list)
file_size_array = file_size_array.astype(np.float)

print( np.mean(file_size_array) )

