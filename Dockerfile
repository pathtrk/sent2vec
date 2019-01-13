FROM continuumio/anaconda3

RUN apt-get update && \
    apt-get install -y build-essential \
                       mecab \
                       swig \
                       file \
                       libmecab-dev \
                       mecab-ipadic-utf8
RUN conda install -y nltk
RUN git clone https://github.com/attardi/wikiextractor.git
RUN pip install -e wikiextractor
RUN apt-get update && \
    apt-get install -y mecab swig file libmecab-dev mecab-ipadic-utf8
RUN pip install -U neologdn mecab-python3
RUN git clone https://github.com/neologd/mecab-ipadic-neologd.git
RUN cd mecab-ipadic-neologd && bin/install-mecab-ipadic-neologd -n -y
RUN echo 'dicdir = /usr/lib/x86_64-linux-gnu/mecab/dic/mecab-ipadic-neologd' >> /etc/mecabrc

RUN mkdir code
COPY . /code
WORKDIR /code

RUN make

CMD ["/bin/bash"]