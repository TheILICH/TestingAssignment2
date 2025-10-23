*** Settings ***
Library           SeleniumLibrary
Variables         ../../resources/testData.py

*** Test Cases ***
Valid Logout Test
    [Documentation]    Logs in, then logs out using JavaScript on #logout2.
    Open Browser    ${baseUrl}    Chrome
    Scroll Element Into View    css:#login2
    Wait Until Element Is Visible    css:#login2    10s
    Execute Javascript    document.querySelector('#login2').click()
    Wait Until Element Is Visible    id:loginusername    10s
    Input Text    id:loginusername    ${login}
    Input Password    id:loginpassword    ${password}
    Click Element    xpath://button[text()='Log in']
    Wait Until Element Is Visible    id:nameofuser    10s

    Scroll Element Into View    css:#logout2
    Wait Until Element Is Visible    css:#logout2    10s
    Execute Javascript    document.querySelector('#logout2').click()
    Wait Until Element Is Visible    css:#login2    10s
    Sleep    10s
    [Teardown]    Close Browser
