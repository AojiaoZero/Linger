::Must to convert GBK encoding
@echo off

if "%1" EQU "" (
	::�����ǰ�ļ��в���������
	echo Usage: %0 dir_path
	goto :eof
)

::��ʼ���ã�ʹ�����·��
call :process %1
goto :eof

:process
::��ѯĿ¼�е��ļ��б�
for /f "delims=" %%a in ('dir /a-d /b %1\*.php') do (
	echo FILE��%%a
	if not exist "new_%1" (
		:: ������Ŀ¼���д���
		mkdir "new_%1"
	)
	:: ��ʼ����ת��
	php -w "%1\%%a" > "new_%1\%%a"
)

::��ѯ�ļ����б�
for /f "delims=" %%a in ('dir /ad /b %1') do (
	::�ж��Ƿ�����ļ���
	if exist "%1\%%a" (
		echo -------------------------------------------
		echo DIR��%1\%%a
		::��ʼ���еݹ����
		call :process %1\%%a
	)
)
goto :eof