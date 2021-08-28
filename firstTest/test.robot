*** Settings ***
Library    Selenium2Library

Suite Setup  Open Browser  https://google.com  chrome
Suite Teardown  Close Browser

*** Variables ***
${userName1}  Gary 
${userName2}  胖子
${userName3}  Ron

*** Test Cases ***

Search Name And Verify Data 
  [Template]  Seach Repeat  
  ${userName1}
  ${userName2}
  ${userName3}

*** Keywords ***
Search Submit
  [Arguments]    ${name}
  Input Text  xpath=//div[@class="a4bIc"]/input  ${name}
  submit form

Back Google Index
  Click Link  id=logo

Search Verify
  [Arguments]    ${name}
  Element Should Contain  xpath=//div[@class="yuRUbf"]/a/h3  ${name}
  Get Element Attribute  xpath=//div[@class="yuRUbf"]/a  href

Seach Repeat
  [Arguments]    ${name}
  Search Submit  ${name}
  Search Verify  ${name}
  Back Google Index