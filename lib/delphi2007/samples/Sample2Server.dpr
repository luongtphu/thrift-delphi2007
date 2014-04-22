program Sample2Server;

{$APPTYPE CONSOLE}

uses
  SysUtils,classes,
  Thrift,uCollections,Thrift.Utils,Thrift.Stream,Thrift.Protocol,Thrift.Server,Thrift.Transport,
  Sample2 in 'gen-delphi7\Sample2.pas';

const
U_PORT=9090;
{Server Prototype}
type
  TSample2Handler = class( TInterfacedObject, TSample2.Iface)
  public
    // TSample2.Iface
    procedure ping();
    function add(num1: Integer; num2: Integer): Integer;
    function calculate(logid: Integer; const w: IWork): Integer;
    procedure zip();
    procedure echoVoid();
    function echoByte(arg: ShortInt): ShortInt;
    function echoI32(arg: Integer): Integer;
    function echoI64(const arg: Int64): Int64;
    function echoString(const arg: string): string;
    function echoList(const arg: IThriftList_V): IThriftList_V;
    function echoSet(const arg: IHashSet_V): IHashSet_V;
    function echoMap(const arg: IThriftDictionary_V_V): IThriftDictionary_V_V;
  public
    constructor Create;
    destructor Destroy;  override;

  end;
{Server App}
type
  TSample2Server = class
  public
    class procedure Main;
  end;

{ TSample1Handler }

function TSample2Handler.add(num1, num2: Integer): Integer;
begin
  result := num1 + num2;
end;
function TSample2Handler.calculate(logid: Integer; const w: IWork): Integer;
begin
  result:=0;
  try
  case w.Op of
  Sample2.ADD:result:=w.Num1+w.Num2;
  Sample2.SUBTRACT:result:=w.Num1-w.Num2;
  Sample2.MULTIPLY:result:=w.Num1+w.Num2;
  Sample2.DIVIDE:result:=Round( w.Num1 / w.Num2);
  else
    raise TInvalidOperation.Create( Ord(w.Op), 'Unknown operation');
  end;
  except
    on e:Thrift.TException do raise;  // let Thrift Exceptions pass through
    on e:Exception do raise TInvalidOperation.Create( Ord(w.Op), e.Message);  // repackage all other
  end;
end;
procedure TSample2Handler.zip();
begin

end;
constructor TSample2Handler.Create;
begin
  inherited Create;
end;

destructor TSample2Handler.Destroy;
begin

  inherited;
end;

function TSample2Handler.echoByte(arg: ShortInt): ShortInt;
begin

end;

function TSample2Handler.echoI32(arg: Integer): Integer;
begin

end;

function TSample2Handler.echoI64(const arg: Int64): Int64;
begin

end;

function TSample2Handler.echoList(const arg: IThriftList_V): IThriftList_V;
begin

end;

function TSample2Handler.echoMap(
  const arg: IThriftDictionary_V_V): IThriftDictionary_V_V;
begin

end;

function TSample2Handler.echoSet(const arg: IHashSet_V): IHashSet_V;
begin

end;

function TSample2Handler.echoString(const arg: string): string;
begin

end;

procedure TSample2Handler.echoVoid;
begin

end;

procedure TSample2Handler.ping;
begin
  WriteLn( 'ping()');
end;

{Main App}
{ TSample1Server }

class procedure TSample2Server.Main;
var handler   : TSample2.Iface;
    processor : IProcessor;
    transport : IServerTransport;
    server    : IServer;
begin
  try
    handler   := TSample2Handler.Create;
    processor := TSample2.TProcessorImpl.Create( handler);
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
    TSample2Server.Main;
    Writeln( 'Server Started port:',U_PORT,' OK');
    Readln;
  except
    on E:Sysutils.Exception do
      Writeln(E.Classname, ': ', E.Message);
  end;
end.
