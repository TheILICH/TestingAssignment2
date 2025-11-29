*** Settings ***
Library           SeleniumLibrary
Variables         ../../../resources/testData.py

*** Test Cases ***
Buy Product Test
    [Documentation]    Buy product test on Safari via BrowserStack
    
    ${safari_options}=    Evaluate    sys.modules['selenium.webdriver'].SafariOptions()    sys, selenium.webdriver
    Call Method    ${safari_options}    set_capability    bstack:options    ${{{"buildName": "Safari - Buy", "sessionName": "Test 3: Buy Product - Safari", "os": "OS X", "osVersion": "Ventura"}}}
    
    Open Browser    ${baseUrl}    safari    remote_url=${REMOTE_URL}    options=${safari_options}
    
    Wait Until Element Is Visible    css:#login2    15s
    Execute Javascript    document.querySelector('#login2').click()
    Wait Until Element Is Visible    id:loginusername    15s
    Input Text    id:loginusername    ${login}
    Input Password    id:loginpassword    ${password}
    Click Element    xpath://button[text()='Log in']
    Wait Until Element Is Visible    id:nameofuser    15s

    Wait Until Page Contains Element    css:#tbodyid > div:nth-child(1) > div > div > h4 > a    15s
    Execute Javascript    document.querySelector('#tbodyid > div:nth-child(1) > div > div > h4 > a').click()
    Wait Until Page Contains    Samsung galaxy s6    15s

    Wait Until Element Is Visible    css:#tbodyid > div.row > div > a    15s
    Execute Javascript    document.querySelector('#tbodyid > div.row > div > a').click()
    Handle Alert    ACCEPT

    Wait Until Element Is Visible    css:#navbarExample > ul > li.nav-item.active > a    15s
    Execute Javascript    document.querySelector('#navbarExample > ul > li.nav-item.active > a').click()
    Wait Until Page Contains    PRODUCT STORE    15s

    Wait Until Element Is Visible    css:#cartur    15s
    Execute Javascript    document.querySelector('#cartur').click()
    Wait Until Page Contains    Place Order    15s

    Wait Until Element Is Visible    css:#page-wrapper > div > div.col-lg-1 > button    15s
    Execute Javascript    document.querySelector('#page-wrapper > div > div.col-lg-1 > button').click()
    Wait Until Element Is Visible    css:#name    15s
    Input Text    css:#name    Iliyas
    Sleep    1s
    Input Text    css:#card    13
    Sleep    1s
    Execute Javascript    document.querySelector('#orderModal > div > div > div.modal-footer > button.btn.btn-primary').click()
    
    Wait Until Element Is Visible    css:body > div.sweet-alert.showSweetAlert.visible > div.sa-button-container > div > button    10s
    Sleep    2s
    Click Element    css:body > div.sweet-alert.showSweetAlert.visible > div.sa-button-container > div > button
    Sleep    2s
    
    Execute Javascript    browserstack_executor: {"action": "setSessionStatus", "arguments": {"status":"passed", "reason": "Purchase successful"}}
    
    [Teardown]    Teardown Actions

*** Keywords ***
Teardown Actions
    Run Keyword If Test Failed    Execute Javascript    browserstack_executor: {"action": "setSessionStatus", "arguments": {"status":"failed", "reason": "Test failed"}}
    Close All Browsers
