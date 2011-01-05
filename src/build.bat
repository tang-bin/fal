echo Create config.xml
@echo off
set SDK_PATH=D:\flex_SDK\4.1AIR2
set ROOT_PATH=%~dp0
set OUTPUT=%ROOT_PATH%..\tags\fb-aslib.swc

echo ^<flex-config^> > %ROOT_PATH%config.xml
echo 	^<output^>%OUTPUT%^</output^> >> %ROOT_PATH%config.xml
echo 	^<compiler^> >> %ROOT_PATH%config.xml
echo 		^<source-path^> >> %ROOT_PATH%config.xml
echo 			^<path-element^>%ROOT_PATH%^</path-element^> >> %ROOT_PATH%config.xml
echo 		^</source-path^> >> %ROOT_PATH%config.xml
echo 		^<strict^>true^</strict^> >> %ROOT_PATH%config.xml
echo 		^<external-library-path^> >> %ROOT_PATH%config.xml
echo 			^<path-element^>%SDK_PATH%\frameworks\libs\player\10.0\playerglobal.swc^</path-element^> >> %ROOT_PATH%config.xml
echo 			^<path-element^>%SDK_PATH%\frameworks\libs\textLayout.swc^</path-element^> >> %ROOT_PATH%config.xml
echo 			^<path-element^>%SDK_PATH%\frameworks\libs\osmf.swc^</path-element^> >> %ROOT_PATH%config.xml
echo 			^<path-element^>%SDK_PATH%\frameworks\libs\framework.swc^</path-element^> >> %ROOT_PATH%config.xml
echo 			^<path-element^>%SDK_PATH%\frameworks\libs\spark.swc^</path-element^> >> %ROOT_PATH%config.xml
echo 			^<path-element^>%SDK_PATH%\frameworks\libs\sparkskins.swc^</path-element^> >> %ROOT_PATH%config.xml
echo 			^<path-element^>%SDK_PATH%\frameworks\libs\rpc.swc^</path-element^> >> %ROOT_PATH%config.xml
echo 		^</external-library-path^> >> %ROOT_PATH%config.xml
echo 	^</compiler^> >> %ROOT_PATH%config.xml
for /r %ROOT_PATH% %%f in (*.png) do (
	
	echo ^<include-file^> >> %ROOT_PATH%config.xml
	echo ^<name^>%%~nxf^</name^> >> %ROOT_PATH%config.xml
	echo ^<path^>%%f^</path^> >> %ROOT_PATH%config.xml
	echo ^</include-file^> >> %ROOT_PATH%config.xml
)
echo ^</flex-config^> >> %ROOT_PATH%config.xml
echo Compiling...
%SDK_PATH%\bin\compc -load-config %ROOT_PATH%\config.xml
del %ROOT_PATH%\config.xml
echo Done!
pause