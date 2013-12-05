unit uCollections;

interface
uses sysutils,uTypes,variants,classes;

type
  TKeyComparisonProc = function(const Left, Right: TKeyVariant): Integer;
  TValueComparisonProc = function(const Left, Right: TValueVariant): Integer;

  IuComparerKey_V = interface
    function Compare(const Left, Right: TKeyVariant): Integer;
  end;
  IuComparerValue_V = interface
    function Compare(const Left, Right: TValueVariant): Integer;
  end;


  TuComparerKey_VDefault = class(TInterfacedObject, IuComparerKey_V)
  public
    function Compare(const Left, Right: TKeyVariant): Integer;
  end;

  TuComparerValue_VDefault = class(TInterfacedObject, IuComparerValue_V)
  public
    function Compare(const Left, Right: TValueVariant): Integer;
  end;

  TuComparerValue_ObjDefault = class(TInterfacedObject, IuComparerValue_V)
  public
    function Compare(const Left, Right: TValueVariant): Integer;
  end;

  TuComparerValue_IntfDefault = class(TInterfacedObject, IuComparerValue_V)
  public
    function Compare(const Left, Right: TValueVariant): Integer;
  end;

  TuComparerValue_PtrDefault = class(TInterfacedObject, IuComparerValue_V)
  public
    function Compare(const Left, Right: TValueVariant): Integer;
  end;


  IuEqualityComparerKey_V = interface
    function Equals(const Left, Right: TKeyVariant): Boolean;
  end;

  IuEqualityComparerValue_V = interface
    function Equals(const Left, Right: TValueVariant): Boolean;
  end;


  TIuEqualityComparerKey_VDefault = class(TInterfacedObject, IuEqualityComparerKey_V)
  public
      function Equals(const Left, Right: TKeyVariant): Boolean;
  end;
  TIuEqualityComparerValue_VDefault = class(TInterfacedObject, IuEqualityComparerValue_V)
  public
      function Equals(const Left, Right: TValueVariant): Boolean;
  end;


  TuComparerKey_V = class
  public
    class function Default: IuComparerKey_V;
    class function DefaultEqual: IuEqualityComparerKey_V;
  end;

  TuComparerValue_V = class
  public
    class function Default: IuComparerValue_V;
    class function DefaultEqual: IuEqualityComparerValue_V;
    class function DefaultObj: IuComparerValue_V;
    class function DefaultInf: IuComparerValue_V;
    class function DefaultPtr: IuComparerValue_V;
  end;


type
  TuCollectionNotification = (cnAdded, cnRemoved, cnExtracted);
  TuCollectionNotifyEvent = procedure(Sender: TObject; const Item: TValueVariant;
    Action: TCollectionNotification) of object;

type
  TuDictionary_V_V=class(TObject)
  private
     fKey:TKeyVariantArray;
     fValue:TValueVariantArray;

    FCount: Integer;
    FComparer: IuEqualityComparerKey_V;
    FGrowThreshold: Integer;
    procedure Grow;
    procedure Rehash(NewCapPow2: Integer);
    procedure SetCapacity(ACapacity: Integer);
    function GetCapacity: Integer;
    function GetBucketIndex(const Key: TKeyVariant): Integer;
    function GetItem(const Key: TKeyVariant): Variant;
    procedure SetItem(const Key: TKeyVariant; const Value: Variant);
    function GetItemV(const Key: TKeyVariant): TValueVariant;
    procedure SetItemV(const Key: TKeyVariant; const Value: TValueVariant);
    procedure DoAdd(Index: Integer; const Key: TKeyVariant; const Value: TValueVariant);
    procedure DoSetValue(Index: Integer; const Value: TValueVariant);
    function DoRemove(const Key: TKeyVariant; Notification: TuCollectionNotification): TValueVariant;
  public
    constructor Create(ACapacity: Integer = 0); overload;
    constructor Create(const AComparer: IuEqualityComparerKey_V); overload;
    constructor Create(ACapacity: Integer; const AComparer: IuEqualityComparerKey_V); overload;
    destructor Destroy; override;
    procedure Clear;
    procedure TrimExcess;

    function ContainsKey(const Key: TKeyVariant): Boolean;
    procedure Add(const Key: TKeyVariant; const Value: TValueVariant);overload;
    procedure AddOrSetValue(const Key: TKeyVariant; const Value: TValueVariant);overload;
    procedure Remove(const Key: TKeyVariant);
    function ExtractPair(const Key: TKeyVariant): TPair_V_V;
    function GetPair(const index: Cardinal): TPair_V_V;
    procedure Add(const Key: TKeyVariant;const value:Variant);overload;
    procedure Add(const Key: TKeyVariant;const value:TObject);overload;
    procedure Add(const Key: TKeyVariant;const value:IInterface);overload;
    procedure Add(const Key: TKeyVariant;const value:Pointer);overload;

    procedure AddOrSetValue(const Key: TKeyVariant;const value:Variant);overload;
    procedure AddOrSetValue(const Key: TKeyVariant;const value:TObject);overload;
    procedure AddOrSetValue(const Key: TKeyVariant;const value:IInterface);overload;
    procedure AddOrSetValue(const Key: TKeyVariant;const value:Pointer);overload;

    function AsString(const Key: TKeyVariant):string;
    function AsFloat(const Key: TKeyVariant):Double;
    function AsInt(const Key: TKeyVariant):Integer;
    function AsObj(const Key: TKeyVariant):TObject;
    function AsIntf(const Key: TKeyVariant):IInterface;
    function AsPointer(const Key: TKeyVariant):Pointer;
    function TryGetValue(const Key: TKeyVariant; out Value: TValueVariant): Boolean;
    function TryGetValueObj(const Key: TKeyVariant; out Value:TObject ):Boolean;
    function TryGetValueIntf(const Key: TKeyVariant; out Value:IInterface):Boolean;
    function TryGetValueString(const Key: TKeyVariant; out Value:string ):Boolean;
    function TryGetValuePointer(const Key: TKeyVariant; out Value:Pointer ):Boolean;
  public
    property Count: Integer read FCount;
    property Items[const Key: TKeyVariant]: TValueVariant read GetItemV write SetItemV;
    property Value[const Key: TKeyVariant]: Variant read GetItem write SetItem;default;
    property Keys:TKeyVariantArray read fkey;
    property Values:TValueVariantArray read fValue;
    property Capacity: Integer read GetCapacity;
  end;

