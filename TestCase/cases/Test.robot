*** Settings ***
Library           Collections

*** Test Cases ***
123
    Comment    log    ${CURDIR}${:}
    Comment    Should Be Equal    ${SPACE}    \ \
    Comment    log    ${SPACE}
    Comment    Should Be Equal    ${EMPTY}    ${EMPTY}
    Comment    log    ${EMPTY}
    @{element}    Create List    a    b    c
    FOR    ${index}    ${element}    IN ENUMERATE    @{element}
    log    ${index}

For-in-enumerate with two values per iteration
    &{a}    Create Dictionary
    FOR    ${index}    ${english}    ${finnish}    IN ENUMERATE    cat    kissa    dog    koira    horse    hevonen
    \    Set To Dictionary    ${a}    ${english}=${finnish}
    log    ${a}

For-in-zip
    @{NUMBERS}    Create List    ${1}    ${2}    ${3}
    @{NAMES}    Create List    one    two    three
    FOR    ${number}    ${name}    IN ZIP    ${NUMBERS}    ${NAMES}
    \    log    ${number}${name}
