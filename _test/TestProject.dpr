program TestProject;

{$APPTYPE CONSOLE}



{%File 'delphi2007Lib\uDefine.inc'}

uses
  SysUtils,
  Thrift.Utils in 'delphi2007Lib\Thrift.Utils.pas',
  uRTLConsts in 'delphi2007Lib\uRTLConsts.pas',
  uStringBuilder in 'delphi2007Lib\uStringBuilder.pas',
  uSysUtils in 'delphi2007Lib\uSysUtils.pas',
  trialtest in 'gen-delphi7\trialtest.pas',
  Thrift.Collections in 'delphi2007Lib\Thrift.Collections.pas',
  Thrift.Console in 'delphi2007Lib\Thrift.Console.pas',
  Thrift in 'delphi2007Lib\Thrift.pas',
  Thrift.Processor.Multiplex in 'delphi2007Lib\Thrift.Processor.Multiplex.pas',
  Thrift.Protocol.JSON in 'delphi2007Lib\Thrift.Protocol.JSON.pas',
  Thrift.Protocol.Multiplex in 'delphi2007Lib\Thrift.Protocol.Multiplex.pas',
  Thrift.Protocol in 'delphi2007Lib\Thrift.Protocol.pas',
  Thrift.Serializer in 'delphi2007Lib\Thrift.Serializer.pas',
  Thrift.Server in 'delphi2007Lib\Thrift.Server.pas',
  Thrift.Stream in 'delphi2007Lib\Thrift.Stream.pas',
  Thrift.Transport in 'delphi2007Lib\Thrift.Transport.pas',
  Thrift.Transport.Pipes in 'delphi2007Lib\Thrift.Transport.Pipes.pas',
  Thrift.TypeRegistry in 'delphi2007Lib\Thrift.TypeRegistry.pas',
  uCollections in 'delphi2007Lib\uCollections.pas';

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
  except
    on E:Exception do
      Writeln(E.Classname, ': ', E.Message);
  end;
end.
