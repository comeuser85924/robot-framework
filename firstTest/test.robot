*** Settings ***
Library    Selenium2Library

*** Variables ***
${userName}  Gary  胖子  Ron

*** Test Cases ***
Open Google
  Open Browser  https://google.com  chrome

Search Name
  Input Text  xpath=//div[@class="a4bIc"]/input  ${userName}
  submit form

Get The First Data
  ${getTitle}  Get Text  xpath=//div[@class="yuRUbf"]/a/h3
  ${getUrl}  Get Element Attribute  xpath=//div[@class="yuRUbf"]/a  href
  Log  ${getTitle} 
  Log  ${getUrl}

Close Browser
  Close Browser