type
  TuList_V=class(TObject)
  private
    fValue:TValueVariantArray;
    FCount: Integer;
    FGrowThreshold: Integer;
    fkey: TKeyVariantArray;
    procedure Grow;
    procedure Rehash(NewCapPow2: Integer);
    function GetCapacity: Integer;
    procedure SetCapacity(ACapacity: Integer);
    procedure SetCount(Value: Integer);
    function GetItem(const Key: Integer): Variant;
    procedure SetItem(const Key: Integer; const Value: Variant);
    function GetItemV(const Key: Integer): TValueVariant;
    procedure SetItemV(const Key: Integer; const Value: TValueVariant);
    procedure DoAdd(Index: Integer; const Value: TValueVariant);
    procedure DoSetValue(Index: Integer; const Value: TValueVariant);
    function DoRemove(const Key: integer; Notification: TuCollectionNotification): TValueVariant;
  public
    constructor Create(ACapacity: Integer = 0);
    destructor Destroy; override;
    procedure Clear;
    procedure TrimExcess;
    function IndexOf(Value: TValueVariant;const LastIndex:boolean=false): integer;overload;
    function IndexOf(const Value: Variant;const LastIndex:boolean=false): integer;overload;
    function IndexOf(const Value: TObject;const LastIndex:boolean=false): integer;overload;
    function IndexOf(const Value: Pointer;const LastIndex:boolean=false): integer;overload;
    function IndexOf(const Value: IInterface;const LastIndex:boolean=false): integer;overload;

    function LastIndexOf(Value: TValueVariant): integer;overload;
    function LastIndexOf(const Value: Variant): integer;overload;
    function LastIndexOf(const Value: TObject): integer;overload;
    function LastIndexOf(const Value: Pointer): integer;overload;
    function LastIndexOf(const Value: IInterface): integer;overload;

    function Contains(Value: TValueVariant): boolean;overload;
    function Contains(const Value: Variant): boolean;overload;
    function Contains(const Value: TObject): boolean;overload;
    function Contains(const Value: Pointer): boolean;overload;
    function Contains(const Value: IInterface): boolean;overload;

    procedure Exchange(Index1, Index2: Integer);
    //procedure Move(CurIndex, NewIndex: Integer);
    function First: TValueVariant;
    function Last: TValueVariant;
    procedure Reverse;
    procedure Sort; overload;
    procedure Sort(const AComparer: IuComparerValue_V); overload;
    function BinarySearch(const Item: Variant; out Index: Integer): Boolean; overload;
    function BinarySearch(const Item: TObject; out Index: Integer): Boolean; overload;
    function BinarySearch(const Item: IInterface; out Index: Integer): Boolean; overload;
    function BinarySearch(const Item: Pointer; out Index: Integer): Boolean; overload;
    function BinarySearch(const Item: TValueVariant; out Index: Integer; const AComparer: IuComparerValue_V): Boolean; overload;

    procedure Remove(const value:TValueVariant;const LastIndex:boolean=false);overload;
    procedure Remove(const Value: Variant;const LastIndex:boolean=false);overload;
    procedure Remove(const Value: TObject;const LastIndex:boolean=false);overload;
    procedure Remove(const Value: Pointer;const LastIndex:boolean=false);overload;
    procedure Remove(const Value: IInterface;const LastIndex:boolean=false);overload;

    procedure Delete(Index: Integer);
    procedure DeleteRange(AIndex, ACount: Integer);
    procedure Add(const Value: TValueVariant);overload;
    procedure Add(const value:Variant);overload;
    procedure Add(const value:TObject);overload;
    procedure Add(const value:IInterface);overload;
    procedure Add(const value:Pointer);overload;

    procedure AddOrSetValue(const Key: Integer; const Value: TValueVariant);overload;
    procedure AddOrSetValue(const Key: Integer;const value:Variant);overload;
    procedure AddOrSetValue(const Key: Integer;const value:TObject);overload;
    procedure AddOrSetValue(const Key: Integer;const value:IInterface);overload;
    procedure AddOrSetValue(const Key: Integer;const value:Pointer);overload;

    function AsString(const Key: Integer):string;
    function AsFloat(const Key: Integer):Double;
    function AsInt(const Key: Integer):Integer;
    function AsObj(const Key: Integer):TObject;
    function AsIntf(const Key: Integer):IInterface;
    function AsPointer(const Key: Integer):Pointer;
  public
    property Count: Integer read FCount;
    property Items[const Key: integer]: TValueVariant read GetItemV write SetItemV;
    property Value[const Key: integer]: Variant read GetItem write SetItem;default;
    property Values:TValueVariantArray read fValue;
    property Capacity: Integer read GetCapacity;
  end;

type
  IThriftContainer = interface
    ['{40AAF2AA-737F-45C5-B1E0-FCCC99C215D8}']
    function ToString: string;
  end;


type
  IThriftDictionary_V_V = interface(IThriftContainer)
    ['{95704BB4-5A0E-41CB-AB2F-43B4522A1168}']
    //function GetEnumerator: TPair_V_VArray;

    function GetKeys: TKeyVariantArray;
    function GetValues: TValueVariantArray;
    function GetItem(const Key: TKeyVariant): Variant;
    procedure SetItem(const Key: TKeyVariant; const Value: Variant);
    function GetItemV(const Key: TKeyVariant): TValueVariant;
    procedure SetItemV(const Key: TKeyVariant; const Value: TValueVariant);

    function GetCount: Integer;

    procedure Add(const Key: TKeyVariant; const Value: TValueVariant);overload;
    procedure Remove(const Key: TKeyVariant);
    function ExtractPair(const Key: TKeyVariant): TPair_V_V;
    function GetPair(const index: Cardinal): TPair_V_V;
    procedure Clear;
    procedure TrimExcess;
    function TryGetValue(const Key: TKeyVariant; out Value: TValueVariant): Boolean;
    procedure AddOrSetValue(const Key: TKeyVariant; const Value: TValueVariant);overload;
    function ContainsKey(const Key: TKeyVariant): Boolean;
    function ContainsValue(const Value: TValueVariant): Boolean;
    function ToArray: TPair_V_VArray;
    procedure Add(const Key: TKeyVariant;const value:Variant);overload;
    procedure Add(const Key: TKeyVariant;const value:TObject);overload;
    procedure Add(const Key: TKeyVariant;const value:IInterface);overload;
    procedure Add(const Key: TKeyVariant;const value:Pointer);overload;

    procedure AddOrSetValue(const Key: TKeyVariant;const value:Variant);overload;
    procedure AddOrSetValue(const Key: TKeyVariant;const value:TObject);overload;
    procedure AddOrSetValue(const Key: TKeyVariant;const value:IInterface);overload;
    procedure AddOrSetValue(const Key: TKeyVariant;const value:Pointer);overload;

    function AsString(const Key: TKeyVariant):string;
    function AsFloat(const Key: TKeyVariant):Double;
    function AsInt(const Key: TKeyVariant):Integer;
    function AsObj(const Key: TKeyVariant):TObject;
    function AsIntf(const Key: TKeyVariant):IInterface;
    function AsPointer(const Key: TKeyVariant):Pointer;
    function TryGetValueObj(const Key: TKeyVariant; out Value:TObject ):Boolean;
    function TryGetValueIntf(const Key: TKeyVariant; out Value:IInterface):Boolean;
    function TryGetValueString(const Key: TKeyVariant; out Value:string ):Boolean;
    function TryGetValuePointer(const Key: TKeyVariant; out Value:Pointer ):Boolean;

    property Items[const Key: TKeyVariant]: TValueVariant read GetItemV write SetItemV;
    property Value[const Key: TKeyVariant]: Variant read GetItem write SetItem;default;
    property Count: Integer read GetCount;
    property Keys: TKeyVariantArray read GetKeys;
    property Values: TValueVariantArray read GetValues;
  end;

