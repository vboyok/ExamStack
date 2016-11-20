@echo off  
  
rem 修改控制台颜色  
color 1d  
  
rem * 使用JavaService将TestTimer安装为Windows服务的脚本  
rem *  
rem * JavaService - Windows NT Service Daemon for Java applications  
rem * Copyright (C) 2006 Multiplan Consultants Ltd. LGPL Licensing applies  
rem * Information about the JavaService software is available at the ObjectWeb  
rem * web site. Refer to http://javaservice.objectweb.org for more details.  
  
rem 开始批处理文件中环境改动的本地化操作，在使用endlocal后环境将恢复到原先的内容  
SETLOCAL  
  
rem 设置环境变量,指向当前路径  
SET BASE_PATH=C:\work-env\jar-war\ExamStack
  
rem 设置Java path: jre_home ,已安装JAVA，所以注释掉 
SET JRE_HOME=C:\Program Files\Java\jre1.8.0_112
  
rem 判断JRE_HOME是否正确  
if "%JRE_HOME%" == "" goto no_java  
if not exist "%JRE_HOME%\bin\java.exe" goto no_java  
  
rem 设置jvm内存分配情况  
set JVM_MEMORY=-Xms256m -Xmx1024m   
  
rem 设置jvmdll使用哪一种模式  
SET jvmdll=%JRE_HOME%\bin\server\jvm.dll  
if not exist "%jvmdll%" goto no_java  
  
rem 设置JavaService路径  
set JSEXE=%BASE_PATH%\JavaService.exe
  
rem 判断jar是否正确  
SET acctjar=%BASE_PATH%\ScoreMarker.jar
if not exist "%acctjar%" goto no_peer

  
@echo . Using following version of JavaService executable:  
@echo .  
"%JSEXE%" -version  
@echo .  
  
rem parameters and files seem ok, go ahead with the service installation  
@echo .  
  
rem 处理该批处理的输入参数，后台服务启动模式：自动  
SET svcmode=  
if "%1" == "-manual" SET svcmode=-manual  
if "%1" == "-auto" SET svcmode=-auto  
  
  
rem 设置JAVA_OPTS  
set JAVA_OPTS=%JAVA_OPTS% -Djava.class.path="%BASE_PATH%\ScoreMarker.jar"  
set JAVA_OPTS=%JAVA_OPTS% %JVM_MEMORY%  
  
rem 设置startstop  
SET START_STOP=-start com.examstack.scoremarker.ScoreMarkerWin
  
  
rem 设置Log文件路径  
set OUT_ERR=-out "%BASE_PATH%\logs\service_out.log" -err "%BASE_PATH%\logs\service_err.log"  
  
rem 设置desp  
set DESP=-description "ScoreMarker Service, use for ExamStack"   
  
rem 设置执行命令行  
set runcmd="%JSEXE%" -install Vince-ScoreMarkerService  
set runcmd=%runcmd% "%jvmdll%"  
set runcmd=%runcmd% %JAVA_OPTS%  
set runcmd=%runcmd% %START_STOP%  
set runcmd=%runcmd% %OUT_ERR%  
set runcmd=%runcmd% -current  
set runcmd=%runcmd% "%BASE_PATH%"  
set runcmd=%runcmd% %svcmode%  
set runcmd=%runcmd% -overwrite  
set runcmd=%runcmd% -startup 6  
set runcmd=%runcmd% %DESP%  
echo %runcmd%  
  
rem 执行安装命令  
%runcmd%  
  
rem 启动服务  
net start Vince-ScoreMarkerService  
  
if ERRORLEVEL 1 goto js_error  
  
goto end  
  
:no_java  
@echo . 没有Java运行环境，安装脚本不能运行  
goto error_exit  
  
:no_peer  
@echo . BASE_PATH = %BASE_PATH%
@echo . acctjar = %acctjar%

@echo . 启动文件xxxx.jar不存在，安装脚本不能运行  
goto error_exit  
  
  
:no_jsexe  
@echo . 可执行文件JavaService.exe 不存在，安装脚本不能运行  
goto error_exit  
  
  
:js_error  
@echo . 在安装为服务的过程中发生了错误，请检查相关日志文件  
goto error_exit  
  
:error_exit  
@echo .  
@echo .  
@echo . 安装失败，不能将 jar安装为Windows服务  
@echo .  
@echo . 命令格式:  
@echo .  
@echo .  %~n0 [-auto / -manual] [-np]  
@echo .  
@echo . 其中:  
@echo .  -auto (默认) or -manual 参数说明了服务的启动模式：自动或者手动  
@echo .  -np 批处理命令执行完毕后不暂停  
@echo .  
@echo . 比如:  
@echo .  %~n0 -auto -np  
  
:end  
ENDLOCAL  
@echo .  
if "%2" NEQ "-np" @pause  