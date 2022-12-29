*** Settings ***
Documentation       Playwright template.
Library             RPA.Browser.Playwright
Library             lib/lib.py

*** Variables ***
${NOPECHA_KEY}    YOUR API KEY


*** Tasks ***
Nopecha
    ${data}=    Download Nopecha
    Starting a browser with a page    ${data}
    GoTo Setup Nopecha    ${NOPECHA_KEY}
    Test Recaptcha
    Test Hcaptcha

*** Keywords ***
Starting a browser with a page
    [Arguments]    ${data}
    @{args}=    Create List    --no-sandbox    --disable-infobars    --disable-dev-shm-usage    --disable-blink-features=AutomationControlled    --no-first-run    --no-service-autorun    --password-store=basic    @{data}
    New Persistent Context  browser=chromium  headless=False  args=${args}    viewport={'width': 1920, 'height': 1080}


GoTo Setup Nopecha
    [Arguments]    ${api_key}
    Go To    https://nopecha.com/setup#${api_key}
    Sleep    5s
    Reload
    Sleep    5s
    #sometimes the nopecha extension needs refreshing


Test Recaptcha
    ${promise_recaptcha}      Promise To      Wait For Function    () => window.grecaptcha.getResponse().length > 0    selector=body    timeout=60s
    Go To    https://www.google.com/recaptcha/api2/demo
    Wait For      ${promise_recaptcha}
    Sleep    5s

Test Hcaptcha
    ${promise_hcaptcha}      Promise To      Wait For Function    () => window.hcaptcha.getResponse().length > 0    selector=body    timeout=60s
    Go To    https://accounts.hcaptcha.com/demo
    Wait For      ${promise_hcaptcha}
    Sleep    5s