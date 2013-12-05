unit uTypes;

interface
uses sysutils,VarUtils,variants,Classes;

type
  TAllVarType=(avt_empty,avt_variants,avt_pointer,avt_object,avt_interface);
type
  TRAllVar = packed record
      v_var:Variant;
      v_obj:TObject;
      v_intf:IInterface;
      v_pointer:Pointer;
   end;


type
  TAllVar=class(TObject)
  private
  ftype:TAllVarType;
  fvar:TRAllVar;
  fprefree:boolean;
  public
  constructor Create;overload;
  constructor Create(V:Variant);overload;
  constructor Create(V:IInterface);overload;
  constructor Create(V:TObject;const prefree:boolean=false);overload;
  constructor Create(V:Pointer);overload;
  procedure Free;
  destructor Destroy;

  procedure SetValue(V:Variant);overload;
  procedure SetValue(V:IInterface);overload;
  procedure SetValue(V:TObject;const prefree:boolean=false);overload;
  procedure SetValue(V:Pointer);overload;
  function IsEmpty:Boolean;
  function AsString:string;
  function AsFloat:Double;
  function AsInt:Integer;
  function AsObj:TObject;
  function AsIntf:IInterface;
  function AsPointer:Pointer;

  function GetValueV:Variant;
  function GetValueI:IInterface;
  function GetValueO:TObject;
  function GetValueP:Pointer;
  property GetType:TAllVarType read ftype;
  end;
type
  IntPtr  = NativeInt;
  TValueObject=TObject;
  TKeyVariant=Variant;
  TValueVariant=TAllVar;

type
  TCharArray = array of char;
  TIntArray = array of Integer;
  TUintArray = array of Cardinal;
  TStringArray = array of string;
  TObjectArray = array of TObject;
  TVariantArray = array of Variant;
  TKeyVariantArray = array of TKeyVariant;
  TValueVariantArray = array of TValueVariant;
  TValueObjectArray = array of TValueObject;


type
  TPair_V_V = class
    Key: TKeyVariant;
    Value: TValueVariant;
    constructor Create(const AKey: TKeyVariant; const AValue: TValueVariant);
  end;


  TPair_V_VArray = array of TPair_V_V;

function Variant_Compare_Default(const Left,
  Right: Variant): Integer;
function AllValue_Compare_Default(const Left,
  Right: TValueVariant): Integer;
function AllValue_Compare_Default_Obj(const Left,
  Right: TValueVariant): Integer;
function AllValue_Compare_Default_Intf(const Left,
  Right: TValueVariant): Integer;
function AllValue_Compare_Default_Ptr(const Left,
  Right: TValueVariant): Integer;
implementation

{ TPair_V_V }

constructor TPair_V_V.Create(const AKey: TKeyVariant; const AValue: TValueVariant);
begin
  Key := AKey;
  Value := AValue;
end;

{ TAllVar }

constructor TAllVar.Create(V: Variant);
begin
  fprefree:=false;
  SetValue(v);
end;

constructor TAllVar.Create;
begin
  fprefree:=false;
  ftype:=avt_empty;
end;

constructor TAllVar.Create(V: IInterface);
begin
  fprefree:=false;
  SetValue(v);
end;

constructor TAllVar.Create(V: Pointer);
begin
  SetValue(v);
end;

destructor TAllVar.Destroy;
begin
  Free;
  inherited;
end;

constructor TAllVar.Create(V: TObject;const prefree:boolean);
begin
  fprefree:=false;
  SetValue(v,prefree);
end;

procedure TAllVar.Free;
begin
  if (ftype=avt_empty) then exit;
  if (ftype=avt_object) and (not fprefree) then
  begin
    if assigned(fvar.v_obj) then
      FreeAndNil(fvar.v_obj);
  end;

end;

function TAllVar.AsString: String;
begin
  if (ftype=avt_variants) then
    Result:= fvar.v_var;
end;
function TAllVar.AsInt: Integer;
begin
  if (ftype=avt_variants) then
    Result:=fvar.v_var;
end;

function TAllVar.AsIntf: IInterface;
begin
  Result:=GetValueI;
end;

function TAllVar.AsObj: TObject;
begin
  Result:=GetValueO;
