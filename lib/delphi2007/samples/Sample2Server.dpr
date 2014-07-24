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
    function echoXtruct(const arg: IXtruct): IXtruct;
    function echoList(const arg: IThriftList): IThriftList;
    function echoListXtruct(const arg: IThriftList): IThriftList;
    function echoSet(const arg: IHashSet): IHashSet;
    function echoMap(const arg: IThriftDictionary): IThriftDictionary;
    function echoMapXtruct(const arg: IThriftDictionary): IThriftDictionary;
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
  result:=arg;
end;

function TSample2Handler.echoI32(arg: Integer): Integer;
begin
  result:=arg;
end;

function TSample2Handler.echoI64(const arg: Int64): Int64;
begin
  result:=arg;
end;

function TSample2Handler.echoList(const arg: IThriftList): IThriftList;
var
i,n:integer;
begin
  result:=arg;
  n:=arg.Count;
  WriteLn( '===CALL echoList(...)');
  writeln('.Count:',n);
  for i:= 0 to n - 1 do
  begin
    writeln(arg[i]);
  end;
  WriteLn( '===CALL echoList(...) End');
end;

function TSample2Handler.echoListXtruct(const arg: IThriftList): IThriftList;
var
i,n:integer;
x:IXtruct;
begin
  result:=arg;
  n:=arg.Count;
  WriteLn( '===CALL echoListXtruct(...)');
  writeln('.Count:',n);
  for i:= 0 to n - 1 do
  begin
    x:=IXtruct(arg.Items[i].AsIntf);
    WriteLn( '.String_thing:',x.String_thing);
    WriteLn( '.Byte_thing:',x.Byte_thing);
    WriteLn( '.I32_thing:',x.I32_thing);
    WriteLn( '.I64_thing:',x.I64_thing);
  end;
  WriteLn( '===CALL echoMapXtruct(...) End');
end;

function TSample2Handler.echoMap(
  const arg: IThriftDictionary): IThriftDictionary;
var
i,n:integer;
begin
  result:=arg;
  n:=arg.Count;
  WriteLn( '===CALL echoMap(...)');
  writeln('.Count:',n);
  for i:= 0 to n - 1 do
  begin
    writeln('(',arg.Keys[i].Value,',',arg.Values[i].Value,')');
  end;
  WriteLn( '===CALL echoMap(...) End');
end;

function TSample2Handler.echoMapXtruct(
  const arg: IThriftDictionary): IThriftDictionary;
var
i,n:integer;
x:IXtruct;
begin
  result:=arg;
  n:=arg.Count;
  WriteLn( '===CALL echoMapXtruct(...)');
  writeln('.Count:',n);
  for i:= 0 to n - 1 do
  begin
    writeln('=>(Key=',arg.Keys[i].Value,')');
    x:=IXtruct(arg.Values[i].AsIntf);
    WriteLn( '.String_thing:',x.String_thing);
    WriteLn( '.Byte_thing:',x.Byte_thing);
    WriteLn( '.I32_thing:',x.I32_thing);
    WriteLn( '.I64_thing:',x.I64_thing);
  end;
  WriteLn( '===CALL echoMapXtruct(...) End');
end;

function TSample2Handler.echoSet(const arg: IHashSet): IHashSet;
begin

end;

function TSample2Handler.echoString(const arg: string): string;
begin
  WriteLn( '===CALL echoString(',arg,')');
  result:=arg;
  WriteLn( '===CALL echoString() End');
end;

procedure TSample2Handler.echoVoid;
begin

end;

function TSample2Handler.echoXtruct(const arg: IXtruct): IXtruct;
begin
  result:=arg;
  WriteLn( '===CALL echoXtruct(...)');
  WriteLn( '.String_thing:',arg.String_thing);
  WriteLn( '.Byte_thing:',arg.Byte_thing);
  WriteLn( '.I32_thing:',arg.I32_thing);
  WriteLn( '.I64_thing:',arg.I64_thing);
  WriteLn( '===CALL echoXtruct() End');
end;

procedure TSample2Handler.ping;
begin
  WriteLn( 'CALL ping()');
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
