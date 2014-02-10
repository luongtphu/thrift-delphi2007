program Test_ThriftLib;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  TypInfo,
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
    processMap_: IThriftDictionary_V_V;
    constructor Create;
    destructor Destroy;
    procedure Me1();
    procedure Me2();
  end;
var

Value: TValueVariant;
{ TTest }

constructor TTest.Create;
var
Value:TValueVariant;
p1,p2:Pointer;
pp1,pp2:TMe;
begin

  pp1:=Self.Me1;
  pp2:=Self.Me2;
  p2:=@Self;
  p1:=@pp1;
//  p2:=@pp2;
  processMap_ := TThriftDictionary_V_VImpl.Create;
  processMap_.AddOrSetValue( 'Me1',TValueVariant.Create(Pointer(p1)));
  processMap_.AddOrSetValue( 'Me2',TValueVariant.Create(Pointer(p2)));

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
    PCardinal(@pp):=Value.GetValueP;
    pp();
    Writeln('Value....',Cardinal(Value.GetValueP));
  end;

end;

var
t:TTest;
begin
  t:=TTest.Create;
  t.Process;

  Writeln('Test Lib....');
  Readln;
end.
