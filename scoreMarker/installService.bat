
set SERVICE_NAME=ScoreMarkerService
set APP_NAME=ScoreMarker


set APP_DIR=C:\work-env\jar&war\ExamStack
set APP_HOME=%APP_DIR%\%APP_NAME%
set PR_INSTALL=%APP_DIR%\prunsrv.exe

 
REM Service log configuration
set PR_LOGPREFIX=%SERVICE_NAME%
set PR_LOGPATH=%APP_HOME%\logs
set PR_STDOUTPUT=%APP_HOME%\logs\stdout.txt
set PR_STDERROR=%APP_HOME%\logs\stderr.txt
set PR_LOGLEVEL=Error

REM Path to java installation
set PR_JVM=%JAVA_HOME%\jre\bin\server\jvm.dll
set PR_CLASSPATH=%APP_DIR%\ScoreMarker-2.0.0.jar
 
REM Startup configuration
set PR_STARTUP=auto
set PR_STARTMODE=jvm
set PR_STARTCLASS=com.examstack.scoremarker.ScoreMarkerWin
set PR_STARTMETHOD=start
 
REM Shutdown configuration
set PR_STOPMODE=jvm
set PR_STOPCLASS=%PR_STARTCLASS%
set PR_STOPMETHOD=stop
 
REM JVM configuration
set PR_JVMMS=256
set PR_JVMMX=1024
set PR_JVMSS=4000
set PR_JVMOPTIONS=-Duser.language=DE;-Duser.region=de
 
REM Install service
prunsrv.exe //IS//%SERVICE_NAME%