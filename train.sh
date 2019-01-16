#!/bin/bash
make
fasttext sent2vec -input /storage/sent2vec-ja-wiki.txt -output /storage/model -minCount 8 -dim 700 -epoch 30 -lr 0.02 -wordNgrams 5 -loss ns -neg 10 -thread 24 -t 0.000005 -dropoutK 4 -minCountLabel 20 -bucket 4000000