#!/bin/bash
# run ./langtests/runlangtests.sh with the root data dir, testname, tessdata-dir, language code and image extension

cd ~/tesseract/test

rm -rf ~/tesseract/test/langtests/results/*kha*
rm -rf ~/tesseract/test/langtests/results/*Latin*
#rm -rf ./langtests/reports/*kha-$(date +%F)*
#rm -rf ./langtests/reports/*Latin-$(date +%F)*

# Run the tests
./tesseract/test/langtests/runlangtests.sh ./tesseract/test/langtests/lang-files 4_fast_Latin ./tesseract/tessdata/fast/script Latin png
rm -rf ./tesseract/test/langtests/results/*Latin*
./tesseract/test/langtests/runlangtests.sh ./tesseract/test/langtests/lang-files 4_best_int_Latin ./tesseract/tessdata/script Latin png
rm -rf ./tesseract/test/langtests/results/*Latin*
./tesseract/test/langtests/runlangtests.sh ./tesseract/test/langtests/lang-files 4_best_Latin ./tesseract/tessdata/best/script Latin png
rm -rf ./tesseract/test/langtests/results/*Latin*

./tesseract/test/langtests/runlangtests.sh ./tesseract/test/langtests/lang-files 4_fast_kha ./tesseract/tessdata/fast kha png
rm -rf ./tesseract/test/langtests/results/*kha*
./tesseract/test/langtests/runlangtests.sh ./tesseract/test/langtests/lang-files 4_best_int_kha ./tesseract/tessdata kha png
rm -rf ./tesseract/test/langtests/results/*kha*
./tesseract/test/tesseract/test/langtests/runlangtests.sh ./tesseract/test/langtests/lang-files 4_best_kha ./tesseract/tessdata/best kha png
rm -rf ./tesseract/test/tesseract/test/langtests/results/*kha*

### It takes a while to run.

cd ~/tesseract/test/langtests/
rm -rf ./times.txt
