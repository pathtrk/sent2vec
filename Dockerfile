FROM continuumio/anaconda3

RUN apt-get update
RUN apt-get install -y build-essential
RUN conda install -y nltk
RUN pip install -U tinysegmenter neologdn
RUN git clone https://github.com/attardi/wikiextractor.git
RUN pip install -e wikiextractor

RUN mkdir code
COPY . /code
WORKDIR /code

RUN make

CMD ["/bin/bash"]