type
  TThriftDictionary_V_VImpl = class( TInterfacedObject, IThriftDictionary_V_V)
  private
    FDictionaly : TuDictionary_V_V;
  protected
    //function GetEnumerator: TPair_V_VArray;

    function GetKeys: TKeyVariantArray;
    function GetValues: TValueVariantArray;
    function GetItem(const Key: TKeyVariant): Variant;
    procedure SetItem(const Key: TKeyVariant; const Value: Variant);
    function GetItemV(const Key: TKeyVariant): TValueVariant;
    procedure SetItemV(const Key: TKeyVariant; const Value: TValueVariant);

    function GetCount: Integer;

    procedure Add(const Key: TKeyVariant; const Value: TValueVariant);overload;
    procedure Remove(const Key: TKeyVariant);
    function ExtractPair(const Key: TKeyVariant): TPair_V_V;
    function GetPair(const index: Cardinal): TPair_V_V;
    procedure Clear;
    procedure TrimExcess;
    function TryGetValue(const Key: TKeyVariant; out Value: TValueVariant): Boolean;
    procedure AddOrSetValue(const Key: TKeyVariant; const Value: TValueVariant);overload;
    function ContainsKey(const Key: TKeyVariant): Boolean;
    function ContainsValue(const Value: TValueVariant): Boolean;
    function ToArray: TPair_V_VArray;

    procedure Add(const Key: TKeyVariant;const value:Variant);overload;
    procedure Add(const Key: TKeyVariant;const value:TObject);overload;
    procedure Add(const Key: TKeyVariant;const value:IInterface);overload;
    procedure Add(const Key: TKeyVariant;const value:Pointer);overload;

    procedure AddOrSetValue(const Key: TKeyVariant;const value:Variant);overload;
    procedure AddOrSetValue(const Key: TKeyVariant;const value:TObject);overload;
    procedure AddOrSetValue(const Key: TKeyVariant;const value:IInterface);overload;
    procedure AddOrSetValue(const Key: TKeyVariant;const value:Pointer);overload;

    function AsString(const Key: TKeyVariant):string;
    function AsFloat(const Key: TKeyVariant):Double;
    function AsInt(const Key: TKeyVariant):Integer;
    function AsObj(const Key: TKeyVariant):TObject;
    function AsIntf(const Key: TKeyVariant):IInterface;
    function AsPointer(const Key: TKeyVariant):Pointer;
    function TryGetValueObj(const Key: TKeyVariant; out Value:TObject ):Boolean;
    function TryGetValueIntf(const Key: TKeyVariant; out Value:IInterface):Boolean;
    function TryGetValueString(const Key: TKeyVariant; out Value:string ):Boolean;
    function TryGetValuePointer(const Key: TKeyVariant; out Value:Pointer ):Boolean;


    property Items[const Key: TKeyVariant]: TValueVariant read GetItemV write SetItemV;
    property Value[const Key: TKeyVariant]: Variant read GetItem write SetItem;default;
    property Count: Integer read GetCount;
    property Keys: TKeyVariantArray read GetKeys;
    property Values: TValueVariantArray read GetValues;
    function ToString: string;
  public
    constructor Create(ACapacity: Integer = 0);
    destructor Destroy; override;
  end;
type
  IThriftList_V = interface(IThriftContainer)
    ['{29BEEE31-9CB4-401B-AA04-5148A75F473B}']
    //function GetEnumerator: TVariantArray;
    function GetCapacity: Integer;
    procedure SetCapacity(Value: Integer);
    function GetCount: Integer;
    procedure SetCount(Value: Integer);
    function GetItem(Index: Integer): TValueVariant;
    procedure SetItem(Index: Integer; const Value: TValueVariant);
    function Add(const Value: TValueVariant): Integer;
    procedure AddRange(const Values: array of TValueVariant); overload;
    procedure AddRange(const Collection: TVariantArray); overload;
    //procedure AddRange(Collection: TEnumerable<T>); overload;
    procedure Insert(Index: Integer; const Value: TValueVariant);
    procedure InsertRange(Index: Integer; const Values: array of TValueVariant); overload;
    procedure InsertRange(Index: Integer; const Collection: TVariantArray); overload;
    //procedure InsertRange(Index: Integer; const Collection: TEnumerable<T>); overload;
    function Remove(const Value: TValueVariant): Integer;
    procedure Delete(Index: Integer);
    procedure DeleteRange(AIndex, ACount: Integer);
    function Extract(const Value: TValueVariant): TValueVariant;
    procedure Exchange(Index1, Index2: Integer);
    procedure Move(CurIndex, NewIndex: Integer);
    function First: TValueVariant;
    function Last: TValueVariant;
    procedure Clear;
    function Contains(const Value: TValueVariant): Boolean;
    function IndexOf(const Value: TValueVariant): Integer;
    function LastIndexOf(const Value: TValueVariant): Integer;
    procedure Reverse;
    procedure Sort; overload;
    procedure Sort(const AComparer: IuComparerValue_V); overload;
    function BinarySearch(const Item: TValueVariant; out Index: Integer): Boolean; overload;
    function BinarySearch(const Item: TValueVariant; out Index: Integer; const AComparer: IuComparerValue_V): Boolean; overload;
    procedure TrimExcess;
    function ToArray: TVariantArray;
    property Capacity: Integer read GetCapacity write SetCapacity;
    property Count: Integer read GetCount write SetCount;
    property Items[Index: Integer]: TValueVariant read GetItem write SetItem; default;
  end;

  TThriftList_VImpl = class( TInterfacedObject, IThriftList_V)
    private
    FList : TuList_V;
    protected
    //function GetEnumerator: TVariantArray;
    function GetCapacity: Integer;
    procedure SetCapacity(Value: Integer);
    function GetCount: Integer;
    procedure SetCount(Value: Integer);
    function GetItem(Index: Integer): TValueVariant;
    procedure SetItem(Index: Integer; const Value: TValueVariant);
    function Add(const Value: TValueVariant): Integer;
    procedure AddRange(const Values: array of TValueVariant); overload;
    procedure AddRange(const Collection: TVariantArray); overload;
    //procedure AddRange(Collection: TEnumerable<T>); overload;
    procedure Insert(Index: Integer; const Value: TValueVariant);
    procedure InsertRange(Index: Integer; const Values: array of TValueVariant); overload;
    procedure InsertRange(Index: Integer; const Collection: TVariantArray); overload;
    //procedure InsertRange(Index: Integer; const Collection: TEnumerable<T>); overload;
    function Remove(const Value: TValueVariant): Integer;
    procedure Delete(Index: Integer);
    procedure DeleteRange(AIndex, ACount: Integer);
    function Extract(const Value: TValueVariant): TValueVariant;
    procedure Exchange(Index1, Index2: Integer);
    procedure Move(CurIndex, NewIndex: Integer);
    function First: TValueVariant;
    function Last: TValueVariant;
    procedure Clear;
    function Contains(const Value: TValueVariant): Boolean;
    function IndexOf(const Value: TValueVariant): Integer;
    function LastIndexOf(const Value: TValueVariant): Integer;
    procedure Reverse;
    procedure Sort; overload;
    procedure Sort(const AComparer: IuComparerValue_V); overload;
    function BinarySearch(const Item: TValueVariant; out Index: Integer): Boolean; overload;
    function BinarySearch(const Item: TValueVariant; out Index: Integer; const AComparer: IuComparerValue_V): Boolean; overload;
    procedure TrimExcess;
    function ToArray: TVariantArray;
    property Capacity: Integer read GetCapacity write SetCapacity;
    property Count: Integer read GetCount write SetCount;
    property Items[Index: Integer]: TValueVariant read GetItem write SetItem; default;
    function ToString: string;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  IHashSet_V = interface(IThriftContainer)
    ['{F5ECAFF0-179F-4312-8B67-044DD79DAD0F}']
    //function GetEnumerator: TVariantArray;
    function GetIsReadOnly: Boolean;
    function GetCount: Integer;
    property Count: Integer read GetCount;
    property IsReadOnly: Boolean read GetIsReadOnly;
    procedure Add( const item: TValueVariant);
    procedure Clear;
    function Contains( const item: TValueVariant): Boolean;
    procedure CopyTo(var A: TVariantArray; arrayIndex: Integer);
    function Remove( const item: TValueVariant ): Boolean;
  end;

  THashSet_VImpl = class( TInterfacedObject, IHashSet_V)
  private
    FDictionary : IThriftDictionary_V_V;
    FIsReadOnly: Boolean;
  protected
    //function GetEnumerator: TVariantArray;
    function GetIsReadOnly: Boolean;
    function GetCount: Integer;
    property Count: Integer read GetCount;
    property IsReadOnly: Boolean read GetIsReadOnly;
    procedure Add( const item: TValueVariant);
    procedure Clear;
    function Contains( const item: TValueVariant): Boolean;
    procedure CopyTo(var A: TVariantArray; arrayIndex: Integer);
    function Remove( const item: TValueVariant ): Boolean;
    function ToString: string;
  end;


