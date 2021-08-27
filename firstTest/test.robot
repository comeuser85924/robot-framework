*** Settings ***
Library    Selenium2Library

Suite Setup  Open Browser  https://google.com  chrome
Suite Teardown  Close Browser

*** Variables ***
@{userName}  Gary  胖子  Ron

*** Test Cases ***
Search Name And Verify Data 
  FOR  ${name}  IN  @{userName}
    SearchSubmit  ${name}
    SearchVerify  ${name}
  END

*** Keywords ***
SearchSubmit
  [Arguments]    ${name}
  Input Text  xpath=//div[@class="a4bIc"]/input  ${name}
  submit form

SearchVerify
  [Arguments]    ${name}
  Element Should Contain  xpath=//div[@class="yuRUbf"]/a/h3  ${name}
  ${getUrl}  Get Element Attribute  xpath=//div[@class="yuRUbf"]/a  href
  Log  ${getUrl}