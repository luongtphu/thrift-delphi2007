@echo -----------------------------------------
@echo Gen trialtest.thrift
@echo If you did not see thrift.exe. Please Using VS2010 to recompile project
@echo -----------------------------------------

@..\bin\thrift --gen delphi7 Thrift.Test.thrift

@echo Press any key to exit
@pause