*** Settings ***

Library  OperatingSystem
Suite Setup    Check Permission
Test Setup     Creating Testdir
Test Teardown  Delete Testdir

*** Variables ***

${dir_1}   ${CURDIR}${/}test/dir_1
${dir_2}   ${CURDIR}${/}test/dir_2
${file_1}  ${CURDIR}${/}test/file_1
${file_2}  ${CURDIR}${/}test/file_2
${file_3}  ${CURDIR}${/}test/file_3
${file_4}  ${CURDIR}${/}test/dir_1/file_4
${file_5}  ${CURDIR}${/}test/dir_1/file_5
${file_6}  ${CURDIR}${/}test/dir_2/file_6

*** Test Cases ***

rm
    [Documentation]  Must only delete file, don't touch other files
    RUN                     rm ${file_1}
    directory should exist  ${dir_1}
    directory should exist  ${dir_2}
    file should not exist   ${file_1}
    file should exist       ${file_2}
    file should exist       ${file_3}
    file should exist       ${file_4}
    file should exist       ${file_5}
    file should exist       ${file_6}

rm with -f
    [Documentation]       log file should be empty when delete unexisting file
    RUN                   rm -f ${CURDIR}${/}test/file_7 2>${CURDIR}${/}test/log.txt
    file should be empty  ${CURDIR}${/}test/log.txt

rm with -r
    [Documentation]             should delete all files and categories
    RUN                         rm -r ${dir_1}
    file should not exist       ${file_4}
    file should not exist       ${file_5}
    directory should not exist  ${dir_1}



*** Keywords ***

Check Permission
    create directory        ${CURDIR}${/}test
    [Documentation]         If you can create directory you can create/remove files
    DIRECTORY SHOULD EXIST  ${CURDIR}${/}test
    create directory        ${CURDIR}${/}test

Creating Testdir
    [Documentation]   Doing operations with this files
    create directory  ${CURDIR}${/}test
    create directory  ${dir_1}
    create directory  ${dir_2}
    create file       ${file_1}
    create file       ${file_2}
    create file       ${file_3}
    create file       ${file_4}
    create file       ${file_5}
    create file       ${file_6}

Delete Testdir

    remove directory  ${CURDIR}${/}test  ${true}
