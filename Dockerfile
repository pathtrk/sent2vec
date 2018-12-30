FROM continuumio/anaconda3

RUN conda install -y nltk
RUN pip install -U tinysegmenter
RUN git clone https://github.com/attardi/wikiextractor.git
RUN pip install -e wikiextractor

RUN mkdir code
RUN mkdir dataset
COPY . /code
WORKDIR /code

CMD ["/bin/bash"]