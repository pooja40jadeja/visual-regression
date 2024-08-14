# PDF Validation using Visual Regression
Imagemagick library is used to convert the PDF into an image file. A mask file is prepared using GIMP to hide the barcode(You can hide the part which is different compared to the reference file) which is then applied to the file being tested and to the reference file. The two files will be compared and the test will fail if difference between two files is greater than given threshold. More details about the library can be found here.

Pdfgrep library is used to search the Order Number in the file. It returns the string containing the given keyword (In our case: Order Number).

Zbar library is used to scan the barcode. It returns the string which the barcode contains (*CODE-128:${order_number}*) which can be compared with Order Number to make sure that barcode contains the correct data.

Test PDF is being compared with reference PDF for which we are using Imagemagick library. The Keyword Compare Images takes 3 parameters where we are providing path to PDFs and the accepted difference in % between the two files. ${output} variable in below command would save the % difference between two PDFs. Then we are checking if it is less than or equal to the allowed threshold.

The keyword, Validate barcode converts the PDF to an image, runs zbarimg command on that image and output is being saved to ${zbarout} variable and then it is checking if the output matches the given pattern.

The command, pdfgrep only works on PDFs and not on images. We are running pdfgrep on the test PDF to check if it contains the Order Number.

## Prerequisites

* Python3
* pip3

## Installation Steps
Install Robot Framework
```shell
pip3 install robotframework
```

Install libraries using below command.

For Mac
```shell
brew install pdfgrep
brew install imagemagick
brew install zbar
```

For Docker
```shell
apt install -y  pdfgrep
apt install -y  imagemagick
apt install  -y zbar-tools
```

## Test Execution
Run the test using
```shell
robot resources/test.robot
```

#robotframework #imagemagick #pdfgrep #zbar #visualregression