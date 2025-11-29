*** Settings ***
Library           SeleniumLibrary
Variables         ../../resources/testData.py

*** Test Cases ***
Valid Login Test BrowserStack
    [Documentation]    Login test running on BrowserStack cloud
    ${caps}=    Create Dictionary    
    ...    browserName=${BROWSER}
    ...    name=Login Test
    ...    build=Task3 Tests
    
    Open Browser    ${baseUrl}    remote    
    ...    remote_url=${REMOTE_URL}
    ...    desired_capabilities=${caps}
    
    Maximize Browser Window
    Wait Until Element Is Visible    css:#login2    15s
    Execute Javascript    document.querySelector('#login2').click()
    Wait Until Element Is Visible    id:loginusername    15s
    Input Text    id:loginusername    ${login}
    Input Password    id:loginpassword    ${password}
    Click Element    xpath://button[text()='Log in']
    Wait Until Element Is Visible    id:nameofuser    15s
    Sleep    5s
    [Teardown]    Close Browser

