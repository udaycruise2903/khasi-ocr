#!/bin/bash
##############################################################################
# File:        runlangtests.sh
# Description: Script to run a set of accuracy test sets for any language.
#                      based on runalltests.sh by Ray Smith
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
##############################################################################
if [ $# -ne 5 ]
then
   echo "Usage:$0 unlv-data-dir version-id tessdata-dir langcode imgext"
   exit 1
fi

tessdata=$3
lang=$4
imgext=$5

#timesum computes the total cpu time
timesum() {
awk ' BEGIN {
total = 0.0;
}
{
  total += $2;
}
END {
  printf("%.2f\n", total);
}' "$1"
}

imdir="$1"
vid="$2"
bindir=${0%/*}
if [ "$bindir" = "$0" ]
then
    bindir="./"
fi
rdir=./langtests/reports

if [ "$lang" = "kha" ] ||  [ "$lang" = "Latin" ]
    then
       ### testsets="san-fontsamples san-oldstyle san-shreelipi san-alphabetsamples"
       testsets="kha-dictionary kha-textbooks"
fi

totalerrs=0
totalwerrs=0
totalnswerrs=0
for set in $testsets
do
    resultsdir=./langtests/results
    mkdir -p "$resultsdir"
    resdir=$resultsdir/$set
    mkdir -p "$resdir"
    cp ~/lang-stopwords/$lang.stopwords.txt "$resdir/$lang.stopwords"
    if [ -r "$imdir/$set/pages" ]
    then
    # Run tesseract on all the pages.
    bash $bindir/runtestset.sh "$imdir/$set/pages" "$tessdata" "$lang" "$imgext"
    # Count the errors on all the pages.
    $bindir/counttestset.sh "$imdir/$set/pages" $lang
    # Get the new character word and nonstop word errors and accuracy.
    cherrs=$(head -4 "$resultsdir/$set.characc" |tail -1 |cut -c1-9 |
        tr -d '[:blank:]')
    chacc=$(head -5 "$resultsdir/$set.characc" |tail -1 |cut -c1-9 |
        tr -d '[:blank:]')
    wderrs=$(head -4 "$resultsdir/$set.wordacc" |tail -1 |cut -c1-9 |
        tr -d '[:blank:]')
    wdacc=$(head -5 "$resultsdir/$set.wordacc" |tail -1 |cut -c1-9 |
        tr -d '[:blank:]')
    nswderrs=$(grep Total "$resultsdir/$set.wordacc" |head -2 |tail -1 |
        cut -c10-17 |tr -d '[:blank:]')
    nswdacc=$(grep Total "$resultsdir/$set.wordacc" |head -2 |tail -1 |
        cut -c19-26 |tr -d '[:blank:]')

    sumfile=$resultsdir/$vid.$set.sum
        if [ -r "$resultsdir/$set.times" ]
        then
          total_time=$(timesum "$resultsdir/$set.times")
          else
          total_time='0.0'
        fi
       echo "RELEASE		TestSet		CharErrors	Accuracy	WordErrors	Accuracy\
	NonStopWErrors	Accuracy	TimeTaken">"$resultsdir/$lang."Header
       echo "$vid	$set	$cherrs		$chacc		$wderrs		$wdacc\
		$nswderrs		$nswdacc		${total_time}s" >>"$sumfile"
    fi
done

##cat "$resultsdir/$lang."Header >>"$rdir/$lang-$(date +%F)".summary

cat "$resultsdir/$vid".*.sum >>"$rdir/$lang-$(date +%F)".summary
cat "$resultsdir/$vid".*.sum >>"$rdir/$lang".summary

cat "$resultsdir/$lang."Header "$rdir/$lang-$(date +%F)".summary 
