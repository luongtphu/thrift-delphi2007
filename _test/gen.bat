@echo -----------------------------------------
@echo Gen trialtest.thrift
@echo If you did not see thrift.exe. Please Using VS2010 to recompile project
@echo -----------------------------------------

@..\bin\thrift --gen delphi7 trialtest.thrift

@echo Press any key to exit
@pause