@echo off  
  
rem 修改控制台颜色  
color 1d  
  
rem * 使用JavaService卸载TestTimerService服务的脚本  
rem *  
rem * JavaService - Windows NT Service Daemon for Java applications  
rem * Copyright (C) 2006 Multiplan Consultants Ltd. LGPL Licensing applies  
rem * Information about the JavaService software is available at the ObjectWeb  
rem * web site. Refer to http://javaservice.objectweb.org for more details.  
  
rem 开始批处理文件中环境改动的本地化操作，在使用endlocal后环境将恢复到原先的内容  
SETLOCAL  
  

rem 设置JavaService的路径  
SET BASE_PATH=C:\work-env\jar-war\ExamStack
set JSEXE=%BASE_PATH%\JavaService.exe  
  
rem 卸载服务前先停止服务  
net stop Vince-ScoreMarkerService   
  
rem 设置执行命令行  
set runcmd="%JSEXE%" -uninstall Vince-ScoreMarkerService   
  
%runcmd%  
  
@echo .  
  
ENDLOCAL  
@echo .  
if "%2" NEQ "-np" @pause 