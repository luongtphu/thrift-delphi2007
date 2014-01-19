@echo -----------------------------------------
@echo Compile Sample
@echo Please set path delphi 2007 compiler if necessary 
@echo -----------------------------------------
@SET D2007="D:\Program Files\CodeGear\RAD Studio\5.0\bin\dcc32.exe"
@echo -----------------------------------------
@echo Compiling Sample1Client.dpr
@%D2007% Sample1Client.dpr -U"..\src" -U"gen-delphi7"

@echo -----------------------------------------
@echo Compiling Sample1Server.dpr
@%D2007% Sample1Server.dpr -U"..\src" -U"gen-delphi7"

@echo -----------------------------------------
@echo Compiling Sample2Client.dpr
@%D2007% Sample2Client.dpr -U"..\src" -U"gen-delphi7"

@echo -----------------------------------------
@echo Compiling Sample2Server.dpr
@%D2007% Sample2Server.dpr -U"..\src" -U"gen-delphi7"

@echo Press any key to exit
@pause