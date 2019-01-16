import os, sys, re, glob, json
import neologdn, nltk, MeCab

def texts_from_wiki_json(path):
    texts = []

    for line in open(path, 'r'):
        wiki_data = json.loads(line)
        texts.append(wiki_data['text'])

    return texts

def normalize_sentences(text):
    jp_sent_tokenizer = nltk.RegexpTokenizer(u'[^。]*[。]')

    normalized = neologdn.normalize(text).replace('\n', '').lower()
    sentences = jp_sent_tokenizer.tokenize(normalized)

    return sentences

def tokenize_sentence(sentence):
    segmenter = MeCab.Tagger("-Owakati")

    return segmenter.parse(sentence)

def tokenize_sentences(sentences):
    return [tokenize_sentence(s) for s in sentences]

def append_sentence_to_file(json_path, text_path="sentences.txt"):
    texts = texts_from_wiki_json(json_path)

    sentences = []
    for text in texts:
        sentences = sentences + normalize_sentences(text)

    tokenized_sentences = tokenize_sentences(sentences)

    with open(text_path, 'a+') as plain_text:
        for t in tokenized_sentences:
            plain_text.write(t + '\n')


if __name__ == "__main__":
    c = []
    for filename in glob.iglob('/storage/wiki_articles/**/*', recursive=True):
        c.append(filename)

    total = len(c)
    counter = 0

    for filename in glob.iglob('/storage/wiki_articles/**/*', recursive=True):
        if os.path.isfile(filename):
            append_sentence_to_file(filename, text_path="/storage/sent2vec-ja-wiki.txt")

            counter += 1
            print("\rprocessed : {} / {}".format(counter, total))
            sys.stdout.flush()