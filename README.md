# khasi-ocr
Khasi-ocr is a project to create OCR model for khasi language. tesseract-ocr is used for LSTM layer training. 

<pre>
base model: eng.traineddata
output model: kha.traineddata(fast model)
fonts: Liberation Serif
network spec: [1,36,0,1[C3,3Ft16]Mp3,3Lfys64Lfx96Lrx96Lfx192Fc128]
lstmeval result: CER = 0.08, WER = 0.19
UNLV test result: CER = 4.3 (academic textbooks), CER = ~76.5 (dictionary)
</pre>

## Improvements ##
<ol>
  <li> edit the groundtruth files manually with reference to images.
  <li> produce best model of traineddata. use (network spec - Lfx512 O1c1) in lstm training 
</ol>
  
## for more info ##
  refer wiki

