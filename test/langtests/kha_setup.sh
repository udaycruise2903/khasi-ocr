#!/bin/bash
####
# Get the images for testing
#


### 
# Copy and rename files as needed for the evaluation script
#
mkdir -p ~/lang-files
rm -rf  ~/lang-files/kha-*
for testset in dictionary textbooks
do
	cd ~/lang-files
	mkdir -p ./kha-$testset
	cp ~/lang-kha-downloads/$testset/*.* ./kha-$testset/
	cd ./kha-$testset/
	for f in *-gt.txt; do mv "$f"  "$(echo "$f" | sed -r 's/-gt//')" ; done
	ls -1 *.png >pages
	sed -i -e 's/.png//g' pages
done

###
# Copy Devanagari stopwords
mkdir -p ~/lang-stopwords
cd ~/lang-stopwords
cp ~/lang-kha-downloads/stopwords.txt ~/lang-stopwords/kha.stopwords.txt
cp ~/lang-kha-downloads/stopwords.txt ~/lang-stopwords/Latin.stopwords.txt


cd ~/tesseract/test/langtests