procedure Array_AllValue_QuickSort(var Values: array of TValueVariant; const Comparer: IuComparerValue_V;L, R: Integer);overload;
procedure Array_AllValue_QuickSort(var Values: array of TValueVariant; L, R: Integer);overload;
procedure Array_AllValue_QuickSort(var Values: array of TValueVariant);overload;

procedure Array_AllValue_Sort(var Values: array of TValueVariant; const Comparer: IuComparerValue_V;index, Count: Integer);overload;
procedure Array_AllValue_Sort(var Values: array of TValueVariant; index, Count: Integer);overload;


function Array_AllValue_BinarySearch(const Values: array of TValueVariant; const Item: TValueVariant;
  out FoundIndex: Integer; const Comparer: IuComparerValue_V; Index,
  Count: Integer): Boolean;overload;
function Array_AllValue_BinarySearch(const Values: array of TValueVariant; const Item: TValueVariant;
  out FoundIndex: Integer; const Comparer: IuComparerValue_V): Boolean;overload;
function Array_AllValue_BinarySearch(const Values: array of TValueVariant; const Item: TValueVariant;
  out FoundIndex: Integer): Boolean;overload;
implementation

//{Functions Utils}
procedure Array_AllValue_QuickSort(var Values: array of TValueVariant; const Comparer: IuComparerValue_V;
  L, R: Integer);
var
  I, J: Integer;
  pivot, temp: TValueVariant;
begin
  if (Length(Values) = 0) or ((R - L) <= 0) then
    Exit;
  repeat
    I := L;
    J := R;
    pivot := Values[L + (R - L) shr 1];
    repeat
      while Comparer.Compare(Values[I], pivot) < 0 do
        Inc(I);
      while Comparer.Compare(Values[J], pivot) > 0 do
        Dec(J);
      if I <= J then
      begin
        if I <> J then
        begin
          temp := Values[I];
          Values[I] := Values[J];
          Values[J] := temp;
        end;
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then
      Array_AllValue_QuickSort(Values, Comparer, L, J);
    L := I;
  until I >= R;
end;

procedure Array_AllValue_QuickSort(var Values: array of TValueVariant; L, R: Integer);
begin
  Array_AllValue_QuickSort(Values,TuComparerValue_V.Default,L, R);
end;

procedure Array_AllValue_QuickSort(var Values: array of TValueVariant);
begin
  Array_AllValue_QuickSort(Values,TuComparerValue_V.Default,low(Values), High(Values));
end;

procedure Array_AllValue_Sort(var Values: array of TValueVariant; const Comparer: IuComparerValue_V;index, Count: Integer);
begin
  if (Index < Low(Values)) or ((Index > High(Values)) and (Count > 0))
    or (Index + Count - 1 > High(Values)) or (Count < 0)
    or (Index + Count < 0) then
    raise EOutOfMemory.Create('Out of Memory range');
  if Count <= 1 then
    Exit;
  Array_AllValue_QuickSort(Values,Comparer,Index, Index + Count - 1);
end;

procedure Array_AllValue_Sort(var Values: array of TValueVariant; index, Count: Integer);
begin
  Array_AllValue_Sort(Values,TuComparerValue_V.Default,index, Count);
end;



function Array_AllValue_BinarySearch(const Values: array of TValueVariant; const Item: TValueVariant;
  out FoundIndex: Integer; const Comparer: IuComparerValue_V; Index,
  Count: Integer): Boolean;
var
  L, H: Integer;
  mid, cmp: Integer;
begin
  if (Index < Low(Values)) or ((Index > High(Values)) and (Count > 0))
    or (Index + Count - 1 > High(Values)) or (Count < 0)
    or (Index + Count < 0) then
        raise EOutOfMemory.Create('Out of Memory range');
  if Count = 0 then
  begin
    FoundIndex := Index;
    result:=false;
    Exit;
  end;
  
  Result := False;
  L := Index;
  H := Index + Count - 1;
  while L <= H do
  begin
    mid := L + (H - L) shr 1;
    cmp := Comparer.Compare(Values[mid], Item);
    if cmp < 0 then
      L := mid + 1
    else
    begin
      H := mid - 1;
      if cmp = 0 then
        Result := True;
    end;
  end;
  FoundIndex := L;
end;

function Array_AllValue_BinarySearch(const Values: array of TValueVariant; const Item: TValueVariant;
  out FoundIndex: Integer; const Comparer: IuComparerValue_V): Boolean;
begin
  Result := Array_AllValue_BinarySearch(Values, Item, FoundIndex, Comparer,
    Low(Values), Length(Values));
end;

function Array_AllValue_BinarySearch(const Values: array of TValueVariant; const Item: TValueVariant;
  out FoundIndex: Integer): Boolean;
begin
  Result := Array_AllValue_BinarySearch(Values, Item, FoundIndex, TuComparerValue_V.Default,
    Low(Values), Length(Values));
end;


{ TThriftDictionary_V_VImpl }

procedure TThriftDictionary_V_VImpl.Add(const Key: TKeyVariant;
  const Value: TValueVariant);
begin
  FDictionaly.Add(Key,Value);
end;

procedure TThriftDictionary_V_VImpl.AddOrSetValue(const Key: TKeyVariant;
  const Value: TValueVariant);
begin
  FDictionaly.AddOrSetValue(key,value);
end;

procedure TThriftDictionary_V_VImpl.AddOrSetValue(const Key: TKeyVariant;
  const value: TObject);
begin
  FDictionaly.AddOrSetValue(Key,value);
end;

procedure TThriftDictionary_V_VImpl.AddOrSetValue(const Key: TKeyVariant;
  const value: IInterface);
begin
  FDictionaly.AddOrSetValue(Key,value);
end;

procedure TThriftDictionary_V_VImpl.AddOrSetValue(const Key: TKeyVariant;
  const value: Pointer);
begin
  FDictionaly.AddOrSetValue(Key,value);
end;

procedure TThriftDictionary_V_VImpl.AddOrSetValue(const Key: TKeyVariant;
  const value: Variant);
begin
  FDictionaly.AddOrSetValue(Key,value);
end;

procedure TThriftDictionary_V_VImpl.Clear;
begin
  FDictionaly.Clear;
end;

function TThriftDictionary_V_VImpl.ContainsKey(const Key: TKeyVariant): Boolean;
begin
  result:=FDictionaly.ContainsKey(Key);
end;

