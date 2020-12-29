*** Settings ***
Documentation     UI自动化测试样例
Metadata          VERSION    2.0
Library           Selenium2Library

*** Test Cases ***
search
    Open Browser    https://www.baidu.com/    Google Chrome    googlechrome, chrome, gc
    sleep    2
    Input Text    //*[@id="kw"]    test
    Click Element    //*[@id="su"]
    sleep    3
    Close Browser
