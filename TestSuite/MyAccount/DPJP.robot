*** Settings ***
Documentation     A test suite for MyAccount Product tab.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          ../Resources/resource.robot
Resource          ../Resources/TextMsg.robot
Resource          ../Utility/backend_utility.robot


# Set Tags


*** Variables ***
${valid_username}   poc-eudb-mpa-allvb@yopmail.com
${valid_password}   12345678


*** Variables ***
${PASSWORD}     12345678
${BETA_DPJP_FULL}       DPJP_FULL_BETA@yopmail.com
${BETA_DPJP_FULL_SN}    BAAB-0012-0924-1993-0800
${PRODUCT_NAME_DPJP}    パスワードマネージャー
${REMAININD_DAYS}   0



*** Keywords ***



*** Test Cases ***
Product DPJP full (D>=31) no AR (Locale=JA-JP)
	[Tags]		MA		ProductTab     DPJP
    # Invoke backend utility to update expiration date
    ${diff_days} =   Set Variable    31
    Set expiration date difference from today   ${BETA_DPJP_FULL_SN}    ${diff_days}

    Open Browser To Login Page	   JA-JP
    Input Username    ${BETA_DPJP_FULL}
    Input Password    ${PASSWORD}
    Submit Credentials
    MyAccount Should Be Open

    # Wait for product is loaded
    Wait until product list is displayed for a single product

    # --------------------------------------------
    #
    # Check Product list area
    #
    # --------------------------------------------
    # 1. Should not have reminder area
    Should not have reminder area

    # --------------------------------------------
    #
    # Check Product list area
    #
    # --------------------------------------------
    # 1. Check product name
    Check product name in product list area    ${PRODUCT_NAME_DPJP}

    # 2. Check has expiration date in product list area
    Should have expiration date in product list area   有効期限:

    # 3. Should not have promotion info
    Should not have promotion in product list area

    # 4. Should have download link.
    ${link}    Set Variable     ${ER_PATH}?TARGET=DPJP&PID=ID10&FUNID=Download&LOCALE=JA-JP
    Should have download link in product list area      ${link}

    # --------------------------------------------
    #
    # Check Remaining days' area
    #
    # --------------------------------------------
    # 1. Check remaining days
    ${remain_days} =   Evaluate    int(${diff_days})+1
    ${remain_days} =   Convert To String    ${remain_days}
    Should have remaining days info in remaining area      ${remain_days}

    # 2. Check BuyNow Renew Upgrade button in remaining area
    ${link}    Set Variable    ${GR_PATH}?locale=JA-JP&SN=${BETA_DPJP_FULL_SN}&Region=0&PID=ID10&CID=CPTS&SRC=S
    ${text}    Set Variable    今すぐ契約更新
    Should have BuyNow Renew Upgrade button in remaining area   ${link}   ${text}

    # 3. Check AutoRenew switch in remaining area
    ${status} =   Set Variable    off
    ${link} =   Set Variable    ${GR_PATH}?locale=JA-JP&SN=${BETA_DPJP_FULL_SN}&Region=0&PID=ID10&CID=OptIn&SRC=S
    Should have AutoRenew switch in remaining area    ${status}    ${link}

    # 4. Check what is AR in remaining area
    ${link} =   Set Variable    ${ER_PATH}?TARGET=DPJP&PID=ID10&FUNID=AutoRenewIntro&LOCALE=JA-JP
    ${text} =   Set Variable    あんしん自動更新とは？
    Should have what is AR in remaining area      ${link}     ${text}

    # 5. Check management in remaining area
    Should not have AR management in remaining area

    [Teardown]    Close Browser

Product DPJP full (D=30) no AR (Locale=JA-JP)
    [Tags]      MA      ProductTab     DPJP
    # Invoke backend utility to update expiration date
    ${diff_days} =   Set Variable    30
    Set expiration date difference from today   ${BETA_DPJP_FULL_SN}    ${diff_days}

    Open Browser To Login Page     JA-JP
    Input Username    ${BETA_DPJP_FULL}
    Input Password    ${PASSWORD}
    Submit Credentials
    MyAccount Should Be Open

    # Wait for product is loaded
    Wait until product list is displayed for a single product
    Wait until reminder area is displayed

    # --------------------------------------------
    #
    # Check Product list area
    #
    # --------------------------------------------
    # 1. Should have reminder area
    Should have reminder warning in reminder area   ${PRODUCT_NAME_DPJP}      今すぐ契約更新      ${GR_PATH}?locale=JA-JP&SN=${BETA_DPJP_FULL_SN}&Region=0&PID=ID10&CID=CPTS&SRC=S


    # --------------------------------------------
    #
    # Check Product list area
    #
    # --------------------------------------------
    # 1. Check product name
    Check product name in product list area    ${PRODUCT_NAME_DPJP}

    # 2. Check has expiration date in product list area
    Should have expiration date in product list area   有効期限:

    # 3. Should not have promotion info
    Should not have promotion in product list area

    # 4. Should have download link.
    ${link}    Set Variable     ${ER_PATH}?TARGET=DPJP&PID=ID10&FUNID=Download&LOCALE=JA-JP
    Should have download link in product list area      ${link}

    # --------------------------------------------
    #
    # Check Remaining days' area
    #
    # --------------------------------------------
    # 1. Check remaining days
    ${remain_days} =   Evaluate    int(${diff_days})+1
    ${remain_days} =   Convert To String    ${remain_days}
    Should have remaining days info in remaining area      ${remain_days}

    # 2. Check BuyNow Renew Upgrade button in remaining area
    ${link}    Set Variable    ${GR_PATH}?locale=JA-JP&SN=${BETA_DPJP_FULL_SN}&Region=0&PID=ID10&CID=CPTS&SRC=S
    ${text}    Set Variable    今すぐ契約更新
    Should have BuyNow Renew Upgrade button in remaining area   ${link}   ${text}

    # 3. Check AutoRenew switch in remaining area
    ${status} =   Set Variable    off
    ${link} =   Set Variable    ${GR_PATH}?locale=JA-JP&SN=${BETA_DPJP_FULL_SN}&Region=0&PID=ID10&CID=OptIn&SRC=S
    Should have AutoRenew switch in remaining area    ${status}    ${link}

    # 4. Check what is AR in remaining area
    ${link} =   Set Variable    ${ER_PATH}?TARGET=DPJP&PID=ID10&FUNID=AutoRenewIntro&LOCALE=JA-JP
    ${text} =   Set Variable    あんしん自動更新とは？
    Should have what is AR in remaining area      ${link}     ${text}

    # 5. Check management in remaining area
    Should not have AR management in remaining area

    [Teardown]    Close Browser








