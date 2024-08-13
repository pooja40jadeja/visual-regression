Imagemagick library is used to convert the PDF into an image file. A mask file is prepared using GIMP to hide the barcode(You can hide the part which is different compared to the reference file) which is then applied to the file being tested and to the reference file. The two files will be compared and the test will fail if difference between two files is greater than given threshold. More details about the library can be found here.

Pdfgrep library is used to search the Order Number in the file. It returns the string containing the given keyword (In our case: Order Number).

Zbar library is used to scan the barcode. It returns the string which the barcode contains (*CODE-128:${order_number}*) which can be compared with shipment number to make sure that barcode contains the correct data.

Test PDF is being compared with reference PDF for which we are using Imagemagick library. The Keyword Compare Images takes 3 parameters where we are providing path to PDFs and the accepted difference in % between the two files. ${output} variable in below command would save the % difference between two PDFs. Then we are checking if it is less than or equal to the allowed threshold.

Test Image + Mask = Masked Test Image
![image](https://github.com/user-attachments/assets/5efdbd7a-8d77-4467-abd6-e7a5ce5201c1) + ![image](https://github.com/user-attachments/assets/1beeacbf-9440-4611-ba27-2c62a5dd249e) = ![image](https://github.com/user-attachments/assets/95fa3c49-4bd9-40bb-a7e5-3ff278be3a79)

Reference Image + Mask = Masked Reference Image
![image](https://github.com/user-attachments/assets/8d5cf774-b34a-4ea8-9128-83b8a369bdd1) + ![image](https://github.com/user-attachments/assets/d75ecfdb-e0d3-4f27-b530-683e5c5ea8e3) = ![image](https://github.com/user-attachments/assets/c862e2a9-1e58-4f82-873b-533e52ad9354)


Then we are comparing Masked Test Image with Masked Reference Image and to make sure that both are exactly the same. Masking would require both the images to be of same size hence we are also resizing mask image (invoice_mask.png) as it is manually generated file. 

The keyword, Validate barcode converts the PDF to an image, runs zbarimg command on that image and output is being saved to ${zbarout} variable and then it is checking if the output matches the given pattern.

The command, pdfgrep only works on PDFs and not on images. We are running pdfgrep on the test PDF to check if it contains the Order Number.

Installation Steps:
Install libraries using below command.

#For Mac
brew install pdfgrep
brew install imagemagick
brew install zbar
