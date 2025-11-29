*** Settings ***
Library           SeleniumLibrary
Variables         ../../../resources/testData.py

*** Test Cases ***
Buy Product Test
    [Documentation]    Buy product test on Chrome via BrowserStack
    
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    set_capability    bstack:options    ${{{"buildName": "Chrome - Buy", "sessionName": "Test 3: Buy Product - Chrome"}}}
    
    Open Browser    ${baseUrl}    chrome    remote_url=${REMOTE_URL}    options=${chrome_options}
    
    Maximize Browser Window
    
    # Log in
    Wait Until Element Is Visible    css:#login2    15s
    Execute Javascript    document.querySelector('#login2').click()
    Wait Until Element Is Visible    id:loginusername    15s
    Input Text    id:loginusername    ${login}
    Input Password    id:loginpassword    ${password}
    Click Element    xpath://button[text()='Log in']
    Wait Until Element Is Visible    id:nameofuser    15s

    # Click first product
    Wait Until Page Contains Element    css:#tbodyid > div:nth-child(1) > div > div > h4 > a    15s
    Execute Javascript    document.querySelector('#tbodyid > div:nth-child(1) > div > div > h4 > a').click()
    Wait Until Page Contains    Samsung galaxy s6    15s

    # Add to cart
    Wait Until Element Is Visible    css:#tbodyid > div.row > div > a    15s
    Execute Javascript    document.querySelector('#tbodyid > div.row > div > a').click()
    Handle Alert    ACCEPT

    # Return to Home
    Wait Until Element Is Visible    css:#navbarExample > ul > li.nav-item.active > a    15s
    Execute Javascript    document.querySelector('#navbarExample > ul > li.nav-item.active > a').click()
    Wait Until Page Contains    PRODUCT STORE    15s

    # Go to cart
    Wait Until Element Is Visible    css:#cartur    15s
    Execute Javascript    document.querySelector('#cartur').click()
    Wait Until Page Contains    Place Order    15s

    # Place order
    Wait Until Element Is Visible    css:#page-wrapper > div > div.col-lg-1 > button    15s
    Execute Javascript    document.querySelector('#page-wrapper > div > div.col-lg-1 > button').click()
    Wait Until Element Is Visible    css:#name    15s
    Input Text    css:#name    Iliyas
    Sleep    1s
    Input Text    css:#card    13
    Sleep    1s
    Execute Javascript    document.querySelector('#orderModal > div > div > div.modal-footer > button.btn.btn-primary').click()
    
    # Close success modal
    Wait Until Element Is Visible    css:body > div.sweet-alert.showSweetAlert.visible > div.sa-button-container > div > button    10s
    Sleep    2s
    Click Element    css:body > div.sweet-alert.showSweetAlert.visible > div.sa-button-container > div > button
    Sleep    2s
    
    # Mark test as PASSED
    Execute Javascript    browserstack_executor: {"action": "setSessionStatus", "arguments": {"status":"passed", "reason": "Purchase successful"}}
    
    Close All Browsers
    [Teardown]    Run Keyword If Test Failed    Mark Test Failed    AND    Close All Browsers

*** Keywords ***
Mark Test Failed
    Execute Javascript    browserstack_executor: {"action": "setSessionStatus", "arguments": {"status":"failed", "reason": "Test failed"}}
    Close All Browsers
