#!/usr/bin/python3

import nltk
import neologdn
import os, sys, re, glob, json
from nltk.tokenize import RegexpTokenizer
from tinysegmenter import *

dataset_dir = "/storage/wiki_articles/" if len(sys.argv) < 2 else sys.argv[1]
dataset_path = os.path.join(dataset_dir, '**/*')
text_path = "/storage/sent2vec-ja-wiki.txt"


def texts_from_wiki_json(path):
    texts = []

    for line in open(path, 'r'):
        wiki_data = json.loads(line)
        texts.append(wiki_data['text'])

    return texts

def normalize_sentences(text):
    jp_sent_tokenizer = nltk.RegexpTokenizer(u'[^ 「」!?。．）]*[!?。]')

    normalized = neologdn.normalize(text).replace('\n', '')
    sentences = jp_sent_tokenizer.tokenize(normalized)

    return sentences

def append_sentence_to_file(json_path, text_path="/sorage/wiki_sentences.txt"):
    texts = texts_from_wiki_json(json_path)

    sentences = []
    for text in texts:
        sentences = sentences + normalize_sentences(text)

    with open(text_path, 'a+') as plain_text:
        for sentence in sentences:
            plain_text.write(sentence + '\n')


if __name__ == '__main__':
    c = []
    print("the dataset path is {}".format(dataset_path))

    for filename in glob.iglob(dataset_path, recursive=True):
        c.append(filename)

    total = len(c)
    counter = 0

    print("processing {} wiki files...".format(total))
    for filename in glob.iglob(dataset_path, recursive=True):
        if os.path.isfile(filename):
            append_sentence_to_file(filename, text_path=text_path)

            counter += 1
            print("\rprocessed : {} / {}".format(counter, total), end="")
            sys.stdout.flush()
