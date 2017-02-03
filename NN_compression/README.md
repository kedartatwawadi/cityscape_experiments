# Lossless compression using Neural Networks

## Motivation
Arithematic encoding has been used since past 20 years to achieve close to entropy compression for known distributions. Adaptive variants of Arithematic encoding (for a chosen k-context model) have also been designed, which first try to learn the conditional k-th order distribution, in the first pass nad use the same for compression in the second pass. 

However, as the complexity increases exponentially in $k$, with the alphabet size. Generally the context is limited to $k = 5,10$. Higher values of context are not tractable. Can we consider RNN based models to achieve improved conditional probability, which in turn can be used along with arithmatic encoding. 

Another important motivation this serves it with respect to how well can RNN's learn the probability distributions for compression, which can in turn help in intuitive understanding of RNN based image/video compression (lossless or lossy). 

## Past work

There has been a lot of work on sequence prediction using RNN's, where the aim is to generate a sequence which resembles a given dataset. For eg: generating shakespeare's plays, etc. 

1. Unreasonable Effectiveness of RNN: http://karpathy.github.io/2015/05/21/rnn-effectiveness/
2. LSTM based text prediction: http://www.cs.utoronto.ca/~ilya/pubs/2011/LANG-RNN.pdf

There was also some work in early 2000's on lossless compression using neural networks. However, due to Vanilla RNN's not being able to capture long term dependencies well, the models might not have performed as well. Also in the past 5 years, the speeds of neural network have dramatically improved, which is a good thing for NN based probability estimators.

1. Neural Networks based compression: http://ieeexplore.ieee.org/stamp/stamp.jsp?arnumber=478398
2. Matt Mahoney Implementation: http://mattmahoney.net/dc/nn_paper.html

Also on the theoretical side, there are connections between predictors trained with log-loss and universal compression. Thus, if RNN's can act as good predictors, we should be able to utilize them into good compressors.n

1. EE376c Lecture Notes on Prediction: http://web.stanford.edu/class/ee376c/lecturenotes/Chapter2_CTW.pdf


## TODO

The plan is to test with sources such as: 

1. iid sources
2. k-Markov sources
3. 0 entropy sources with very high markovity. For example
    X_n = X_{n-20} exor X_{n-40} exor X_{n-60}

Wold be interesting to see, if the RNN network is able to figure out such deep correlations. Would be useful to also quantify the amount of state information required to achieve entropy limits with there sources (what RNN models, how many layers). 

## Applications

1. **Improved intuitive understanding** of RNN based structures for compression. The understanding can be used later to make improvements to more complex image/video compressors
2. **Wide Applications** to generic text/DNA/parameter compression. i.e. wherever arithematic encoding is used.
3. **Theoretical Connections** with log-loss based predictors, can be understood based on simple linear-RNN networks etc. 

