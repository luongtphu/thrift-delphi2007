program Test_ThriftLib;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  uTypes in 'uTypes.pas',
  Thrift.Console in 'Thrift.Console.pas',
  Thrift in 'Thrift.pas',
  Thrift.Processor.Multiplex in 'Thrift.Processor.Multiplex.pas',
  Thrift.Protocol.Multiplex in 'Thrift.Protocol.Multiplex.pas',
  Thrift.Protocol in 'Thrift.Protocol.pas',
  Thrift.Serializer in 'Thrift.Serializer.pas',
  Thrift.Server in 'Thrift.Server.pas',
  Thrift.Stream in 'Thrift.Stream.pas',
  Thrift.Transport in 'Thrift.Transport.pas',
  Thrift.Transport.Pipes in 'Thrift.Transport.Pipes.pas',
  Thrift.Utils in 'Thrift.Utils.pas',
  uCollections in 'uCollections.pas',
  uRTLConsts in 'uRTLConsts.pas',
  uStringBuilder in 'uStringBuilder.pas',
  uSysUtils in 'uSysUtils.pas';

begin
  Writeln('Test Lib....');
end.
