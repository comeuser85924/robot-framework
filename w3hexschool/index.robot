*** Settings ***
Resource    settings.robot
Suite Setup   Open Browser  https://w3hexschool.herokuapp.com/#/  chrome
Suite Teardown    Close Browser

*** Variables ***

${bannerImage} =    https://i.imgur.com/0lbPEOk.png
${title} =    w3HexSchool 鼠年全馬鐵人挑戰
${subTitle} =    查詢系統
${dropdownArticle} =    部落格文章
${dropdownName} =     名字
${matchTheNumberText} =    符合筆數
${matchTheNumberTotal} =    0

*** Test Cases ***

# 驗證 banner 圖片正確
Verify Banner Image Is Correct
  Verify Banner

# 驗證網頁大標題為文字 "w3HexSchool 鼠年全馬鐵人挑戰"
Verify The Title Text Is Correct
  Verify Title
  
# 驗證網頁副標題為文字 "查詢系統"
Verify The Subtitle Text Is Correct
  Verify Subtitle

# 驗證下拉式選單文字有 "部落格文章"、 "名字"
Verify The Dropdown Menu Text Is Correct
  Verify Dropdown Menu

# 驗證輸入欄位預設為空值
Verify Search Input Search Default Is Empty Values
  Verify Search Input

# 驗證下方文字為 "符合比數" 且 預設為 0
Verify Match The Number of Default Is 0
  Verify Match The Number Text
  ${total} =    Get Match The Number Total
  Should Be Equal As Strings    ${total}    ${matchTheNumberTotal}

# 驗證下拉選單有 "名字"、部落格文章""
Verify Dropdown Menu List
  Verify Dropdown Menu

# 驗證下拉選單可點選 "名字"
Verify Selct Dropdown Menu For Name
  Selct Dropdown Menu For Name

# 驗證下拉選單可點選 "部落格文章"
Verify Selct Dropdown Menu For Article 
  Selct Dropdown Menu For Article

# 驗證下拉選單為 "部落格文章"，輸入欄位輸入 "java"、"python"、"js"，符合筆數的數量正確
Verify Search Input And Match The Number of Values Is Correct
  [Setup]    Selct Dropdown Menu For Article
  [Template]    Verify Input Search Content
  java
  python
  js

# 驗證下拉選單為 "名字"，輸入欄位輸入 "Z"、"Ron"、"js"，符合筆數的數量正確
Verify Search Input And Match The Number of Values Is Correct
  [Setup]    Selct Dropdown Menu For Article
  [Template]    Verify Input Search Content
  java
  python
  js

# 檢查欄位為 "最新文章"、"文章多到寡"
# 預設為 最新文章，檢查列表中資料時間式由新到舊
# 點擊 文章多到寡，檢查列表中資料中的文章數由多到少
# 點擊 最新文章，檢查列表中資料時間式由新到舊

*** Keywords ***
Verify Banner
  Wait Until Element Is Visible    xpath=//*[@id="app"]/img
  Element Attribute Value Should Be    xpath=//*[@id="app"]/img    src    ${bannerImage}

Verify Title
  Wait Until Element Is Visible    xpath=//*[@id="app"]/div[1]/h1
  Element Should Contain    xpath=//*[@id="app"]/div[1]/h1  ${title}

Verify Subtitle
  Wait Until Element Is Visible    xpath=//*[@id="app"]/div[1]/h1/span
  Element Should Contain    xpath=//*[@id="app"]/div[1]/h1/span  ${subTitle}

Selct Dropdown Menu For Name
  Wait Until Element Is Visible    xpath=//*[@id="app"]/div[1]/div/select
  Click Element    xpath=//*[@id="app"]/div[1]/div/select
  Wait Until Element Is Visible    xpath=//*[@id="app"]/div[1]/div/select/option[1]
  Click Element    xpath=//*[@id="app"]/div[1]/div/select/option[1]

Selct Dropdown Menu For Article
  Wait Until Element Is Visible    xpath=//*[@id="app"]/div[1]/div/select
  Click Element    xpath=//*[@id="app"]/div[1]/div/select
  Wait Until Element Is Visible    xpath=//*[@id="app"]/div[1]/div/select/option[2]
  Click Element    xpath=//*[@id="app"]/div[1]/div/select/option[2]

Verify Dropdown Menu
  Click Element    xpath=//*[@id="app"]/div[1]/div/select
  Wait Until Element Is Visible    xpath=//*[@id="app"]/div[1]/div/select/option[1]
  Wait Until Element Is Visible    xpath=//*[@id="app"]/div[1]/div/select/option[2]
  Element Should Contain    xpath=//*[@id="app"]/div[1]/div/select/option[1]  ${dropdownName}
  Element Should Contain    xpath=//*[@id="app"]/div[1]/div/select/option[2]  ${dropdownArticle}

Verify Search Input
  Wait Until Element Is Visible    xpath=//*[@id="app"]/div[1]/div/input
  Element Should Contain    xpath=//*[@id="app"]/div[1]/div/input    \

Verify Match The Number Text
  Wait Until Element Is Visible    xpath=//*[@id="app"]/div[1]/span
  Element Should Contain    xpath=//*[@id="app"]/div[1]/span  ${matchTheNumberText}

Get Match The Number Total
  Wait Until Element Is Visible    xpath=//*[@id="app"]/div[1]/span
  ${resp} =    Get Text    xpath=//*[@id="app"]/div[1]/span
  Log    ${resp}
  ${respNumber} =    Convert To Integer    ${resp.split(':')[1]}    10
  [Return]    ${respNumber}

Input Search Content
  [Arguments]    ${content}
  Verify Search Input
  Input Text    xpath=//*[@id="app"]/div[1]/div/input    ${content}

Get Search Result Content Total
  ${sum} =   Set Variable    0
  WHILE    True
    ${sum}=    Evaluate    ${sum} + 1
    ${status} =  Run Keyword And Return Status    Element Should Be Visible     xpath=//*[@id="app"]/div[3]/div/div[${sum}]
    IF    ${status} == False    BREAK
  END
  [Return]    ${sum - 1}

Verify Input Search Content
  [Arguments]    ${content}
  Input Search Content    ${content}
  ${matchTotal} =    Get Match The Number Total
  ${resultTotal} =    Get Search Result Content Total
  Should Be Equal As Numbers    ${matchTotal}    ${resultTotal}