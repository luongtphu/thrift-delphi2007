program Sample1Client;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  classes,
  Thrift,
  uCollections,
  Thrift.Utils,
  Thrift.Stream,
  Thrift.Protocol,
  Thrift.Server,
  Thrift.Transport,
  Sample1 in 'gen-delphi7\Sample1.pas';
const
U_PORT=9090;
{Client App}
type
  TSample1Client = class
  public
    class procedure Main;
  end;

{ TSample1Client }

class procedure TSample1Client.Main;
var transport : ITransport;
    protocol  : IProtocol;
    client    : TSample1.Iface;
    sum, quotient, diff : Integer;

begin
  try
    transport := TSocketImpl.Create( 'localhost', U_PORT);
    protocol  := TBinaryProtocolImpl.Create( transport);
    client    := TSample1.TClient.Create( protocol);

    transport.Open;

    client.ping;
    WriteLn('ping()');

    sum := client.add( 1, 1);
    Writeln( Format( '1+1=%d', [sum]));


    transport.Close();

  except
    on e : Sysutils.Exception
    do WriteLn( e.ClassName+': '+e.Message);
  end;
end;


begin
  try
    Writeln( 'Thrift Delphi Sample Version '+Thrift.Version);
    Writeln( 'Client Connect to Server ');
    TSample1Client.Main;
    Readln;

  except
    on E:Sysutils.Exception do
      Writeln(E.Classname, ': ', E.Message);
  end;
end.