function TThriftDictionary_V_VImpl.ContainsValue(
  const Value: TValueVariant): Boolean;
begin

end;

constructor TThriftDictionary_V_VImpl.Create(ACapacity: Integer);
begin
  FDictionaly := TuDictionary_V_V.Create( ACapacity );
end;

destructor TThriftDictionary_V_VImpl.Destroy;
begin
  FDictionaly.Free;
  inherited;
end;

function TThriftDictionary_V_VImpl.ExtractPair(
  const Key: TKeyVariant): TPair_V_V;
begin
  FDictionaly.ExtractPair(Key);
end;

function TThriftDictionary_V_VImpl.GetCount: Integer;
begin
  result:=FDictionaly.Count;
end;


function TThriftDictionary_V_VImpl.GetItem(
  const Key: TKeyVariant): Variant;
begin
  result:=FDictionaly.GetItem(Key);
end;

function TThriftDictionary_V_VImpl.GetItemV(
  const Key: TKeyVariant): TValueVariant;
begin
  FDictionaly.GetItemV(Key);
end;

function TThriftDictionary_V_VImpl.GetKeys: TKeyVariantArray;
begin
  result:=FDictionaly.Keys;
end;

function TThriftDictionary_V_VImpl.GetPair(const index: Cardinal): TPair_V_V;
begin
  result:=FDictionaly.GetPair(index);
end;

function TThriftDictionary_V_VImpl.GetValues: TValueVariantArray;
begin
  result:=FDictionaly.Values;
end;

procedure TThriftDictionary_V_VImpl.Remove(const Key: TKeyVariant);
begin
  FDictionaly.Remove(Key);
end;

procedure TThriftDictionary_V_VImpl.SetItem(const Key: TKeyVariant;
  const Value: Variant);
begin
  FDictionaly.SetItem(Key,Value);
end;

procedure TThriftDictionary_V_VImpl.SetItemV(const Key: TKeyVariant;
  const Value: TValueVariant);
begin
  FDictionaly.SetItemV(Key,Value);
end;

function TThriftDictionary_V_VImpl.ToArray: TPair_V_VArray;
begin

end;

function TThriftDictionary_V_VImpl.ToString: string;
begin

end;

procedure TThriftDictionary_V_VImpl.TrimExcess;
begin
  FDictionaly.TrimExcess;
end;

function TThriftDictionary_V_VImpl.TryGetValue(const Key: TKeyVariant;
  out Value: TValueVariant): Boolean;
begin
  FDictionaly.TryGetValue(Key,value);
end;

procedure TThriftDictionary_V_VImpl.Add(const Key: TKeyVariant;
  const value: IInterface);
begin
  FDictionaly.Add(Key,value);
end;

procedure TThriftDictionary_V_VImpl.Add(const Key: TKeyVariant;
  const value: TObject);
begin
  FDictionaly.Add(Key,value);
end;

procedure TThriftDictionary_V_VImpl.Add(const Key: TKeyVariant;
  const value: Variant);
begin
  FDictionaly.Add(Key,value);
end;

procedure TThriftDictionary_V_VImpl.Add(const Key: TKeyVariant;
  const value: Pointer);
begin
  FDictionaly.Add(Key,value);
end;

function TThriftDictionary_V_VImpl.AsFloat(const Key: TKeyVariant): Double;
begin
  result:=FDictionaly.AsFloat(Key);
end;

function TThriftDictionary_V_VImpl.AsInt(const Key: TKeyVariant): Integer;
begin
  result:=FDictionaly.AsInt(Key);
end;

function TThriftDictionary_V_VImpl.AsIntf(const Key: TKeyVariant): IInterface;
begin
  result:=FDictionaly.AsIntf(Key);
end;

function TThriftDictionary_V_VImpl.AsObj(const Key: TKeyVariant): TObject;
begin
  result:=FDictionaly.AsObj(Key);
end;

function TThriftDictionary_V_VImpl.AsPointer(const Key: TKeyVariant): Pointer;
begin
  result:=FDictionaly.AsPointer(Key);
end;

function TThriftDictionary_V_VImpl.AsString(const Key: TKeyVariant): string;
begin
  result:=FDictionaly.AsString(Key);
end;

function TThriftDictionary_V_VImpl.TryGetValueIntf(const Key: TKeyVariant;
  out Value: IInterface): Boolean;
begin
  result:=FDictionaly.TryGetValueIntf(Key,value);
end;

function TThriftDictionary_V_VImpl.TryGetValueObj(const Key: TKeyVariant;
  out Value: TObject): Boolean;
begin
  result:=FDictionaly.TryGetValueObj(Key,value);
end;

function TThriftDictionary_V_VImpl.TryGetValuePointer(const Key: TKeyVariant;
  out Value: Pointer): Boolean;
begin
  result:=FDictionaly.TryGetValuePointer(Key,value);
end;

function TThriftDictionary_V_VImpl.TryGetValueString(const Key: TKeyVariant;
  out Value: string): Boolean;
begin
  result:=FDictionaly.TryGetValueString(Key,value);
end;

{ THashSet_VImpl }

procedure THashSet_VImpl.Add(const item: TValueVariant);
begin

end;

procedure THashSet_VImpl.Clear;
begin

end;

function THashSet_VImpl.Contains(const item: TValueVariant): Boolean;
begin

end;

procedure THashSet_VImpl.CopyTo(var A: TVariantArray; arrayIndex: Integer);
begin

end;

function THashSet_VImpl.GetCount: Integer;
begin

end;


function THashSet_VImpl.GetIsReadOnly: Boolean;
begin

end;

function THashSet_VImpl.Remove(const item: TValueVariant): Boolean;
begin

end;

function THashSet_VImpl.ToString: string;
begin

end;

{ TThriftList_VImpl }

function TThriftList_VImpl.Add(const Value: TValueVariant): Integer;
begin

end;

procedure TThriftList_VImpl.AddRange(const Collection: TVariantArray);
begin

end;

procedure TThriftList_VImpl.AddRange(const Values: array of TValueVariant);
begin

end;

function TThriftList_VImpl.BinarySearch(const Item: TValueVariant;
  out Index: Integer): Boolean;
begin

end;

function TThriftList_VImpl.BinarySearch(const Item: TValueVariant;
  out Index: Integer; const AComparer: IuComparerValue_V): Boolean;
begin

end;

procedure TThriftList_VImpl.Clear;
begin

end;

function TThriftList_VImpl.Contains(const Value: TValueVariant): Boolean;
begin

end;

constructor TThriftList_VImpl.Create;
begin

end;

procedure TThriftList_VImpl.Delete(Index: Integer);
begin

end;

procedure TThriftList_VImpl.DeleteRange(AIndex, ACount: Integer);
begin

end;

destructor TThriftList_VImpl.Destroy;
begin

  inherited;
end;

procedure TThriftList_VImpl.Exchange(Index1, Index2: Integer);
begin

end;

function TThriftList_VImpl.Extract(const Value: TValueVariant): TValueVariant;
begin

end;

function TThriftList_VImpl.First: TValueVariant;
begin

end;

function TThriftList_VImpl.GetCapacity: Integer;
begin
  result:=FList.GetCapacity;
end;

function TThriftList_VImpl.GetCount: Integer;
begin
  result:=FList.Count;
end;

function TThriftList_VImpl.GetItem(Index: Integer): TValueVariant;
begin

end;

function TThriftList_VImpl.IndexOf(const Value: TValueVariant): Integer;
begin

