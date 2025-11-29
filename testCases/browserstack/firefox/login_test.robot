*** Settings ***
Library           SeleniumLibrary
Variables         ../../../resources/testData.py

*** Test Cases ***
Valid Login Test
    [Documentation]    Login test on Firefox via BrowserStack
    
    ${firefox_options}=    Evaluate    sys.modules['selenium.webdriver'].FirefoxOptions()    sys, selenium.webdriver
    Call Method    ${firefox_options}    set_capability    bstack:options    ${{{"buildName": "Firefox - Login", "sessionName": "Test 1: Login - Firefox"}}}
    
    Open Browser    ${baseUrl}    firefox    remote_url=${REMOTE_URL}    options=${firefox_options}
    
    Maximize Browser Window
    Wait Until Element Is Visible    css:#login2    15s
    Execute Javascript    document.querySelector('#login2').click()
    Wait Until Element Is Visible    id:loginusername    15s
    Input Text    id:loginusername    ${login}
    Input Password    id:loginpassword    ${password}
    Click Element    xpath://button[text()='Log in']
    Wait Until Element Is Visible    id:nameofuser    15s
    
    # Wait for page to settle
    Wait Until Page Contains    PRODUCT STORE    10s
    Wait Until Element Is Visible    css:#tbodyid > div:nth-child(1)    10s
    Sleep    2s
    
    # Mark test as PASSED
    Execute Javascript    browserstack_executor: {"action": "setSessionStatus", "arguments": {"status":"passed", "reason": "Login successful"}}
    
    Close All Browsers
    [Teardown]    Run Keyword If Test Failed    Mark Test Failed

*** Keywords ***
Mark Test Failed
    Execute Javascript    browserstack_executor: {"action": "setSessionStatus", "arguments": {"status":"failed", "reason": "Test failed"}}
    Close All Browsers