end;

function TAllVar.AsPointer: Pointer;
begin
  result:=GetValueP;

end;

function TAllVar.AsFloat: Double;
begin
  if (ftype=avt_variants) then
    Result:=fvar.v_var;
end;

function TAllVar.GetValueV: Variant;
begin
  if (ftype=avt_variants) then
    Result:=fvar.v_var;
end;

function TAllVar.GetValueI: IInterface;
begin
  if (ftype=avt_interface) then
    Result:=fvar.v_intf;
end;

function TAllVar.GetValueP: Pointer;
begin
  if (ftype=avt_pointer) then
    Result:=fvar.v_pointer;

end;

function TAllVar.GetValueO: TObject;
begin
  if (ftype=avt_object) then
    Result:=fvar.v_obj;
end;

function TAllVar.IsEmpty: Boolean;
begin
  result:=(ftype=avt_empty);
end;

procedure TAllVar.SetValue(V: Variant);
begin
  ftype:=avt_variants;
  fvar.v_var:=V;
end;

procedure TAllVar.SetValue(V: Pointer);
begin
  ftype:=avt_pointer;
  fvar.v_pointer:=V;
end;

procedure TAllVar.SetValue(V: TObject;const prefree:boolean);
begin
  ftype:=avt_object;
  fvar.v_obj:=V;
  fprefree:=prefree;
end;

procedure TAllVar.SetValue(V: IInterface);
begin
  ftype:=avt_interface;
  fvar.v_intf:=V;
end;


//Function utils
function Variant_Compare_Default(const Left,
  Right: Variant): Integer;
var
vt:TVarType;
s1,s2:string;
begin
  result:=-1;
  if (VarIsEmpty(Left)) then
    exit;
  result:=1;
  if (VarIsEmpty(Right)) then
    exit;
  result:=0;
  vt:=VarType(Right);
  if (VarType(Left)=vt) then
  begin
    if (vt=varString) then
    begin
      s1:=VarToStr(Left);
      s2:=VarToStr(Right);
      result:=StrComp(pchar(s1),pchar(s2));
    end
    else
    begin
      if (Left=Right) then exit;
      if (Left<Right) then result:=-1
      else result:=1;
    end;
  end;
end;

function AllValue_Compare_Default(const Left,
  Right: TValueVariant): Integer;
begin
  result:=0;
  if (Left.GetType<>avt_variants) or (Right.GetType<>avt_variants) then exit;
  result:=-1;
  if (VarIsEmpty(Left.GetValueV)) then
    exit;
  result:=1;
  if (VarIsEmpty(Right.GetValueV)) then
    exit;
  result:=Variant_Compare_Default(Left.GetValueV,Right.GetValueV);
end;

function AllValue_Compare_Default_Obj(const Left,
  Right: TValueVariant): Integer;
var
p1,p2:UInt64;
begin
  result:=0;
  if (Left.GetType<>avt_object) or (Right.GetType<>avt_object) then exit;
  p1:=UInt64(Pointer(Left.GetValueO));
  p2:=UInt64(Pointer(Right.GetValueO));
  result:=0;
  if (p1<p2) then  result:=-1
  else if (p1>p2) then  result:=1
end;

function AllValue_Compare_Default_Intf(const Left,
  Right: TValueVariant): Integer;
var
p1,p2:UInt64;
begin
  result:=0;
  if (Left.GetType<>avt_object) or (Right.GetType<>avt_object) then exit;
  p1:=UInt64(Pointer(Left.GetValueI));
  p2:=UInt64(Pointer(Right.GetValueI));
  result:=0;
  if (p1<p2) then  result:=-1
  else if (p1>p2) then  result:=1
end;
function AllValue_Compare_Default_Ptr(const Left,
  Right: TValueVariant): Integer;
var
p1,p2:UInt64;
begin
  result:=0;
  if (Left.GetType<>avt_object) or (Right.GetType<>avt_object) then exit;
  p1:=UInt64(Pointer(Left.GetValueP));
  p2:=UInt64(Pointer(Right.GetValueP));
  result:=0;
  if (p1<p2) then  result:=-1
  else if (p1>p2) then  result:=1
end;
end.
