FROM debian:jessie

RUN apt-get update && \
    apt-get install -y build-essential \
                       mecab \
                       swig \
                       file \
                       libmecab-dev \
                       mecab-ipadic-utf8 \
                       python3 \
                       python3-dev \
                       python3-pip \
                       git \
                       wget \
                       curl
# RUN git clone https://github.com/attardi/wikiextractor.git
RUN pip3 install git+https://github.com/attardi/wikiextractor.git#egg=wikiextractor
RUN apt-get update && \
    apt-get install -y mecab swig file libmecab-dev mecab-ipadic-utf8
RUN pip3 install -U nltk neologdn mecab-python3 tinysegmenter
RUN git clone https://github.com/neologd/mecab-ipadic-neologd.git
RUN cd mecab-ipadic-neologd && bin/install-mecab-ipadic-neologd -n -y -u
RUN echo 'dicdir = /usr/lib/mecab/dic/mecab-ipadic-neologd' >> /etc/mecabrc

RUN mkdir code
COPY . /code
WORKDIR /code

RUN make

CMD ["/bin/bash"]