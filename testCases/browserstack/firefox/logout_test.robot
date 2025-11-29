*** Settings ***
Library           SeleniumLibrary
Variables         ../../../resources/testData.py

*** Test Cases ***
Valid Logout Test
    [Documentation]    Logout test on Firefox via BrowserStack
    
    ${firefox_options}=    Evaluate    sys.modules['selenium.webdriver'].FirefoxOptions()    sys, selenium.webdriver
    Call Method    ${firefox_options}    set_capability    bstack:options    ${{{"buildName": "Firefox - Logout", "sessionName": "Test 2: Logout - Firefox"}}}
    
    Open Browser    ${baseUrl}    firefox    remote_url=${REMOTE_URL}    options=${firefox_options}
    
    Maximize Browser Window
    Wait Until Element Is Visible    css:#login2    15s
    Execute Javascript    document.querySelector('#login2').click()
    Wait Until Element Is Visible    id:loginusername    15s
    Input Text    id:loginusername    ${login}
    Input Password    id:loginpassword    ${password}
    Click Element    xpath://button[text()='Log in']
    Wait Until Element Is Visible    id:nameofuser    15s
    
    Wait Until Element Is Visible    css:#logout2    15s
    Execute Javascript    document.querySelector('#logout2').click()
    Wait Until Element Is Visible    css:#login2    15s
    
    # Wait for page to settle
    Wait Until Page Contains    PRODUCT STORE    10s
    Sleep    2s
    
    # Mark test as PASSED
    Execute Javascript    browserstack_executor: {"action": "setSessionStatus", "arguments": {"status":"passed", "reason": "Logout successful"}}
    
    Close All Browsers
    [Teardown]    Run Keyword If Test Failed    Mark Test Failed

*** Keywords ***
Mark Test Failed
    Execute Javascript    browserstack_executor: {"action": "setSessionStatus", "arguments": {"status":"failed", "reason": "Test failed"}}
    Close All Browsers
