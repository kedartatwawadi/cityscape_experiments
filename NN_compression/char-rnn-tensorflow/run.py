#!/usr/bin/python

import subprocess
import numpy as np
import os


def main():
    generation_script="generate_sequence_data.py"
    train_script="train.py"
    data_dir = "data/sequence_data"
    output_dir="outputs"
    # generate and run 0entropy models with default parameters
    max_k=35
    num_samples=100000000
    max_epochs=4
    num_iter=2
    num_layers=3
    p1=0.5
    output_file = os.path.join(output_dir,"output_0entropy_9_popeye.txt")
    for k in range(20,max_k,2):
        for iter in range(num_iter):
            print  "Processing for k: ",str(k+1)
            markovity = k+1
            file_name = "input_0entropy_" + str(iter) + "_iter_" + str(markovity) + "_markovity.txt"
            file_name = os.path.join(data_dir,file_name)
            info_file = "info_0entropy_" + str(iter) + "_iter_" + str(markovity) + "_markovity.txt" 
            info_file = os.path.join(data_dir,info_file)

            
            arg_string  = "  --num_samples " + str(num_samples)
            arg_string += "  --data_type "   + "0entropy"
            arg_string += "  --markovity "   + str(markovity)
            arg_string += "  --file_name "   + file_name
            arg_string += "  --info_file "   + info_file    
            arg_string += "  --p1 "          + str(p1)

            # Generate the data
            generation_command = "python " + generation_script + arg_string
            subprocess.call([generation_command] , shell=True)
            assert os.path.isfile(file_name),"The data did not get generated"
            assert os.path.isfile(info_file),"The info file did not get created"
            print "Data generated .. "

            #### Prepare for training
            for _size in [128,256]:
                summary_dir = ".summary"
                summary_dir = os.path.join(summary_dir, "size_" + str(_size))
                summary_dir = os.path.join(summary_dir, "num_layers_" + str(num_layers))
                summary_dir = os.path.join(summary_dir, "markovity_" + str(k))
                summary_dir = os.path.join(summary_dir, "run_" + str(iter))
                arg_string  = " --data_path "   + file_name
                arg_string += " --info_path "   + info_file
                arg_string += " --output_path " + output_file
                arg_string += " --num_epochs "  + str(max_epochs)
                arg_string += " --num_layers "  + str(num_layers)
                arg_string += " --rnn_size "    + str(_size)
                arg_string += " --summary_dir " + str(summary_dir)
                # Run the training
                train_command = "python " + train_script + arg_string
                subprocess.call([train_command], shell=True) 

if __name__ == '__main__':
    main()

