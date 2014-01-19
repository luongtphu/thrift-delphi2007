@echo -----------------------------------------
@echo Gen Thrift_Test1.thrift
@echo If you did not see thrift.exe. Please Using VS2010 to recompile project
@echo -----------------------------------------

@..\..\..\bin\thrift --gen delphi7 Sample1.thrift

@echo Press any key to exit
@pause