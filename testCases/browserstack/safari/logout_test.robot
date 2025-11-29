*** Settings ***
Library           SeleniumLibrary
Variables         ../../../resources/testData.py

*** Test Cases ***
Valid Logout Test
    [Documentation]    Logout test on Safari via BrowserStack
    
    ${desired_caps}=    Create Dictionary
    ...    browserName=safari
    ...    browserVersion=latest
    ...    bstack:options=${{'buildName': 'Safari - Logout', 'sessionName': 'Test 2: Logout - Safari', 'os': 'OS X', 'osVersion': 'Ventura'}}
    
    Open Browser    ${baseUrl}    remote_url=${REMOTE_URL}    desired_capabilities=${desired_caps}
    
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
    
    Wait Until Page Contains    PRODUCT STORE    10s
    Sleep    2s
    
    Execute Javascript    browserstack_executor: {"action": "setSessionStatus", "arguments": {"status":"passed", "reason": "Logout successful"}}
    
    [Teardown]    Run Keyword If Test Failed    Mark Test Failed    ELSE    Close All Browsers

*** Keywords ***
Mark Test Failed
    Execute Javascript    browserstack_executor: {"action": "setSessionStatus", "arguments": {"status":"failed", "reason": "Test failed"}}
    Close All Browsers