end;

procedure TThriftList_VImpl.Insert(Index: Integer; const Value: TValueVariant);
begin

end;

procedure TThriftList_VImpl.InsertRange(Index: Integer;
  const Values: array of TValueVariant);
begin

end;

procedure TThriftList_VImpl.InsertRange(Index: Integer;
  const Collection: TVariantArray);
begin

end;

function TThriftList_VImpl.Last: TValueVariant;
begin

end;

function TThriftList_VImpl.LastIndexOf(const Value: TValueVariant): Integer;
begin

end;

procedure TThriftList_VImpl.Move(CurIndex, NewIndex: Integer);
begin

end;

function TThriftList_VImpl.Remove(const Value: TValueVariant): Integer;
begin

end;

procedure TThriftList_VImpl.Reverse;
begin

end;

procedure TThriftList_VImpl.SetCapacity(Value: Integer);
begin
  FList.SetCapacity(Value);
end;

procedure TThriftList_VImpl.SetCount(Value: Integer);
begin

end;

procedure TThriftList_VImpl.SetItem(Index: Integer; const Value: TValueVariant);
begin

end;

procedure TThriftList_VImpl.Sort;
begin

end;

procedure TThriftList_VImpl.Sort(const AComparer: IuComparerValue_V);
begin

end;

function TThriftList_VImpl.ToArray: TVariantArray;
begin

end;

function TThriftList_VImpl.ToString: string;
begin

end;

procedure TThriftList_VImpl.TrimExcess;
begin

end;

{ TuDictionary_V_V }

constructor TuDictionary_V_V.Create(ACapacity: Integer);
begin
  Create(ACapacity, nil);
end;

constructor TuDictionary_V_V.Create(const AComparer: IuEqualityComparerKey_V);
begin
  Create(0, AComparer);
end;

procedure TuDictionary_V_V.Add(const Key: TKeyVariant;
  const Value: TValueVariant);
var
  index, hc: Integer;
begin
  if Count >= FGrowThreshold then
    Grow;
  index := GetBucketIndex(Key);
  if index >= 0 then
    raise EListError.Create('Error: Key repeat');
  DoAdd(Count, Key, Value);
end;

procedure TuDictionary_V_V.Add(const Key: TKeyVariant; const value: Variant);
begin
  add(key,TValueVariant.Create(value));
end;

procedure TuDictionary_V_V.Add(const Key: TKeyVariant; const value: TObject);
begin
  add(key,TValueVariant.Create(value));
end;

procedure TuDictionary_V_V.Add(const Key: TKeyVariant; const value: IInterface);
begin
  add(key,TValueVariant.Create(value));
end;

procedure TuDictionary_V_V.AddOrSetValue(const Key: TKeyVariant;
  const value: Variant);
begin
  AddOrSetValue(key,TValueVariant.Create(value));
end;

procedure TuDictionary_V_V.AddOrSetValue(const Key: TKeyVariant;
  const Value: TValueVariant);
var
  index, hc: Integer;
begin
  index := GetBucketIndex(Key);
  if index<0 then
  begin
    if Count >= FGrowThreshold then
        Grow;
    index:=Count;
  end;
  DoAdd(index, Key, Value);
end;

procedure TuDictionary_V_V.AddOrSetValue(const Key: TKeyVariant;
  const value: IInterface);
begin
  AddOrSetValue(key,TValueVariant.Create(value));
end;

procedure TuDictionary_V_V.AddOrSetValue(const Key: TKeyVariant;
  const value: TObject);
begin
  AddOrSetValue(key,TValueVariant.Create(value));
end;

function TuDictionary_V_V.AsFloat(const Key: TKeyVariant): Double;
var
it:TValueVariant;
begin
  it:=GetItemV(Key);
  if assigned(it) then
    result:=it.AsFloat;
end;

function TuDictionary_V_V.AsInt(const Key: TKeyVariant): Integer;
var
it:TValueVariant;
begin
  it:=GetItemV(Key);
  if assigned(it) then
    result:=it.AsInt;
end;

function TuDictionary_V_V.AsIntf(const Key: TKeyVariant): IInterface;
var
it:TValueVariant;
begin
  it:=GetItemV(Key);
  if assigned(it) then
    result:=it.AsIntf;
end;

function TuDictionary_V_V.AsObj(const Key: TKeyVariant): TObject;
var
it:TValueVariant;
begin
  result:=nil;
  it:=GetItemV(Key);
  if assigned(it) then
    result:=it.AsObj;
end;

function TuDictionary_V_V.AsPointer(const Key: TKeyVariant): Pointer;
var
it:TValueVariant;
begin
  result:=nil;
  it:=GetItemV(Key);
  if assigned(it) then
    result:=it.AsPointer;
end;

function TuDictionary_V_V.AsString(const Key: TKeyVariant): string;
var
it:TValueVariant;
begin
  result:='';
  it:=GetItemV(Key);
  if assigned(it) then
    result:=it.AsString;
end;

procedure TuDictionary_V_V.Clear;
var
  i: Integer;
  oldItemsk: TKeyVariantArray;
  oldItemsv: TValueVariantArray;
begin
  for i := 0 to Count - 1 do
  begin
    fValue[i].Free;
  end;
  oldItemsv := fValue;
  oldItemsk := fkey;
  FCount := 0;
  SetLength(fValue, 0);
  SetLength(fkey, 0);
  SetCapacity(0);
  FGrowThreshold := 0;

  for i := 0 to Count - 1 do
  begin
    //KeyNotify(oldItems[i].Key, cnRemoved);
    //ValueNotify(oldItems[i].Value, cnRemoved);
  end;
end;

function TuDictionary_V_V.ContainsKey(const Key: TKeyVariant): Boolean;
begin
  result:=(GetBucketIndex(Key)>=0);
end;

constructor TuDictionary_V_V.Create(ACapacity: Integer;
  const AComparer: IuEqualityComparerKey_V);
begin
  inherited Create;
  if ACapacity < 0 then
    raise Exception.Create('Error: ACapacity less Zero');
  FComparer := AComparer;
  if FComparer = nil then
    FComparer := TuComparerKey_V.DefaultEqual;
  SetCapacity(ACapacity);
end;

destructor TuDictionary_V_V.Destroy;
var
i:integer;
begin
  if Count<=0 then exit;
  Clear;
  inherited;
end;

procedure TuDictionary_V_V.DoAdd(Index: Integer; const Key: TKeyVariant;
  const Value: TValueVariant);
begin
  fKey[Index]:= Key;
  fValue[Index]:= Value;
  Inc(FCount);

  //KeyNotify(Key, cnAdded);
  //ValueNotify(Value, cnAdded);
end;

function TuDictionary_V_V.DoRemove(const Key: TKeyVariant;
  Notification: TuCollectionNotification): TValueVariant;
var
  gap, index: Integer;
begin
  Result :=nil;
  index := GetBucketIndex(Key);
  if index < 0 then  Exit;
  Result := fvalue[index];

  gap := index;
  while index<Count do
  begin
    Inc(index);
    fKey[gap]:=fKey[index];
    fvalue[gap]:=fvalue[index];
      gap := index;
  end;

  Dec(FCount);
  //KeyNotify(Key, Notification);
  //ValueNotify(Result, Notification);

end;

procedure TuDictionary_V_V.DoSetValue(Index: Integer;
  const Value: TValueVariant);
var
  oldValue: TValueVariant;
