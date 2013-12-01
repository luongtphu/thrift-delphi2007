unit uCollections;

interface
uses sysutils,uTypes,variants,classes;

type
  TuDictionary_V_V=class
  private
     fKey:TKeyVariantArray;
     fValue:TKeyVariantArray;
  end;

  IuComparer_V = interface
    function Compare(const Left, Right: TValueVariant): Integer;
  end;

type
  IThriftContainer = interface
    ['{40AAF2AA-737F-45C5-B1E0-FCCC99C215D8}']
    function ToString: string;
  end;


type
  IThriftDictionary_V_V = interface(IThriftContainer)
    ['{95704BB4-5A0E-41CB-AB2F-43B4522A1168}']
    function GetEnumerator: TPair_V_VArray;

    function GetKeys: TKeyVariantArray;
    function GetValues: TValueVariantArray;
    function GetItem(const Key: TKeyVariant): TValueVariant;
    procedure SetItem(const Key: TKeyVariant; const Value: TValueVariant);
    function GetCount: Integer;

    procedure Add(const Key: TKeyVariant; const Value: TValueVariant);
    procedure Remove(const Key: TKeyVariant);
    function ExtractPair(const Key: TKeyVariant): TPair_V_V;
    function GetPair(const index: Cardinal): TPair_V_V;
    procedure Clear;
    procedure TrimExcess;
    function TryGetValue(const Key: TKeyVariant; out Value: TValueVariant): Boolean;
    procedure AddOrSetValue(const Key: TKeyVariant; const Value: TValueVariant);
    function ContainsKey(const Key: TKeyVariant): Boolean;
    function ContainsValue(const Value: TValueVariant): Boolean;
    function ToArray: TPair_V_VArray;

    property Items[const Key: TKeyVariant]: TValueVariant read GetItem write SetItem; default;
    property Count: Integer read GetCount;
    property Keys: TKeyVariantArray read GetKeys;
    property Values: TValueVariantArray read GetValues;
  end;

type
  TThriftDictionary_V_VImpl = class( TInterfacedObject, IThriftDictionary_V_V)
  private
    FDictionaly : TuDictionary_V_V;
  protected
    function GetEnumerator: TPair_V_VArray;

    function GetKeys: TKeyVariantArray;
    function GetValues: TValueVariantArray;
    function GetItem(const Key: TKeyVariant): TValueVariant;
    procedure SetItem(const Key: TKeyVariant; const Value: TValueVariant);
    function GetCount: Integer;

    procedure Add(const Key: TKeyVariant; const Value: TValueVariant);
    procedure Remove(const Key: TKeyVariant);
    function ExtractPair(const Key: TKeyVariant): TPair_V_V;
    function GetPair(const index: Cardinal): TPair_V_V;
    procedure Clear;
    procedure TrimExcess;
    function TryGetValue(const Key: TKeyVariant; out Value: TValueVariant): Boolean;
    procedure AddOrSetValue(const Key: TKeyVariant; const Value: TValueVariant);
    function ContainsKey(const Key: TKeyVariant): Boolean;
    function ContainsValue(const Value: TValueVariant): Boolean;
    function ToArray: TPair_V_VArray;
    property Items[const Key: TKeyVariant]: TValueVariant read GetItem write SetItem; default;
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
    function GetEnumerator: TVariantArray;
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
    procedure Sort(const AComparer: IuComparer_V); overload;
    function BinarySearch(const Item: TValueVariant; out Index: Integer): Boolean; overload;
    function BinarySearch(const Item: TValueVariant; out Index: Integer; const AComparer: IuComparer_V): Boolean; overload;
    procedure TrimExcess;
    function ToArray: TVariantArray;
    property Capacity: Integer read GetCapacity write SetCapacity;
    property Count: Integer read GetCount write SetCount;
    property Items[Index: Integer]: TValueVariant read GetItem write SetItem; default;
  end;

  TThriftList_VImpl = class( TInterfacedObject, IThriftList_V)
    private
    FList : TVariantArray;
    protected
    function GetEnumerator: TVariantArray;
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
    procedure Sort(const AComparer: IuComparer_V); overload;
    function BinarySearch(const Item: TValueVariant; out Index: Integer): Boolean; overload;
    function BinarySearch(const Item: TValueVariant; out Index: Integer; const AComparer: IuComparer_V): Boolean; overload;
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
    function GetEnumerator: TVariantArray;
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
    function GetEnumerator: TVariantArray;
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


implementation

{ TThriftDictionary_V_VImpl }

procedure TThriftDictionary_V_VImpl.Add(const Key: TKeyVariant;
  const Value: TValueVariant);
begin

end;

procedure TThriftDictionary_V_VImpl.AddOrSetValue(const Key: TKeyVariant;
  const Value: TValueVariant);
begin

end;

procedure TThriftDictionary_V_VImpl.Clear;
begin

end;

function TThriftDictionary_V_VImpl.ContainsKey(const Key: TKeyVariant): Boolean;
begin

end;

function TThriftDictionary_V_VImpl.ContainsValue(
  const Value: TValueVariant): Boolean;
begin

end;

constructor TThriftDictionary_V_VImpl.Create(ACapacity: Integer);
begin

end;

destructor TThriftDictionary_V_VImpl.Destroy;
begin

  inherited;
end;

function TThriftDictionary_V_VImpl.ExtractPair(
  const Key: TKeyVariant): TPair_V_V;
begin

end;

function TThriftDictionary_V_VImpl.GetCount: Integer;
begin

end;

function TThriftDictionary_V_VImpl.GetEnumerator: TPair_V_VArray;
begin

end;

function TThriftDictionary_V_VImpl.GetItem(
  const Key: TKeyVariant): TValueVariant;
begin

end;

function TThriftDictionary_V_VImpl.GetKeys: TKeyVariantArray;
begin

end;

function TThriftDictionary_V_VImpl.GetPair(const index: Cardinal): TPair_V_V;
begin

end;

function TThriftDictionary_V_VImpl.GetValues: TValueVariantArray;
begin

end;

procedure TThriftDictionary_V_VImpl.Remove(const Key: TKeyVariant);
begin

end;

procedure TThriftDictionary_V_VImpl.SetItem(const Key: TKeyVariant;
  const Value: TValueVariant);
begin

end;

function TThriftDictionary_V_VImpl.ToArray: TPair_V_VArray;
begin

end;

function TThriftDictionary_V_VImpl.ToString: string;
begin

end;

procedure TThriftDictionary_V_VImpl.TrimExcess;
begin

end;

function TThriftDictionary_V_VImpl.TryGetValue(const Key: TKeyVariant;
  out Value: TValueVariant): Boolean;
begin

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

function THashSet_VImpl.GetEnumerator: TVariantArray;
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
  out Index: Integer; const AComparer: IuComparer_V): Boolean;
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

end;

function TThriftList_VImpl.GetCount: Integer;
begin

end;

function TThriftList_VImpl.GetEnumerator: TVariantArray;
begin

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

procedure TThriftList_VImpl.Sort(const AComparer: IuComparer_V);
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

end.
