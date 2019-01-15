FROM python:3-stretch

RUN apt-get update && \
    apt-get install -y build-essential \
                       mecab \
                       swig \
                       file \
                       libmecab-dev \
                       mecab-ipadic-utf8 \
                       git \
                       wget \
                       curl
# RUN git clone https://github.com/attardi/wikiextractor.git
RUN pip install git+https://github.com/attardi/wikiextractor.git#egg=wikiextractor
RUN apt-get update && \
    apt-get install -y mecab swig file libmecab-dev mecab-ipadic-utf8
RUN pip install -U nltk neologdn mecab-python3 tinysegmenter
RUN git clone https://github.com/neologd/mecab-ipadic-neologd.git
RUN cd mecab-ipadic-neologd && bin/install-mecab-ipadic-neologd -n -y -u
RUN echo 'dicdir = /usr/lib/x86_64-linux-gnu/mecab/dic/mecab-ipadic-neologd' >> /etc/mecabrc

CMD ["/bin/bash"]