begin
  oldValue := Fvalue[Index];
  Fvalue[Index]:= Value;
  //ValueNotify(oldValue, cnRemoved);
  //ValueNotify(Value, cnAdded);
end;

function TuDictionary_V_V.ExtractPair(const Key: TKeyVariant): TPair_V_V;
var
  index: Integer;
begin
  result:=nil;
  index := GetBucketIndex(Key);
  if index >=0 then
  begin
    Result := TPair_V_V.Create(Key, DoRemove(Key, cnExtracted));
  end;

end;

function TuDictionary_V_V.GetBucketIndex(const Key: TKeyVariant): Integer;
var
i:integer;
begin
  result:=-1;
  if Count<=0 then exit;
  for i := 0 to Count - 1 do
  begin
    if FComparer.Equals(Key,fKey[i]) then
    begin
      result:=i;
      exit;
    end;
  end;

  
end;

function TuDictionary_V_V.GetCapacity: Integer;
begin
  Result := Length(fvalue);
end;

function TuDictionary_V_V.GetItemV(const Key: TKeyVariant): TValueVariant;
var
  index: Integer;
begin
  Result :=nil;
  index := GetBucketIndex(Key);
  if index < 0 then
    raise EListError.Create('Error: Not Found key');
  Result := FValue[index];
end;

function TuDictionary_V_V.GetPair(const index: Cardinal): TPair_V_V;
begin
  result:=nil;
  if (index >=0) and (Index<Count) then
  begin
    Result := TPair_V_V.Create(fKey[index], fvalue[index]);
  end;
end;

function TuDictionary_V_V.GetItem(const Key: TKeyVariant): Variant;
var
  i: Integer;
begin
  i := GetBucketIndex(Key);
  if i < 0 then
    raise EListError.Create('Error: Not Found key');
  Result := FValue[i].GetValueV;
end;

procedure TuDictionary_V_V.Grow;
var
  newCap: Integer;
begin
  newCap := Length(fKey) * 2;
  if newCap = 0 then
    newCap := 4;
  Rehash(newCap);
end;

procedure TuDictionary_V_V.Rehash(NewCapPow2: Integer);
var
  oldItems, newItems: TValueVariantArray;
  koldItems, knewItems: TKeyVariantArray;
  i: Integer;
begin
  if NewCapPow2 = Length(fKey) then
    Exit
  else if NewCapPow2 < 0 then
    OutOfMemoryError;

  oldItems := fValue;
  koldItems := fkey;
  SetLength(newItems, NewCapPow2);
  SetLength(knewItems, NewCapPow2);

  fKey := knewItems;
  fValue := newItems;
  FGrowThreshold := NewCapPow2 shr 1 + NewCapPow2 shr 2; // 75%

  for i := 0 to Length(oldItems) - 1 do
  begin
    fKey[i]:=koldItems[i];
    fValue[i]:=oldItems[i];
  end;
  SetLength(oldItems, 0);
  SetLength(koldItems, 0);
end;


procedure TuDictionary_V_V.Remove(const Key: TKeyVariant);
var
t:TValueVariant;
begin
  t:=DoRemove(Key, cnRemoved);
  if assigned(t) then
    t.Free;

end;

procedure TuDictionary_V_V.SetCapacity(ACapacity: Integer);
var
  newCap: Integer;
begin
  if ACapacity < Count then
    raise Exception.Create('Error ACapacity < Count');

  if ACapacity = 0 then
    Rehash(0)
  else
  begin
    newCap := 4;
    while newCap < ACapacity do
      newCap := newCap shl 1;
    Rehash(newCap);
  end
end;

procedure TuDictionary_V_V.SetItemV(const Key: TKeyVariant;
  const Value: TValueVariant);
var
index:integer;
begin
  index := GetBucketIndex(Key);
  if index < 0 then
  begin
    //raise EListError.Create('Error: Not Found key');
    Add(key,Value);
  end
  else
  begin
  FValue[index]:=Value;
  end;
end;

procedure TuDictionary_V_V.SetItem(const Key: TKeyVariant;
  const Value: Variant);
var
i:integer;
begin
  i := GetBucketIndex(Key);
  if i < 0 then
  begin
    //raise EListError.Create('Error: Not Found key');
    Add(Key,Value);
  end
  else
  begin
    FValue[i]:=TValueVariant.Create(Value);
  end;
end;

procedure TuDictionary_V_V.TrimExcess;
begin
  SetCapacity(Count + 1);
end;

function TuDictionary_V_V.TryGetValue(const Key: TKeyVariant;
  out Value: TValueVariant): Boolean;
var
  index: Integer;
begin
  index := GetBucketIndex(Key);
  Result := index >= 0;
  if Result then
    Value := Fvalue[index]
  else
    Value := nil;
end;

function TuDictionary_V_V.TryGetValueIntf(const Key: TKeyVariant;
  out Value: IInterface): Boolean;
var
t: TValueVariant;
begin
  Value:=nil;
  result:=TryGetValue(Key,t);
  if (result) then
  begin
    Value:=t.AsIntf;
  end;
end;

function TuDictionary_V_V.TryGetValueObj(const Key: TKeyVariant;
  out Value: TObject): Boolean;
var
t: TValueVariant;
begin
  Value:=nil;
  result:=TryGetValue(Key,t);
  if (result) then
  begin
    Value:=t.AsObj;
  end;
end;

function TuDictionary_V_V.TryGetValuePointer(const Key: TKeyVariant;
  out Value: Pointer): Boolean;
var
t: TValueVariant;
begin
  Value:=nil;
  result:=TryGetValue(Key,t);
  if (result) then
  begin
    Value:=t.AsPointer;
  end;
end;

function TuDictionary_V_V.TryGetValueString(const Key: TKeyVariant;
  out Value: string): Boolean;
var
t: TValueVariant;
begin
  Value:='';
  result:=TryGetValue(Key,t);
  if (result) then
  begin
    Value:=t.AsString;
  end;

end;

procedure TuDictionary_V_V.Add(const Key: TKeyVariant; const value: Pointer);
begin
  add(key,TValueVariant.Create(Pointer(value)));
end;

procedure TuDictionary_V_V.AddOrSetValue(const Key: TKeyVariant;
  const value: Pointer);
begin
  AddOrSetValue(key,TValueVariant.Create(value));
end;

{ TuComparerKey_V }

class function TuComparerKey_V.Default: IuComparerKey_V;
begin
  result:=IuComparerKey_V(TuComparerKey_VDefault.Create);
end;

{ YuComparerKey_VDefault }

function TuComparerKey_VDefault.Compare(const Left,
  Right: TKeyVariant): Integer;
begin
  result:=Variant_Compare_Default(Left,Right);
end;

class function TuComparerKey_V.DefaultEqual: IuEqualityComparerKey_V;
begin
  result:=IuEqualityComparerKey_V(TIuEqualityComparerKey_VDefault.Create);
end;

{ TIuEqualityComparerKey_VVDefault }

function TIuEqualityComparerKey_VDefault.Equals(const Left,
  Right: TKeyVariant): Boolean;
begin
  result:=(Variant_Compare_Default(Left,Right)=0);
end;



{ TuComparerValue_VDefault }

function TuComparerValue_VDefault.Compare(const Left,
  Right: TValueVariant): Integer;
begin
  result:=AllValue_Compare_Default(Left,Right);
end;

{ TIuEqualityComparerValue_VDefault }

