
*** Settings ***
Documentation   Validate the PDF format and content including barcode.
Library         OperatingSystem
Resource    ./validatePdf.robot

Test Setup       None
Test Teardown   None

*** Variables ***
${order_number}         84765

*** Test Cases ***
User is able compare the PDF format and validate the contents
     ${pdfText}=     Run     pdfgrep ${order_number} invoice.pdf
     Log To Console    ${pdfText}
     Should Match   ${pdfText}  pattern=*${order_number}*
     Validate barcode    invoice.pdf  ${order_number}
     Compare Masked images    referenceInvoice.pdf  invoice.pdf

