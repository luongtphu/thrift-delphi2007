program TestLib;

{%File 'delphi2007Lib\uDefine.inc'}

uses
  Forms,
  FrmTestUnit1 in 'FrmTestUnit1.pas' {Form1},
  Thrift.Utils in 'delphi2007Lib\Thrift.Utils.pas',
  uRTLConsts in 'delphi2007Lib\uRTLConsts.pas',
  uStringBuilder in 'delphi2007Lib\uStringBuilder.pas',
  uSysUtils in 'delphi2007Lib\uSysUtils.pas',
  uTypes in 'delphi2007Lib\uTypes.pas',
  uCollections in 'delphi2007Lib\uCollections.pas',
  Thrift.Stream in 'delphi2007Lib\Thrift.Stream.pas',
  Thrift.Transport in 'delphi2007Lib\Thrift.Transport.pas',
  Thrift.Transport.Pipes in 'delphi2007Lib\Thrift.Transport.Pipes.pas',
  Thrift.Protocol in 'delphi2007Lib\Thrift.Protocol.pas',
  Thrift.Protocol.Multiplex in 'delphi2007Lib\Thrift.Protocol.Multiplex.pas',
  Thrift.Serializer in 'delphi2007Lib\Thrift.Serializer.pas',
  Thrift in 'delphi2007Lib\Thrift.pas',
  Thrift.Processor.Multiplex in 'delphi2007Lib\Thrift.Processor.Multiplex.pas',
  Thrift.Console in 'delphi2007Lib\Thrift.Console.pas',
  Thrift.Server in 'delphi2007Lib\Thrift.Server.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
