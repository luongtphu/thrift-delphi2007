program Test_ThriftLib;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  TypInfo,
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
  uSysUtils in 'uSysUtils.pas',
  Thrift.Protocol.JSON in 'Thrift.Protocol.JSON.pas';

type
  TTest=class(Tobject)
  public
  type
    TMe=procedure of Object;
  private
    fdic:integer;
    procedure Hello();
  protected
    procedure Process();

  public
    processMap_: IThriftDictionary;
    constructor Create;
    destructor Destroy;
    procedure Me1();
    procedure Me2();
  end;
var

Value: TAllValue;
{ TTest }

constructor TTest.Create;
var
Value:TAllValue;
p1,p2:Pointer;
pp1,pp2:TMe;
begin

  pp1:=Self.Me1;
  pp2:=Self.Me2;
  p2:=@Self;
  p1:=@pp1;
//  p2:=@pp2;
  processMap_ := TThriftDictionaryImpl.Create;
  processMap_.AddOrSetValue( 'Me1',TAllValue.Create(Pointer(p1)));
  processMap_.AddOrSetValue( 'Me2',TAllValue.Create(Pointer(p2)));

end;

destructor TTest.Destroy;
begin

end;

procedure TTest.Hello;
begin
    fdic:=1;
    Writeln('Hello');
end;

procedure TTest.Me1;
begin
  Hello;
    Writeln('Call Me1');
end;

procedure TTest.Me2;
begin
  Hello;
  Writeln('Call Me2',fdic);
end;

procedure TTest.Process;
var
pp:TMe;
begin
  if processMap_.TryGetValue('Me2',Value) then
  begin
    PCardinal(@pp):=Value.ValuePtr;
    pp();
    Writeln('Value....',Cardinal(Value.ValuePtr));
  end;

end;

var
t:TTest;
argm:IThriftDictionary;
v,i,n:integer;
va:TAllValue;
begin
    argm:=TThriftDictionaryImpl.Create;
    argm.Add(5,2);
    argm.Add(2,3);
    argm.Add(3,4);
    n:=argm.Count;
    v:=argm[5];
    writeln(v);
    for i:=0 to n - 1 do
    begin
        writeln('(',argm.Keys[i].Value,',',argm.Values[i].Value,')');
    end;


  Readln;
end.
