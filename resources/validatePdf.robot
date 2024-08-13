*** Settings ***
Library     OperatingSystem

*** Keywords ***
Compare Images
   [Arguments]      ${pathtorefpdf}  ${pathtotestpdf}  ${allowed_threshold}
   ${output}=     Run  magick ${pathtorefpdf} ${pathtotestpdf} -metric RMSE -compare -format "%[distortion]" info:
   Log To Console  ${output}
   ${result}        Evaluate    ${output} <= ${allowed_threshold}
   Should be True   ${result}

Convert PDF to Image
  [Arguments]      ${pathtopdf}
   Run  magick -density 300 ${pathtopdf} -quality 100 -alpha remove image.png

Resize mask Image
   [Arguments]      ${pathtomasked_image}
   Run  magick -density 300 ${pathtomasked_image} -quality 100 -resize 1240x874 invoice_mask_resize.png

Create ref mask image
   [Arguments]      ${pathtopdf}
   Run  magick -density 300 ${pathtopdf} -quality 100 -alpha remove -resize 1240x874 image_ref.png
   Resize mask Image  invoice_mask.png
   Run     magick image_ref.png invoice_mask_resize.png -compose DstOut -composite refmask.png

Create test mask image
   [Arguments]      ${pathtopdf}
   Run  magick -density 300 ${pathtopdf} -quality 100 -alpha remove -resize 1240x874 image_test.png
   Resize mask Image  invoice_mask.png
   Run     magick image_test.png invoice_mask_resize.png -compose DstOut -composite testmask.png

Validate barcode
   [Arguments]      ${pdfpath}  ${order_number}
   Run  magick -density 300 ${pdfpath} -quality 100 -alpha remove image.png
   ${zbarout}=      Run  zbarimg image.png
   Should Match					${zbarout}	pattern=*CODE-128:${order_number}*
   Log To Console      ${zbarout}

Compare Masked images
   [Arguments]      ${pdfpathtest}  ${pdfpathref}
   Create test mask image  ${pdfpathtest}
   Create ref mask image  ${pdfpathref}
   Compare Images  refmask.png  testmask.png  0.05
