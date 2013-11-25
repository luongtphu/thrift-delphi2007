program TestProject;

{$APPTYPE CONSOLE}

{%File 'uDefine.inc'}

uses
  SysUtils,
  Thrift.Protocol in 'Thrift.Protocol.pas',
  Thrift.Utils in 'Thrift.Utils.pas',
  Thrift.Stream in 'Thrift.Stream.pas',
  Thrift.Transport in 'Thrift.Transport.pas',
  uStringBuilder in 'uStringBuilder.pas',
  uRTLConsts in 'uRTLConsts.pas',
  uSysUtils in 'uSysUtils.pas';

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
  except
    on E:Exception do
      Writeln(E.Classname, ': ', E.Message);
  end;
end.
