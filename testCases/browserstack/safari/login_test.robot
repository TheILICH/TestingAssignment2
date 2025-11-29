*** Settings ***
Library           SeleniumLibrary
Variables         ../../../resources/testData.py

*** Test Cases ***
Valid Login Test
    [Documentation]    Login test on Safari via BrowserStack
    
    ${safari_options}=    Evaluate    sys.modules['selenium.webdriver'].SafariOptions()    sys, selenium.webdriver
    Call Method    ${safari_options}    set_capability    bstack:options    ${{{"buildName": "Safari - Login", "sessionName": "Test 1: Login - Safari", "os": "OS X", "osVersion": "Ventura"}}}
    
    Open Browser    ${baseUrl}    safari    remote_url=${REMOTE_URL}    options=${safari_options}
    
    Wait Until Element Is Visible    css:#login2    15s
    Execute Javascript    document.querySelector('#login2').click()
    Wait Until Element Is Visible    id:loginusername    15s
    Input Text    id:loginusername    ${login}
    Input Password    id:loginpassword    ${password}
    Click Element    xpath://button[text()='Log in']
    Wait Until Element Is Visible    id:nameofuser    15s
    
    Wait Until Page Contains    PRODUCT STORE    10s
    Wait Until Element Is Visible    css:#tbodyid > div:nth-child(1)    10s
    Sleep    2s
    
    Execute Javascript    browserstack_executor: {"action": "setSessionStatus", "arguments": {"status":"passed", "reason": "Login successful"}}
    
    [Teardown]    Teardown Actions

*** Keywords ***
Teardown Actions
    Run Keyword If Test Failed    Execute Javascript    browserstack_executor: {"action": "setSessionStatus", "arguments": {"status":"failed", "reason": "Test failed"}}
    Close All Browsers
