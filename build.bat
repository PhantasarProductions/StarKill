@echo off
rem This is a quick compile script
rem Not the fastest way to do it, but the safest
rem And since Turbo Pascal has a pretty fast compiler anyway
rem Let's not worry about it too much, eh :P

rem Make sure DOSBox has the latest source files (I use vscode to write the code itself, you know)
rescan

rem compile
C:\tp\bin\tpc -IGameInc -UUNITS;..\Units -M StarKill.pas 
if errorlevel 1 goto FoutjeBedankt

rem Let's move all crap to the bin folder!
rem copy *.exe bin > NUL
rem copy *.tpu bin > NUL
rem del *.exe
rem del *.tpu
goto einde

:FoutjeBedankt
echo ^
echo Compliation failed!

rem Time to end this!
:einde
