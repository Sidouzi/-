@echo off&color 17
setlocal enableextensios
setlocal enabledelayedexpansion
if exist "%SystemRoot%\SysWOW64" path %path%;%windir%\SysNative;%SystemRoot%\SysWOW64;%~dp0
bcdedit >nul
if '%errorlevel%' NEQ '0' (goto UACPrompt) else (goto UACAdmin)
:UACPrompt
%1 start "" mshta vbscript:createobject("shell.application").shellexecute("""%~0""","::",,"runas",1)(window.close)&exit
exit /B
:UACAdmin
cd /d "%~dp0"



set mark="
set /a count =0
set /a lookfile =0
set /a presearch =0
mode con cols=62 lines=30
color 2F
:main
cls
echo ��ǰ����·��:%CD%
echo �汾v1.0 ����������ʷ�汾�鿴
echo    ����ȷ��·����ȷ��ִ�в�������     ����ԱȨ��:OK
echo ************************************************************
echo *                                                          *
echo *                                                          *
echo *  ѡ��ģʽ:                                               *
echo *            1.ȷ���ļ���Y��                               *
echo *            2.ȷ���ļ�������ɾ�������ļ����ԣ�            * 
echo *            3.ȷ���ļ�������ɾ�������ļ����Ժ�Ԥ����              *
echo *            4.ɾ���ļ���д���ˣ�                          *
echo *            5.ɾ�����ļ��У�д���ˣ�                      *
echo *            6.�߼�ģʽ��ûд�꣩                          *
echo *            7.ȫ�Զ�����ɾ�������أ���ûд�꣩            *
echo *                                                          *
echo *                                                          *
echo *           ȷ���ļ� (Y/1)               ɾ���ļ���2��     *
echo *                                                          *
echo ************************************************************
set /p user_maininput=(������ ����/Y/N)   (�������������˳�) 
if %user_maininput% equ 1 goto lookfile
if %user_maininput% equ 2 set /a lookfile =1
if %user_maininput% equ 2 goto lookfile
if %user_maininput% equ 3 set /a presearch =1
if %user_maininput% equ 3 goto lookfile
if %user_maininput% equ 4 goto deletefile
if %user_maininput% equ 5 goto EmptyFolder
if %user_maininput% equ Y goto lookfile
if %user_maininput% equ y goto lookfile
exit


::��ȷ���ļ�������
:lookfile

cls
echo ��ʼִ��...
set /a count =0
echo �������ļ�Ŀ¼�б� :>C:\\ListInvalidFile.txt
echo ɾ����Ŀ���ɲ�ɾ����Ӧ�ļ��� :>>C:\\ListInvalidFile.txt
echo ����ִ��Ԥ����...
 
if  %lookfile% == 1 (
set /a lookfile =0
echo �Ѿ�����ɾ�������ļ�����...
goto noattriblookfile
)

if  %presearch% == 1 (
set /a presearch =0
echo �Ѿ�����ɾ�������ļ�����...
echo �Ѿ�����Ԥ����...
goto presearch
)

::����Ϊ�ж�

echo ����ɾ�������ļ�����...
attrib -r -a -s -h -i /s /d
echo OK...

:noattriblookfile

set /a count =0
echo ����ִ���ļ�Ԥ����...
echo ����ȷ�����ļ�����...
for /r  %%t in (*) do (
set /a count +=1
)
echo ȷ����ϣ��ܼ�%count%���ļ���
set /a count =0
echo ����ȷ�����ļ��и���...
for /f "delims=" %%a in ('dir /ad /b /s ^|sort /r') do (
set /a count +=1
)
echo ȷ����ϣ��ܼ�%count%���ļ��С�
set /a count =0

setlocal enabledelayedexpansion

:presearch
echo ��������.tmp�ļ�... 
for /r  %%l in (*.tmp) do (
echo %%l>>C:\\ListInvalidFile.txt && set /a count +=1
)
echo OK... 

echo ��������.~$ -$���ļ�... 
for /r  %%l in (~$*) do (
echo %%l>>C:\\ListInvalidFile.txt && set /a count +=1
)

for /r  %%l in (-$*) do (
echo %%l>>C:\\ListInvalidFile.txt && set /a count +=1
)
echo OK... 

echo ������ϡ�
echo �ܼ������ļ�%count%����
set /a count =0
echo ����C�̸�Ŀ¼�ڵ�ListInvalidFile.txt�鿴У�顣
echo ɾ����Ŀ���ɲ�ɾ����Ӧ�ļ���
echo �������ز˵���
"C:\\ListInvalidFile.txt"
pause
goto main



:deletefile
set /p user_deleteinput=ȷ������������������ ��(������1/2/Y/N)   
if %user_deleteinput% equ y goto deletefileok
if %user_deleteinput% equ Y goto deletefileok
if %user_deleteinput% equ 1 goto deletefileok
exit


::����ȡ�ļ�ɾ���ļ�ģ�顱
:deletefileok
echo ��ʼִ��...
echo ���ڶ�ȡ�����ļ�...
echo ����ɾ��...
setlocal enabledelayedexpansion

for /f "tokens=*" %%d in (C:\\ListInvalidFile.txt) do (
set target=%mark%%%d%mark%
del /f !target!

)
echo ɾ����ϡ� �����˳���
pause
exit


::��ɾ���ļ���ģ�顱
:EmptyFolder
cls
set /a count =0
echo ����ɾ�����ļ���...
for /f "delims=" %%a in ('dir /ad /b /s ^|sort /r') do (
 rd "%%a">nul 2>nul && set /a count +=1
)
echo ɾ����ϡ�
echo �ܼ�ɾ��%count%�����ļ��С�
set /a count =0
echo �����������˵���
pause
goto main