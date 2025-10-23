*** Settings ***
Library           SeleniumLibrary
Variables         ../../resources/testData.py

*** Test Cases ***
Buy Product Test
    [Documentation]    Login, select first product, add to cart, handle alert, and purchase
    Open Browser    ${baseUrl}    Chrome
    
    # Log in
    Scroll Element Into View    css:#login2
    Wait Until Element Is Visible    css:#login2    10s
    Execute Javascript    document.querySelector('#login2').click()
    Wait Until Element Is Visible    id:loginusername    10s
    Input Text    id:loginusername    ${login}
    Input Password    id:loginpassword    ${password}
    Click Element    xpath://button[text()='Log in']
    Wait Until Element Is Visible    id:nameofuser    10s

    # Click first product (Samsung Galaxy S6)
    Wait Until Page Contains Element    css:#tbodyid > div:nth-child(1) > div > div > h4 > a    10s
    Execute Javascript    document.querySelector('#tbodyid > div:nth-child(1) > div > div > h4 > a').click()
    Wait Until Page Contains    Samsung galaxy s6    10s

    # Add to cart
    Wait Until Element Is Visible    css:#tbodyid > div.row > div > a    10s
    Execute Javascript    document.querySelector('#tbodyid > div.row > div > a').click()
    # Handle alert popup (browser dialog)
    Handle Alert    ACCEPT

    # Return to Home page
    Wait Until Element Is Visible    css:#navbarExample > ul > li.nav-item.active > a    10s
    Execute Javascript    document.querySelector('#navbarExample > ul > li.nav-item.active > a').click()
    Wait Until Page Contains    PRODUCT STORE    10s

    # Go to cart
    Wait Until Element Is Visible    css:#cartur    10s
    Execute Javascript    document.querySelector('#cartur').click()
    Wait Until Page Contains    Place Order    10s

    # Place order
    Wait Until Element Is Visible    css:#page-wrapper > div > div.col-lg-1 > button    10s
    Execute Javascript    document.querySelector('#page-wrapper > div > div.col-lg-1 > button').click()
    Wait Until Element Is Visible    css:#name    10s
    Input Text    css:#name    Iliyas
    Sleep    2s
    Input Text    css:#card    13
    Sleep    2s
    Execute Javascript    document.querySelector('#orderModal > div > div > div.modal-footer > button.btn.btn-primary').click()
    Sleep    10s
    [Teardown]    Close Browser
