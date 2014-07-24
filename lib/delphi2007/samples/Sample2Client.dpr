program Sample2Client;

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
  Sample2 in 'gen-delphi7\Sample2.pas';
const
U_PORT=9090;
{Client App}
type
  TSample2Client = class
  public
    class procedure Main;
  end;

{ TSample1Client }

class procedure TSample2Client.Main;
var transport : ITransport;
    protocol  : IProtocol;
    client    : TSample2.Iface;
    sum, quotient, diff : int64;
    i:integer;
    work      : IWork;
    sr:string;
    argstruct: IXtruct;
    argl: IThriftList;
    argm: IThriftDictionary;
begin
  try
    transport := TSocketImpl.Create( 'localhost', U_PORT);
    protocol  := TBinaryProtocolImpl.Create( transport);
    client    := TSample2.TClient.Create( protocol);

    transport.Open;
    {=========================================================}
    WriteLn('-----ECHO PING-----');
    try
      client.ping;
      WriteLn('Call ping()..OK');
    except
      on e: Sysutils.Exception   do   WriteLn('....Error:'+e.Message);
    end;
    {=========================================================}
    WriteLn('-----ECHO SIMPLE TYPE-----');
    try
      WriteLn('Call echoByte(120)');
      sum := client.echoByte(120);
      Writeln( Format( 'Call echoByte(120)=%d', [sum]));
    except
      on e: Sysutils.Exception   do   WriteLn('....Error:'+e.Message);
    end;
    {=========================================================}
    try
      WriteLn('Call echoI32(12012055)');
      sum := client.echoI32(12012055);
      Writeln( Format( 'Call echoI32(12012055)=%d', [sum]));
    except
      on e: Sysutils.Exception   do   WriteLn('....Error:'+e.Message);
    end;
    {=========================================================}
    try
      WriteLn('Call echoI64(112112012055000)');
      sum := client.echoI64(112112012055000);
      Writeln( Format( 'Call echoI64(112112012055000)=%d', [sum]));
    except
      on e: Sysutils.Exception   do   WriteLn('....Error:'+e.Message);
    end;
    {=========================================================}
    try
      WriteLn('Call echoString(HELLO KYLE)');
      sr := client.echoString('HELLO KYLE');
      Writeln( Format( 'Call echoString(HELLO KYLE)=%s', [sr]));
    except
      on e: Sysutils.Exception   do   WriteLn('....Error:'+e.Message);
    end;
    {=========================================================}
    argstruct:=TXtructImpl.Create;
    argstruct.String_thing:='HELLO';
    argstruct.Byte_thing:=123;
    argstruct.I32_thing:=123456789;
    argstruct.I64_thing:=123456789123456789;
    try
      WriteLn('Call echoXStruct()');
      argstruct := client.echoXtruct(argstruct);
      WriteLn( '===CALL echoXtruct(...) result');
      WriteLn( '.String_thing:',argstruct.String_thing);
      WriteLn( '.Byte_thing:',argstruct.Byte_thing);
      WriteLn( '.I32_thing:',argstruct.I32_thing);
      WriteLn( '.I64_thing:',argstruct.I64_thing);
      WriteLn( '===CALL echoXtruct() End');
    except
      on e: Sysutils.Exception   do   WriteLn('....Error:'+e.Message);
    end;

    WriteLn('-----CALC STRUCT TYPE-----');
    try
      WriteLn('Call add(5,9)=14');
      sum := client.add( 5, 9);
      Writeln( Format( 'Call add(5,9)=%d', [sum]));
    except
      on e: Sysutils.Exception   do   WriteLn('....Error:'+e.Message);
    end;
    work := TWorkImpl.Create;    
    WriteLn('Testing Calc with struct');
    work.Op   := Sample2.SUBTRACT;
    work.Num1 := 15;
    work.Num2 := 10;
    try
      diff := client.calculate( 1, work);
      Writeln( Format('Calc(Iwork)=%d', [diff]));
    except
      on io: TInvalidOperation
      do Writeln( 'Invalid operation: ' + io.Why);
    end;

