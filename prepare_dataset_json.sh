#!/bin/bash

cd /storage
wget https://dumps.wikimedia.org/jawiki/latest/jawiki-latest-pages-articles-multistream.xml.bz2
bzcat jawiki-latest-pages-articles-multistream.xml.bz2 | WikiExtractor -o /storage/wiki_articles --json --no-templates --processes 24 -
