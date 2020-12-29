*** Settings ***
Documentation     接口自动化测试样例
Suite Setup       Create Session    api    http://116.198.205.37:8099    headers=&{head}
Suite Teardown    Delete All Sessions
Metadata          VERSION    1.0
Library           RequestsLibrary
Library           Collections
Resource          UserKeywords/ServiceKey.robot
Library           OperatingSystem
Library           JSONLibrary

*** Variables ***
&{head}           Content-Type=application/json    Referer=http://116.198.205.37:8099/

*** Test Cases ***
login
    [Setup]
    ${r}=    Post Request    api    /PlatForm-Web/AuthValidate/login    data={"userName":"msgd","passWord":"sq_12345678","sysId":"103","token":""}
    Should Be Equal As Strings    ${r.status_code}    200

获取大数据平台用户名及密码
    [Setup]
    ${token}    获取token值
    ${r}=    Get Request    api    /PlatForm-Web/newPublic/getUserNameAndPsw?token=${token}
    Should Be Equal As Strings    ${r.status_code}    200
    &{msg}    Set Variable    ${r.json()}
    &{userinfo}    Get From Dictionary    ${msg}    result
    Should Not Be Empty    ${userinfo}    loginName

*** Keywords ***
获取token值
    Comment    登录大数据平台并获取token
    ${r}=    Post Request    api    /PlatForm-Web/AuthValidate/login    data={"userName":"msgd","passWord":"sq_12345678","sysId":"103","token":""}
    Should Be Equal As Strings    ${r.status_code}    200
    &{response}    Set Variable    ${r.json()}
    ${token}    Get From Dictionary    ${response}[result]    token
    [Return]    ${token}
