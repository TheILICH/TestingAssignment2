*** Settings ***
Library           SeleniumLibrary
Variables         ../../resources/testData.py

*** Test Cases ***
Delete Item From Cart Test
    [Documentation]    Login, add product, go to cart, delete item instead of purchase
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
    Handle Alert    ACCEPT

    # Return to Home page
    Wait Until Element Is Visible    css:#navbarExample > ul > li.nav-item.active > a    10s
    Execute Javascript    document.querySelector('#navbarExample > ul > li.nav-item.active > a').click()
    Wait Until Page Contains    PRODUCT STORE    10s

    # Go to cart
    Wait Until Element Is Visible    css:#cartur    10s
    Execute Javascript    document.querySelector('#cartur').click()
    Wait Until Page Contains    Delete    10s

    # Delete item from cart instead of placing order
    Wait Until Element Is Visible    css:#tbodyid > tr > td:nth-child(4) > a    10s
    Execute Javascript    document.querySelector('#tbodyid > tr > td:nth-child(4) > a').click()
    Sleep    5s
    [Teardown]    Close Browser
