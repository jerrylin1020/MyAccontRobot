*** Settings ***
Documentation     A test suite for MyAccount Product tab.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          ../../Resources/resource.robot
Resource          Ti.robot


*** Variables ***



*** Keywords ***




*** Test Cases ***
Create new TE70
   	[Tags]	TE70
    Register Titanium 	TE70

    # Open Browser    http://account.trendmicro.com/?${serial}    ${BROWSER}    ff_profile_dir=${FF_PROFILE}
    # [Teardown]    Close Browser