{
    work.Op   := Sample2.DIVIDE;
    work.Num1 := 1;
    work.Num2 := 0;
    WriteLn('Testing Exception');
    try
      Writeln( 'Call calculator method: 1/0: result is exception');
      quotient := client.calculate(1, work);
      Writeln( Format('1/0=%d',[quotient]));
    except
      on io: TInvalidOperation
      do Writeln( '....Invalid operation: ' + io.Why);
    end;
 }
    WriteLn('-----ECHO COMPLEX TYPE-----');
    argl:=TThriftListImpl.Create;
    argl.Add(1);
    argl.Add(5);
    argl.Add(9);
    sum:=argl.Count;
    try
      Writeln( 'Echo List:',sum);
      argl:=client.echoList(argl);
      sum:=argl.Count;
      Writeln( Format('->Count=%d',[sum]));
      for i:=0 to sum - 1 do
      begin
      Writeln(argl[i]);
      end;

    except
      on io: TInvalidOperation
      do Writeln( '....Invalid operation: ' + io.Why);
    end;
    {=========================================================}
    argl.Clear;
    argstruct:=TXtructImpl.Create;
    argstruct.String_thing:='HELLO';
    argstruct.Byte_thing:=123;
    argstruct.I32_thing:=123456789;
    argstruct.I64_thing:=123456789123456789;
    argl:=TThriftListImpl.Create;
    argl.Add(argstruct);
    argl.Add(argstruct);
    argl.Add(argstruct);
    sum:=argl.Count;
    try
      Writeln( 'Echo ListXStruct:',sum);
      argl:=client.echoListXtruct(argl);
      sum:=argl.Count;
      Writeln( Format('->Count=%d',[sum]));
      for i:=0 to sum - 1 do
      begin
        argstruct:=IXtruct(argl.Items[i].AsIntf);
        WriteLn( '.String_thing:',argstruct.String_thing);
        WriteLn( '.Byte_thing:',argstruct.Byte_thing);
        WriteLn( '.I32_thing:',argstruct.I32_thing);
        WriteLn( '.I64_thing:',argstruct.I64_thing);
      end;

    except
      on io: TInvalidOperation
      do Writeln( '....Invalid operation: ' + io.Why);
    end;

    {=========================================================}
    argm:=TThriftDictionaryImpl.Create;
    argm.Add(1,2);
    argm.Add(2,3);
    argm.Add(3,4);
    sum:=argm.Count;
    try
      Writeln( 'Echo Map:',sum);
      argm:=client.echoMap(argm);
      sum:=argm.Count;
      Writeln( Format('->Count=%d',[sum]));
      for i:=0 to sum - 1 do
      begin
        writeln('(',argm.Keys[i].Value,',',argm.Values[i].Value,')');
      end;

    except
      on io: TInvalidOperation
      do Writeln( '....Invalid operation: ' + io.Why);
    end;
    {=========================================================}    
    argm.Clear;
    {argstruct:=TXtructImpl.Create;
    argstruct.String_thing:='HELLO';
    argstruct.Byte_thing:=123;
    argstruct.I32_thing:=123456789;
    argstruct.I64_thing:=123456789123456789;}
    argm:=TThriftDictionaryImpl.Create;
    argm.Add(1,argstruct);
    argm.Add(2,argstruct);
    argm.Add(3,argstruct);
    argstruct:=IXtruct(argm.Values[0].AsIntf);
    WriteLn( '.String_thing:',argstruct.String_thing);
    WriteLn( '.Byte_thing:',argstruct.Byte_thing);
    WriteLn( '.I32_thing:',argstruct.I32_thing);
    WriteLn( '.I64_thing:',argstruct.I64_thing);

    sum:=argm.Count;
    try
      Writeln( 'Echo MapXtruct:',sum);
      argm:=client.echoMapXtruct(argm);
      sum:=argm.Count;
      Writeln( Format('->Count=%d',[sum]));
      for i:=0 to sum - 1 do
      begin
        writeln('=>(Key=',argm.Keys[i].Value,')');
        argstruct:=IXtruct(argm.Values[i].AsIntf);
        WriteLn( '.String_thing:',argstruct.String_thing);
        WriteLn( '.Byte_thing:',argstruct.Byte_thing);
        WriteLn( '.I32_thing:',argstruct.I32_thing);
        WriteLn( '.I64_thing:',argstruct.I64_thing);
      end;

    except
      on io: TInvalidOperation
      do Writeln( '....Invalid operation: ' + io.Why);
    end;

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
    TSample2Client.Main;
    Readln;

  except
    on E:Sysutils.Exception do
      Writeln(E.Classname, ': ', E.Message);
  end;
end.
