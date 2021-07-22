#!/bin/bash
# run ./langtests/runlangtests.sh with the root data dir, testname, tessdata-dir, language code and image extension

cd ~/tesseract/test

rm -rf ./langtests/results/*kha*
rm -rf ./langtests/results/*Latin*
#rm -rf ./langtests/reports/*kha-$(date +%F)*
#rm -rf ./langtests/reports/*Latin-$(date +%F)*

# Run the tests
./langtests/runlangtests.sh ~/lang-files 4_fast_Latin ../tessdata_fast/script Latin png
rm -rf ./langtests/results/*Latin*
./langtests/runlangtests.sh ~/lang-files 4_best_int_Latin ../tessdata/script Latin png
rm -rf ./langtests/results/*Latin*
./langtests/runlangtests.sh ~/lang-files 4_best_Latin ../tessdata_best/script Latin png
rm -rf ./langtests/results/*Latin*

./langtests/runlangtests.sh ~/lang-files 4_fast_kha ../tessdata_fast kha png
rm -rf ./langtests/results/*kha*

### It takes a while to run.

cd ~/tesseract/test/langtests/
rm -rf ./times.txt