function TIuEqualityComparerValue_VDefault.Equals(const Left,
  Right: TValueVariant): Boolean;
begin
  result:=AllValue_Compare_Default(Left,Right)=0;
end;

{ TuComparerValue_V }

class function TuComparerValue_V.Default: IuComparerValue_V;
begin
  result:=IuComparerValue_V(TuComparerValue_VDefault.Create);
end;

class function TuComparerValue_V.DefaultEqual: IuEqualityComparerValue_V;
begin
  result:=IuEqualityComparerValue_V(TIuEqualityComparerValue_VDefault.Create);
end;

class function TuComparerValue_V.DefaultInf: IuComparerValue_V;
begin
  result:=IuComparerValue_V(TuComparerValue_IntfDefault.Create);
end;

class function TuComparerValue_V.DefaultObj: IuComparerValue_V;
begin
  result:=IuComparerValue_V(TuComparerValue_ObjDefault.Create);
end;

class function TuComparerValue_V.DefaultPtr: IuComparerValue_V;
begin
  result:=IuComparerValue_V(TuComparerValue_PtrDefault.Create);
end;

{ TuComparerValue_PtrDefault }

function TuComparerValue_PtrDefault.Compare(const Left,
  Right: TValueVariant): Integer;
begin
  result:=AllValue_Compare_Default_Ptr(Left,Right);
end;

{ TuComparerValue_IntfDefault }

function TuComparerValue_IntfDefault.Compare(const Left,
  Right: TValueVariant): Integer;
begin
  result:=AllValue_Compare_Default_Intf(Left,Right);
end;

{ TuComparerValue_ObjDefault }

function TuComparerValue_ObjDefault.Compare(const Left,
  Right: TValueVariant): Integer;
begin
  result:=AllValue_Compare_Default_Obj(Left,Right);
end;

{ TuList_V }

procedure TuList_V.Add(const value: IInterface);
begin

end;

procedure TuList_V.Add(const value: Pointer);
begin

end;

procedure TuList_V.Add(const value: TObject);
begin

end;

procedure TuList_V.Add(const Value: TValueVariant);
begin

end;

procedure TuList_V.Add(const value: Variant);
begin

end;

procedure TuList_V.AddOrSetValue(const Key: Integer;
  const Value: TValueVariant);
begin

end;

procedure TuList_V.AddOrSetValue(const Key: Integer; const value: TObject);
begin

end;

procedure TuList_V.AddOrSetValue(const Key: Integer; const value: Variant);
begin

end;

procedure TuList_V.AddOrSetValue(const Key: Integer; const value: IInterface);
begin

end;

procedure TuList_V.AddOrSetValue(const Key: Integer; const value: Pointer);
begin

end;

function TuList_V.AsFloat(const Key: Integer): Double;
begin

end;

function TuList_V.AsInt(const Key: Integer): Integer;
begin

end;

function TuList_V.AsIntf(const Key: Integer): IInterface;
begin

end;

function TuList_V.AsObj(const Key: Integer): TObject;
begin

end;

function TuList_V.AsPointer(const Key: Integer): Pointer;
begin

end;

function TuList_V.AsString(const Key: Integer): string;
begin

end;

function TuList_V.BinarySearch(const Item: TValueVariant; out Index: Integer;
  const AComparer: IuComparerValue_V): Boolean;
begin

end;

function TuList_V.BinarySearch(const Item: TObject;
  out Index: Integer): Boolean;
begin

end;

function TuList_V.BinarySearch(const Item: Variant;
  out Index: Integer): Boolean;
begin

end;

function TuList_V.BinarySearch(const Item: Pointer;
  out Index: Integer): Boolean;
begin

end;

function TuList_V.BinarySearch(const Item: IInterface;
  out Index: Integer): Boolean;
begin

end;

procedure TuList_V.Clear;
begin

end;

function TuList_V.Contains(const Value: Pointer): boolean;
begin

end;

function TuList_V.Contains(const Value: IInterface): boolean;
begin

end;

function TuList_V.Contains(const Value: TObject): boolean;
begin

end;

function TuList_V.Contains(Value: TValueVariant): boolean;
begin

end;

function TuList_V.Contains(const Value: Variant): boolean;
begin

end;

constructor TuList_V.Create(ACapacity: Integer);
begin

end;

procedure TuList_V.Delete(Index: Integer);
begin

end;

procedure TuList_V.DeleteRange(AIndex, ACount: Integer);
begin

end;

destructor TuList_V.Destroy;
begin

  inherited;
end;

procedure TuList_V.DoAdd(Index: Integer; const Value: TValueVariant);
begin

end;

function TuList_V.DoRemove(const Key: integer;
  Notification: TuCollectionNotification): TValueVariant;
begin

end;

procedure TuList_V.DoSetValue(Index: Integer; const Value: TValueVariant);
begin

end;

procedure TuList_V.Exchange(Index1, Index2: Integer);
begin

end;

function TuList_V.First: TValueVariant;
begin

end;

function TuList_V.GetCapacity: Integer;
begin

end;

function TuList_V.GetItem(const Key: Integer): Variant;
begin

end;

function TuList_V.GetItemV(const Key: Integer): TValueVariant;
begin

end;

procedure TuList_V.Grow;
begin

end;

function TuList_V.IndexOf(const Value: Variant;
  const LastIndex: boolean): integer;
begin

end;

function TuList_V.IndexOf(Value: TValueVariant;
  const LastIndex: boolean): integer;
begin

end;

function TuList_V.IndexOf(const Value: IInterface;
  const LastIndex: boolean): integer;
begin

end;

function TuList_V.IndexOf(const Value: Pointer;
  const LastIndex: boolean): integer;
begin

end;

function TuList_V.IndexOf(const Value: TObject;
  const LastIndex: boolean): integer;
begin

end;

function TuList_V.Last: TValueVariant;
begin

end;

function TuList_V.LastIndexOf(const Value: TObject): integer;
begin

end;

function TuList_V.LastIndexOf(const Value: Variant): integer;
begin

end;

function TuList_V.LastIndexOf(const Value: Pointer): integer;
begin

end;

function TuList_V.LastIndexOf(const Value: IInterface): integer;
begin

end;

function TuList_V.LastIndexOf(Value: TValueVariant): integer;
begin

end;

procedure TuList_V.Rehash(NewCapPow2: Integer);
begin

end;

procedure TuList_V.Remove(const Value: TObject; const LastIndex: boolean);
begin

end;

procedure TuList_V.Remove(const Value: Variant; const LastIndex: boolean);
begin

end;

procedure TuList_V.Remove(const value: TValueVariant; const LastIndex: boolean);
begin

end;

procedure TuList_V.Remove(const Value: Pointer; const LastIndex: boolean);
begin

end;

procedure TuList_V.Remove(const Value: IInterface; const LastIndex: boolean);
begin

end;

procedure TuList_V.Reverse;
begin

end;

procedure TuList_V.SetCapacity(ACapacity: Integer);
begin

end;

procedure TuList_V.SetCount(Value: Integer);
begin

end;

procedure TuList_V.SetItem(const Key: Integer; const Value: Variant);
begin

end;

procedure TuList_V.SetItemV(const Key: Integer; const Value: TValueVariant);
begin

end;

procedure TuList_V.Sort;
begin

end;

procedure TuList_V.Sort(const AComparer: IuComparerValue_V);
begin

end;

procedure TuList_V.TrimExcess;
begin

end;

end.
