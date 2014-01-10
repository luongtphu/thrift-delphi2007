program Sample1Server;

{$APPTYPE CONSOLE}

uses
  SysUtils,classes,
  Thrift,uCollections,Thrift.Utils,Thrift.Stream,Thrift.Protocol,Thrift.Server,Thrift.Transport,
  Sample1 in 'gen-delphi7\Sample1.pas';

const
U_PORT=9090;
{Server Prototype}
type
  TSample1Handler = class( TInterfacedObject, TSample1.Iface)
  public

    // TSample1.Iface
    procedure ping();
    function add(num1: Integer; num2: Integer): Integer;

  public
    constructor Create;
    destructor Destroy;  override;

  end;
{Server App}
type
  TSample1Server = class
  public
    class procedure Main;
  end;

{ TSample1Handler }

function TSample1Handler.add(num1, num2: Integer): Integer;
begin
  result := num1 + num2;
end;

constructor TSample1Handler.Create;
begin
  inherited Create;
end;

destructor TSample1Handler.Destroy;
begin

  inherited;
end;

procedure TSample1Handler.ping;
begin
  WriteLn( 'ping()');
end;

{Main App}
{ TSample1Server }

class procedure TSample1Server.Main;
var handler   : TSample1.Iface;
    processor : IProcessor;
    transport : IServerTransport;
    server    : IServer;
begin
  try
    handler   := TSample1Handler.Create;
    processor := TSample1.TProcessorImpl.Create( handler);
    transport := TServerSocketImpl.Create( U_PORT);
    server    := TSimpleServer.Create( processor, transport);

    WriteLn( 'Starting the server...');
    server.Serve();

  except
    on e: Sysutils.Exception do WriteLn( e.Message);
  end;

  WriteLn('done.');
end;



begin
  try
    Writeln( 'Thrift Delphi Sample Version '+Thrift.Version);
    Writeln( 'Server Starting port:',U_PORT);
    TSample1Server.Main;
    Writeln( 'Server Started port:',U_PORT,' OK');
    Readln;
  except
    on E:Sysutils.Exception do
      Writeln(E.Classname, ': ', E.Message);
  end;
end.
