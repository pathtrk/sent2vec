#!/bin/bash

./fasttext sent2vec -input /storage/sent2vec-ja-wiki.txt -output /storage/sent2vec-ja-wiki-model -minCount 8 -dim 700 -epoch 9 -lr 0.2 -wordNgrams 2 -loss ns -neg 10 -thread 24 -t 0.000005 -dropoutK 4 -minCountLabel 20 -bucket 4000000