program Thrift_Test1_Client;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Thrift_Test1 in 'gen-delphi7\Thrift_Test1.pas';

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
  except
    on E:Exception do
      Writeln(E.Classname, ': ', E.Message);
  end;
end.
