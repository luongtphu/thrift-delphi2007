 {
  Develop to replace Generic.Collection/ThriftCollection Delphi version less 2010
  luongtphu@gmail.com
  Date:Nov 20 2013
 }
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
  TuStack_V=class(TObject)
  private
    fValue:TValueVariantArray;
    FCount: Integer;
    FGrowThreshold: Integer;
    procedure Grow(const ACount: Integer);
    function GetCapacity: Integer;
    procedure SetCapacity(ACapacity: Integer);
    procedure Rehash(NewCapPow2: Integer);
  public
    constructor Create(Collection: TValueVariantArray);
    destructor Destroy; override;
    procedure Clear;
    procedure Push(const Value: TValueVariant);overload;
    procedure PushV(const Value: Variant);overload;
    procedure PushO(const Value: TObject);overload;
    procedure PushP(const Value: Pointer);overload;
    procedure PushI(const Value: IInterface);overload;

    function Pop: TValueVariant;overload;
    function PopV: Variant;overload;
    function PopO: TObject;overload;
    function PopP: Pointer;overload;
    function PopI: IInterface;overload;
    function Peek: TValueVariant;
    function Extract: TValueVariant;
    procedure TrimExcess;
    function ToArray: TValueVariantArray;
    property Count: Integer read FCount;
    property Capacity: Integer read GetCapacity write SetCapacity;
  end;

type
  TuList_V=class(TObject)
  private
    fValue:TValueVariantArray;
    FCount: Integer;
    FGrowThreshold: Integer;
    procedure Grow(const ACount: Integer=0);
    procedure GrowCheck(ACount: Integer);
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

    procedure AddRange(const Values: array of TValueVariant); overload;
    procedure AddRange(const Values: array of Variant); overload;
    procedure AddRange(const Values: array of IInterface); overload;
    procedure AddRange(const Values: array of Pointer); overload;

    procedure Insert(Index: Integer; const Value: TValueVariant);overload;
    procedure Insert(Index: Integer; const Value: Variant);overload;
    procedure Insert(Index: Integer; const Value: IInterface);overload;
    procedure Insert(Index: Integer; const Value: Pointer);overload;

    procedure InsertRange(Index: Integer;const Values: array of TValueVariant); overload;
    procedure InsertRange(Index: Integer;const Values: array of Variant); overload;
    procedure InsertRange(Index: Integer;const Values: array of IInterface); overload;
    procedure InsertRange(Index: Integer;const Values: array of Pointer); overload;

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
    function ToArray:TValueVariantArray;
  public
    property Count: Integer read FCount;
    property Items[const Key: integer]: TValueVariant read GetItemV write SetItemV;
    property Value[const Key: integer]: Variant read GetItem write SetItem;default;
    property Values:TValueVariantArray read ToArray;
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
    function GetItem(const Key: Integer): Variant;
    procedure SetItem(const Key: Integer; const Value: Variant);
    function GetItemV(const Key: Integer): TValueVariant;
    procedure SetItemV(const Key: Integer; const Value: TValueVariant);
    //procedure AddRange(Collection: TEnumerable<T>); overload;
    //procedure InsertRange(Index: Integer; const Collection: TVariantArray); overload;
    //procedure InsertRange(Index: Integer; const Collection: TEnumerable<T>); overload;
    function Extract(const Value: TValueVariant): TValueVariant;
    procedure Exchange(Index1, Index2: Integer);
    procedure Move(CurIndex, NewIndex: Integer);
    function First: TValueVariant;
    function Last: TValueVariant;
    procedure Clear;
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
    procedure AddRange(const Values: array of TValueVariant); overload;
    procedure AddRange(const Values: array of Variant); overload;
    procedure AddRange(const Values: array of IInterface); overload;
    procedure AddRange(const Values: array of Pointer); overload;

    procedure Insert(Index: Integer; const Value: TValueVariant);overload;
    procedure Insert(Index: Integer; const Value: Variant);overload;
    procedure Insert(Index: Integer; const Value: IInterface);overload;
    procedure Insert(Index: Integer; const Value: Pointer);overload;

    procedure InsertRange(Index: Integer;const Values: array of TValueVariant); overload;
    procedure InsertRange(Index: Integer;const Values: array of Variant); overload;
    procedure InsertRange(Index: Integer;const Values: array of IInterface); overload;
    procedure InsertRange(Index: Integer;const Values: array of Pointer); overload;
    

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

    procedure Reverse;
    procedure Sort; overload;
    procedure Sort(const AComparer: IuComparerValue_V); overload;
    function BinarySearch(const Item: Variant; out Index: Integer): Boolean; overload;
    function BinarySearch(const Item: TObject; out Index: Integer): Boolean; overload;
    function BinarySearch(const Item: IInterface; out Index: Integer): Boolean; overload;
    function BinarySearch(const Item: Pointer; out Index: Integer): Boolean; overload;
    function BinarySearch(const Item: TValueVariant; out Index: Integer; const AComparer: IuComparerValue_V): Boolean; overload;

    procedure TrimExcess;
    function ToArray: TValueVariantArray;
    property Capacity: Integer read GetCapacity write SetCapacity;
    property Count: Integer read GetCount write SetCount;
    property Items[const Key: integer]: TValueVariant read GetItemV write SetItemV;
    property Value[const Key: integer]: Variant read GetItem write SetItem;default;
    property Values:TValueVariantArray read ToArray;
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
    function GetItem(const Key: Integer): Variant;
    procedure SetItem(const Key: Integer; const Value: Variant);
    function GetItemV(const Key: Integer): TValueVariant;
    procedure SetItemV(const Key: Integer; const Value: TValueVariant);
    //procedure AddRange(Collection: TEnumerable<T>); overload;
    //procedure InsertRange(Index: Integer; const Values: array of TValueVariant); overload;
    //procedure InsertRange(Index: Integer; const Collection: TVariantArray); overload;
    //procedure InsertRange(Index: Integer; const Collection: TEnumerable<T>); overload;
    function Extract(const Value: TValueVariant): TValueVariant;
    procedure Exchange(Index1, Index2: Integer);
    procedure Move(CurIndex, NewIndex: Integer);
    function First: TValueVariant;
    function Last: TValueVariant;
    procedure Clear;
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
    procedure AddRange(const Values: array of TValueVariant); overload;
    procedure AddRange(const Values: array of Variant); overload;
    procedure AddRange(const Values: array of IInterface); overload;
    procedure AddRange(const Values: array of Pointer); overload;

    procedure Insert(Index: Integer; const Value: TValueVariant);overload;
    procedure Insert(Index: Integer; const Value: Variant);overload;
    procedure Insert(Index: Integer; const Value: IInterface);overload;
    procedure Insert(Index: Integer; const Value: Pointer);overload;

    procedure InsertRange(Index: Integer;const Values: array of TValueVariant); overload;
    procedure InsertRange(Index: Integer;const Values: array of Variant); overload;
    procedure InsertRange(Index: Integer;const Values: array of IInterface); overload;
    procedure InsertRange(Index: Integer;const Values: array of Pointer); overload;


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

    procedure Reverse;
    procedure Sort; overload;
    procedure Sort(const AComparer: IuComparerValue_V); overload;
    function BinarySearch(const Item: Variant; out Index: Integer): Boolean; overload;
    function BinarySearch(const Item: TObject; out Index: Integer): Boolean; overload;
    function BinarySearch(const Item: IInterface; out Index: Integer): Boolean; overload;
    function BinarySearch(const Item: Pointer; out Index: Integer): Boolean; overload;
    function BinarySearch(const Item: TValueVariant; out Index: Integer; const AComparer: IuComparerValue_V): Boolean; overload;


    procedure TrimExcess;
    function ToArray: TValueVariantArray;
    property Capacity: Integer read GetCapacity write SetCapacity;
    property Count: Integer read GetCount write SetCount;
    property Items[const Key: integer]: TValueVariant read GetItemV write SetItemV;
    property Value[const Key: integer]: Variant read GetItem write SetItem;default;
    property Values:TValueVariantArray read ToArray;
    function ToString: string;
  public
    constructor Create(ACapacity: Integer = 0);
    destructor Destroy; override;
  end;

  IHashSet_V = interface(IThriftContainer)
    ['{F5ECAFF0-179F-4312-8B67-044DD79DAD0F}']
    function GetItem(const Key: Integer): Variant;
    procedure SetItem(const Key: Integer; const Value: Variant);
    function GetItemV(const Key: Integer): TValueVariant;
    procedure SetItemV(const Key: Integer; const Value: TValueVariant);
    function GetIsReadOnly: Boolean;
    function GetCount: Integer;
    property Count: Integer read GetCount;
    property IsReadOnly: Boolean read GetIsReadOnly;
    procedure Add( const item: TValueVariant);overload;
    procedure Add(const value:Variant);overload;
    procedure Add(const value:TObject);overload;
    procedure Add(const value:IInterface);overload;
    procedure Add(const value:Pointer);overload;    
    procedure Clear;
    function Contains( const item: TValueVariant): Boolean;
    procedure CopyTo(var A: TValueVariantArray; arrayIndex: Integer);
    function Remove( const item: TValueVariant ): Boolean;
    property Items[const Key: integer]: TValueVariant read GetItemV write SetItemV;
    property Value[const Key: integer]: Variant read GetItem write SetItem;default;    
  end;

  THashSet_VImpl = class( TInterfacedObject, IHashSet_V)
  private
    FList:IThriftList_V;
    FIsReadOnly: Boolean;
    function GetItem(const Key: Integer): Variant;
    procedure SetItem(const Key: Integer; const Value: Variant);
    function GetItemV(const Key: Integer): TValueVariant;
    procedure SetItemV(const Key: Integer; const Value: TValueVariant);

  protected
    //function GetEnumerator: TVariantArray;
    function GetIsReadOnly: Boolean;
    function GetCount: Integer;
    property Count: Integer read GetCount;
    property IsReadOnly: Boolean read GetIsReadOnly;
    procedure Add( const item: TValueVariant);overload;
    procedure Add(const value:Variant);overload;
    procedure Add(const value:TObject);overload;
    procedure Add(const value:IInterface);overload;
    procedure Add(const value:Pointer);overload;
    procedure Clear;
    function Contains( const item: TValueVariant): Boolean;
    procedure CopyTo(var A: TValueVariantArray; arrayIndex: Integer);
    property Items[const Key: integer]: TValueVariant read GetItemV write SetItemV;
    property Value[const Key: integer]: Variant read GetItem write SetItem;default;

    function Remove( const item: TValueVariant ): Boolean;
    function ToString: string;
  public
    constructor Create;

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
  if not Contains(item) then
  begin
    FList.Add( item);
  end;
end;

procedure THashSet_VImpl.Add(const value: TObject);
begin
  Flist.Add(value);
end;

procedure THashSet_VImpl.Add(const value: Variant);
begin
  Flist.Add(value);
end;

procedure THashSet_VImpl.Add(const value: Pointer);
begin
  Flist.Add(value);
end;

procedure THashSet_VImpl.Add(const value: IInterface);
begin
  Flist.Add(value);
end;

procedure THashSet_VImpl.Clear;
begin
  Flist.Clear;
end;

function THashSet_VImpl.Contains(const item: TValueVariant): Boolean;
begin
  result:=Flist.Contains(item);
end;

procedure THashSet_VImpl.CopyTo(var A: TValueVariantArray; arrayIndex: Integer);
var
n,i:integer;
begin
  n:=FList.Count;
  for i := 0 to n - 1 do
  begin
   A[i+arrayIndex]:=FList.Items[i];
  end;
end;

constructor THashSet_VImpl.Create;
begin
    FList :=TThriftList_VImpl.Create;
end;

function THashSet_VImpl.GetCount: Integer;
begin
  result:=FList.Count;
end;


function THashSet_VImpl.GetIsReadOnly: Boolean;
begin

end;

function THashSet_VImpl.GetItem(const Key: Integer): Variant;
begin
  result:=Flist.GetItem(Key);
end;

function THashSet_VImpl.GetItemV(const Key: Integer): TValueVariant;
begin
  result:=Flist.GetItemV(Key);
end;

function THashSet_VImpl.Remove(const item: TValueVariant): Boolean;
begin
  FList.Remove(item);
  Result := not Contains(item);
end;

procedure THashSet_VImpl.SetItem(const Key: Integer; const Value: Variant);
begin
  Flist.SetItem(Key,Value);
end;

procedure THashSet_VImpl.SetItemV(const Key: Integer;
  const Value: TValueVariant);
begin
  Flist.SetItemV(Key,Value);
end;

function THashSet_VImpl.ToString: string;
begin

end;

{ TThriftList_VImpl }


function TThriftList_VImpl.BinarySearch(const Item: TObject;
  out Index: Integer): Boolean;
begin
  result:=FList.BinarySearch(Item,Index);
end;

function TThriftList_VImpl.BinarySearch(const Item: Variant;
  out Index: Integer): Boolean;
begin
  result:=FList.BinarySearch(Item,Index);
end;

function TThriftList_VImpl.BinarySearch(const Item: IInterface;
  out Index: Integer): Boolean;
begin
  result:=FList.BinarySearch(Item,Index);
end;

procedure TThriftList_VImpl.Add(const value: TObject);
begin
  FList.Add(Value);
end;

procedure TThriftList_VImpl.Add(const value: Variant);
begin
  FList.Add(Value);
end;

procedure TThriftList_VImpl.Add(const Value: TValueVariant);
begin
  FList.Add(Value);
end;

procedure TThriftList_VImpl.Add(const value: Pointer);
begin
  FList.Add(Value);
end;

procedure TThriftList_VImpl.Add(const value: IInterface);
begin
  FList.Add(Value);
end;

procedure TThriftList_VImpl.AddOrSetValue(const Key: Integer;
  const value: IInterface);
begin
  FList.AddOrSetValue(Key,Value);
end;

procedure TThriftList_VImpl.AddOrSetValue(const Key: Integer;
  const value: Pointer);
begin
  FList.AddOrSetValue(Key,Value);
end;

procedure TThriftList_VImpl.AddRange(const Values: array of Variant);
begin
  FList.AddRange(Values);
end;

procedure TThriftList_VImpl.AddRange(const Values: array of TValueVariant);
begin
  FList.AddRange(Values);
end;

procedure TThriftList_VImpl.AddRange(const Values: array of Pointer);
begin
  FList.AddRange(Values);
end;

procedure TThriftList_VImpl.AddRange(const Values: array of IInterface);
begin
  FList.AddRange(Values);
end;

procedure TThriftList_VImpl.AddOrSetValue(const Key: Integer;
  const Value: TValueVariant);
begin
  FList.AddOrSetValue(Key,Value);
end;

procedure TThriftList_VImpl.AddOrSetValue(const Key: Integer;
  const value: Variant);
begin
  FList.AddOrSetValue(Key,Value);
end;

procedure TThriftList_VImpl.AddOrSetValue(const Key: Integer;
  const value: TObject);
begin
  FList.AddOrSetValue(Key,Value);
end;

function TThriftList_VImpl.AsFloat(const Key: Integer): Double;
begin
  result:=FList.AsFloat(Key);
end;

function TThriftList_VImpl.AsInt(const Key: Integer): Integer;
begin
  result:=FList.AsInt(Key);
end;

function TThriftList_VImpl.AsIntf(const Key: Integer): IInterface;
begin
  result:=FList.AsIntf(Key);
end;

function TThriftList_VImpl.AsObj(const Key: Integer): TObject;
begin
  result:=FList.AsObj(Key);
end;

function TThriftList_VImpl.AsPointer(const Key: Integer): Pointer;
begin
  result:=FList.AsPointer(Key);
end;

function TThriftList_VImpl.AsString(const Key: Integer): string;
begin
  result:=FList.AsString(Key);
end;

function TThriftList_VImpl.BinarySearch(const Item: TValueVariant;
  out Index: Integer; const AComparer: IuComparerValue_V): Boolean;
begin
  result:=FList.BinarySearch(Item,Index,AComparer);
end;

function TThriftList_VImpl.BinarySearch(const Item: Pointer;
  out Index: Integer): Boolean;
begin
  result:=FList.BinarySearch(Item,Index);
end;

procedure TThriftList_VImpl.Clear;
begin
  FList.Clear;
end;


function TThriftList_VImpl.Contains(const Value: Variant): boolean;
begin
  result:=FList.Contains(Value);
end;

function TThriftList_VImpl.Contains(Value: TValueVariant): boolean;
begin
  result:=FList.Contains(Value);
end;

function TThriftList_VImpl.Contains(const Value: TObject): boolean;
begin
  result:=FList.Contains(Value);
end;

function TThriftList_VImpl.Contains(const Value: IInterface): boolean;
begin
  result:=FList.Contains(Value);
end;

function TThriftList_VImpl.Contains(const Value: Pointer): boolean;
begin
  result:=FList.Contains(Value);
end;

constructor TThriftList_VImpl.Create(ACapacity: Integer = 0);
begin
  FList:=TuList_V.Create(ACapacity);
end;

procedure TThriftList_VImpl.Delete(Index: Integer);
begin
  FList.Delete(index);
end;

procedure TThriftList_VImpl.DeleteRange(AIndex, ACount: Integer);
begin
  FList.DeleteRange(Aindex,ACount);
end;

destructor TThriftList_VImpl.Destroy;
begin
  if assigned(FList) then
    FList.Free;
  inherited;
end;

procedure TThriftList_VImpl.Exchange(Index1, Index2: Integer);
begin
  FList.Exchange(index1,index2);
end;

function TThriftList_VImpl.Extract(const Value: TValueVariant): TValueVariant;
begin

end;

function TThriftList_VImpl.First: TValueVariant;
begin
  result:=FList.First;
end;

function TThriftList_VImpl.GetCapacity: Integer;
begin
  result:=FList.GetCapacity;
end;

function TThriftList_VImpl.GetCount: Integer;
begin
  result:=FList.Count;
end;

function TThriftList_VImpl.GetItem(const Key: Integer): Variant;
begin
  result:=FList.GetItem(Key);
end;

function TThriftList_VImpl.GetItemV(const Key: Integer): TValueVariant;
begin
  result:=FList.GetItemV(Key);
end;

function TThriftList_VImpl.IndexOf(const Value: Pointer;
  const LastIndex: boolean): integer;
begin
  result:=FList.IndexOf(Value,LastIndex);
end;

function TThriftList_VImpl.IndexOf(const Value: IInterface;
  const LastIndex: boolean): integer;
begin
  result:=FList.IndexOf(Value,LastIndex);
end;

procedure TThriftList_VImpl.Insert(Index: Integer; const Value: Variant);
begin
  FList.Insert(index,Value);
end;

procedure TThriftList_VImpl.Insert(Index: Integer; const Value: IInterface);
begin
  FList.Insert(index,Value);
end;

procedure TThriftList_VImpl.Insert(Index: Integer; const Value: Pointer);
begin
  FList.Insert(index,Value);
end;

procedure TThriftList_VImpl.InsertRange(Index: Integer;
  const Values: array of Variant);
begin
  FList.InsertRange(Index,Values);
end;

procedure TThriftList_VImpl.InsertRange(Index: Integer;
  const Values: array of TValueVariant);
begin
  FList.InsertRange(Index,Values);
end;

procedure TThriftList_VImpl.InsertRange(Index: Integer;
  const Values: array of Pointer);
begin
  FList.InsertRange(Index,Values);
end;

procedure TThriftList_VImpl.InsertRange(Index: Integer;
  const Values: array of IInterface);
begin
  FList.InsertRange(Index,Values);
end;

function TThriftList_VImpl.IndexOf(const Value: TObject;
  const LastIndex: boolean): integer;
begin
  result:=FList.IndexOf(Value,LastIndex);
end;

function TThriftList_VImpl.IndexOf(Value: TValueVariant;
  const LastIndex: boolean): integer;
begin
  result:=FList.IndexOf(Value,LastIndex);
end;

function TThriftList_VImpl.IndexOf(const Value: Variant;
  const LastIndex: boolean): integer;
begin
  result:=FList.IndexOf(Value,LastIndex);
end;

procedure TThriftList_VImpl.Insert(Index: Integer; const Value: TValueVariant);
begin
  FList.Insert(index,Value);
end;

function TThriftList_VImpl.Last: TValueVariant;
begin
  result:=FList.Last;
end;

function TThriftList_VImpl.LastIndexOf(const Value: Pointer): integer;
begin
  result:=FList.LastIndexOf(Value);
end;

function TThriftList_VImpl.LastIndexOf(const Value: IInterface): integer;
begin
  result:=FList.LastIndexOf(Value);
end;

function TThriftList_VImpl.LastIndexOf(const Value: TObject): integer;
begin
  result:=FList.LastIndexOf(Value);
end;

function TThriftList_VImpl.LastIndexOf(Value: TValueVariant): integer;
begin
  result:=FList.LastIndexOf(Value);
end;

function TThriftList_VImpl.LastIndexOf(const Value: Variant): integer;
begin
  result:=FList.LastIndexOf(Value);
end;

procedure TThriftList_VImpl.Move(CurIndex, NewIndex: Integer);
begin

end;

procedure TThriftList_VImpl.Remove(const Value: Variant;
  const LastIndex: boolean);
begin
  FList.Remove(Value,LastIndex);
end;

procedure TThriftList_VImpl.Remove(const value: TValueVariant;
  const LastIndex: boolean);
begin
  FList.Remove(Value,LastIndex);
end;

procedure TThriftList_VImpl.Remove(const Value: TObject;
  const LastIndex: boolean);
begin
  FList.Remove(Value,LastIndex);
end;

procedure TThriftList_VImpl.Remove(const Value: IInterface;
  const LastIndex: boolean);
begin
  FList.Remove(Value,LastIndex);
end;

procedure TThriftList_VImpl.Remove(const Value: Pointer;
  const LastIndex: boolean);
begin
  FList.Remove(Value,LastIndex);
end;

procedure TThriftList_VImpl.Reverse;
begin
  FList.Reverse;
end;

procedure TThriftList_VImpl.SetCapacity(Value: Integer);
begin
  FList.SetCapacity(Value);
end;

procedure TThriftList_VImpl.SetCount(Value: Integer);
begin
  FList.SetCount(Value);
end;

procedure TThriftList_VImpl.SetItem(const Key: Integer; const Value: Variant);
begin
  FList.SetItem(Key,value);
end;

procedure TThriftList_VImpl.SetItemV(const Key: Integer;
  const Value: TValueVariant);
begin
  FList.SetItemV(Key,value);
end;

procedure TThriftList_VImpl.Sort;
begin
  FList.Sort;
end;

procedure TThriftList_VImpl.Sort(const AComparer: IuComparerValue_V);
begin
  FList.Sort(AComparer);
end;

function TThriftList_VImpl.ToArray: TValueVariantArray;
begin
  result:=FList.ToArray;
end;

function TThriftList_VImpl.ToString: string;
begin

end;

procedure TThriftList_VImpl.TrimExcess;
begin
  FList.TrimExcess;
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


{ TuList_V }

procedure TuList_V.Add(const value: Pointer);
begin
  add(TValueVariant.Create(value));
end;

procedure TuList_V.Add(const Value: TValueVariant);
begin
  if (FCount >= FGrowThreshold) or (FCount>=High(fvalue)) then
    Grow;
  DoAdd(Count, Value);
end;

procedure TuList_V.Add(const value: IInterface);
begin
  add(TValueVariant.Create(value));
end;

procedure TuList_V.Add( const value: Variant);
begin
  add(TValueVariant.Create(value));
end;

procedure TuList_V.Add(const value: TObject);
begin
  add(TValueVariant.Create(value));
end;

procedure TuList_V.AddOrSetValue(const Key: integer; const value: Pointer);
begin
  AddOrSetValue(key,TValueVariant.Create(value));
end;

procedure TuList_V.AddRange(const Values: array of Variant);
var
i,n:integer;
begin
  n:=length(Values);
  if n<=0 then exit;
  for i := 0 to n - 1 do
    Add(Values[i]);
end;

procedure TuList_V.AddRange(const Values: array of TValueVariant);
var
i,n:integer;
begin
  n:=length(Values);
  if n<=0 then exit;
  for i := 0 to n - 1 do
    Add(Values[i]);
end;

procedure TuList_V.AddRange(const Values: array of Pointer);
var
i,n:integer;
begin
  n:=length(Values);
  if n<=0 then exit;
  for i := 0 to n - 1 do
    Add(Values[i]);
end;

procedure TuList_V.AddRange(const Values: array of IInterface);
var
i,n:integer;
begin
  n:=length(Values);
  if n<=0 then exit;
  for i := 0 to n - 1 do
    Add(Values[i]);
end;

procedure TuList_V.AddOrSetValue(const Key: Integer; const value: Variant);
begin
  AddOrSetValue(key,TValueVariant.Create(value));
end;

procedure TuList_V.AddOrSetValue(const Key: Integer;
  const Value: TValueVariant);
var
  index:Integer;
begin
  index := Key;
  if (index<0) or (index>=FCount) then
  begin
    if Count >= FGrowThreshold then
        Grow;
    index:=Count;
  end; 
  DoAdd(index, Value);
end;

procedure TuList_V.AddOrSetValue(const Key: Integer; const value: TObject);
begin
  AddOrSetValue(key,TValueVariant.Create(value));
end;

procedure TuList_V.AddOrSetValue(const Key: Integer;
  const value: IInterface);
begin
  AddOrSetValue(key,TValueVariant.Create(value));
end;

function TuList_V.AsFloat(const Key: Integer): Double;
begin
  result:=GetItemV(Key).AsFloat;
end;

function TuList_V.AsInt(const Key: Integer): Integer;
begin
  result:=GetItemV(Key).AsInt;
end;

function TuList_V.AsIntf(const Key: Integer): IInterface;
begin
  result:=GetItemV(Key).AsIntf;
end;

function TuList_V.AsObj(const Key: Integer): TObject;
begin
  result:=GetItemV(Key).AsPointer;
end;

function TuList_V.AsPointer(const Key: Integer): Pointer;
begin
  result:=GetItemV(Key).AsPointer;
end;

function TuList_V.AsString(const Key: Integer): string;
begin
  result:=GetItemV(Key).AsString;
end;

function TuList_V.BinarySearch(const Item: TObject;
  out Index: Integer): Boolean;
var
Itemt:TValueVariant;
begin
  Itemt.Create(Item,true);
  result:=Array_AllValue_BinarySearch(fvalue,Itemt,Index);
end;


function TuList_V.BinarySearch(const Item: Variant;
  out Index: Integer): Boolean;
var
Itemt:TValueVariant;
begin
  Itemt.Create(Item);
  result:=Array_AllValue_BinarySearch(fvalue,Itemt,Index);
end;

function TuList_V.BinarySearch(const Item: IInterface;
  out Index: Integer): Boolean;
var
Itemt:TValueVariant;
begin
  Itemt.Create(Item);
  result:=Array_AllValue_BinarySearch(fvalue,Itemt,Index);
end;

function TuList_V.BinarySearch(const Item: TValueVariant; out Index: Integer;
  const AComparer: IuComparerValue_V): Boolean;
begin
  result:=Array_AllValue_BinarySearch(fvalue,Item,Index,AComparer);
end;

function TuList_V.BinarySearch(const Item: Pointer;
  out Index: Integer): Boolean;
var
Itemt:TValueVariant;
begin
  Itemt.Create(Item);
  result:=Array_AllValue_BinarySearch(fvalue,Itemt,Index);
end;

procedure TuList_V.Clear;
var
  i: Integer;
  oldItemsv: TValueVariantArray;
begin
  for i := 0 to FCount - 1 do
  begin
    fValue[i].Free;
  end;
  oldItemsv := fValue;
  FCount := 0;
  SetLength(fValue, 0);
  SetCapacity(0);
  FGrowThreshold := 0;

  for i := 0 to FCount - 1 do
  begin
    //KeyNotify(oldItems[i].Key, cnRemoved);
    //ValueNotify(oldItems[i].Value, cnRemoved);
  end;
end;

function TuList_V.Contains(const Value: Pointer): boolean;
begin
  result:=(IndexOf(Value)>=0);
end;

function TuList_V.Contains(const Value: IInterface): boolean;
begin
  result:=(IndexOf(Value)>=0);
end;

function TuList_V.Contains(const Value: TObject): boolean;
begin
  result:=(IndexOf(Value)>=0);
end;

function TuList_V.Contains(Value: TValueVariant): boolean;
begin
  result:=(IndexOf(Value)>=0);
end;

function TuList_V.Contains(const Value: Variant): boolean;
begin
  result:=(IndexOf(Value)>=0);
end;

constructor TuList_V.Create(ACapacity: Integer);
begin
  inherited Create;
  if ACapacity < 0 then
    raise Exception.Create('Error: ACapacity less Zero');
  SetCapacity(ACapacity);
end;

procedure TuList_V.Delete(Index: Integer);
var
t:TValueVariant;
begin
  t:=DoRemove(Index, cnRemoved);
  if assigned(t) then
    t.Free;
end;

procedure TuList_V.DeleteRange(AIndex, ACount: Integer);
var
  newItems: array of TValueVariant;
  FCountt,tailCount, i1,I: Integer;
begin
  if (AIndex < 0) or (ACount < 0) or (AIndex + ACount > Count)
    or (AIndex + ACount < 0) then
    raise Exception.Create('Error: Out of Range');
  if ACount = 0 then
    Exit;
  FCountt:=FCount-ACount;
  SetLength(newItems,FCountt);
  for I := AIndex to AIndex+ACount - 1 do
  begin
    fValue[i].Free;
    fValue[i]:=nil;
  end;
  if (FCountt=0) then
  begin
    FCount:=FCountt;
    exit;
  end;
  for I := 0 to AIndex-1 do
  begin
    newItems[i]:=fValue[i];
  end;
  i1:=AIndex;
  for I := AIndex+ACount to FCount do
  begin
    newItems[i1]:=fValue[i];
    inc(i1);
  end;
  FCount:=FCountt;
end;

destructor TuList_V.Destroy;
begin
  if Count<=0 then exit;
  Clear;
  inherited;
end;

procedure TuList_V.DoAdd(Index: Integer; const Value: TValueVariant);
begin
  fValue[Index]:= Value;
  Inc(FCount);

end;

function TuList_V.DoRemove(const Key: integer;
  Notification: TuCollectionNotification): TValueVariant;
var
  gap, index: Integer;
begin
  Result :=nil;
  index := Key;
  if (index < 0) or (index>Count) then  Exit;
  Result := fvalue[index];

  gap := index;
  while index<FCount-1 do
  begin
    Inc(index);
    fvalue[gap]:=fvalue[index];
    gap := index;
  end;
  Dec(FCount);
  //KeyNotify(Key, Notification);
  //ValueNotify(Result, Notification);

end;

procedure TuList_V.DoSetValue(Index: Integer; const Value: TValueVariant);
var
  oldValue: TValueVariant;
begin
  if (Index<0) or (Index>=count) then exit;
  oldValue := Fvalue[Index];
  Fvalue[Index]:= Value;
  //ValueNotify(oldValue, cnRemoved);
  //ValueNotify(Value, cnAdded);
end;

procedure TuList_V.Exchange(Index1, Index2: Integer);
var
v:TValueVariant;
begin
  if (Index1=Index2) then exit;
  if (Index1<0) or (Index1>=Count) then exit;
  if (Index2<0) or (Index2>=Count) then exit;
  v:=fvalue[Index1];
  fvalue[Index1]:=fvalue[Index2];
  fvalue[Index2]:=v;
  

end;

function TuList_V.First: TValueVariant;
begin
  result:=nil;
  if (Count<0) then exit;
  result:=fvalue[0];
end;

function TuList_V.GetCapacity: Integer;
begin
  Result := Length(fvalue);
end;

procedure TuList_V.SetCount(Value: Integer);
begin
  if Value < 0 then
    raise Exception.Create('Error: Count less Zero');
  if Value > Capacity then
    SetCapacity(Value);
  if Value < Count then
    DeleteRange(Value, Count - Value);
  FCount := Value;
end;

function TuList_V.GetItem(const Key: integer): Variant;
begin
  if (Key < 0) or (Key>=Count) then
    raise EListError.Create('Error: Not Found key');
  Result := FValue[Key].GetValueV;
end;

function TuList_V.GetItemV(const Key: integer): TValueVariant;
begin
  if (Key < 0) or (Key>=Count) then
    raise EListError.Create('Error: Not Found key');
  Result := FValue[Key];
end;

procedure TuList_V.Grow(const ACount: Integer);
var
  newCap: Integer;
begin
  newCap :=ACount;
  if (ACount=0) then
  begin
    newCap := Length(fvalue) * 2;
  end;
  if newCap = 0 then
    newCap := 4;
  Rehash(newCap);
end;

procedure TuList_V.GrowCheck(ACount: Integer);
begin
  if ACount > Length(fValue) then
    Grow
  else if ACount < 0 then
    OutOfMemoryError;
end;

procedure TuList_V.Rehash(NewCapPow2: Integer);
var
  oldItems, newItems: TValueVariantArray;
  i: Integer;
begin
  if NewCapPow2 = Length(fvalue) then
    Exit
  else if NewCapPow2 < 0 then
    OutOfMemoryError;

  oldItems := fValue;
  SetLength(newItems, NewCapPow2);

  fValue := newItems;
  FGrowThreshold := NewCapPow2 shr 1 + NewCapPow2 shr 2; // 75%

  for i := 0 to Length(oldItems) - 1 do
  begin
    fValue[i]:=oldItems[i];
  end;
  SetLength(oldItems, 0);
end;


procedure TuList_V.Remove(const Value: TObject; const LastIndex: boolean);
var
t:TValueVariant;
Key:integer;
begin
  Key:=IndexOf(value,LastIndex);
  if (Key>=0) then
  begin
    t:=DoRemove(Key, cnRemoved);
    if assigned(t) then
      t.Free;
  end;


end;

procedure TuList_V.Remove(const Value: Variant; const LastIndex: boolean);
var
t:TValueVariant;
Key:integer;
begin
  Key:=IndexOf(value,LastIndex);
  if (Key>=0) then
  begin
    t:=DoRemove(Key, cnRemoved);
    if assigned(t) then
      t.Free;
  end;
end;

procedure TuList_V.Remove(const Value: IInterface; const LastIndex: boolean);
var
t:TValueVariant;
Key:integer;
begin
  Key:=IndexOf(value,LastIndex);
  if (Key>=0) then
  begin
    t:=DoRemove(Key, cnRemoved);
    if assigned(t) then
      t.Free;
  end;


end;

procedure TuList_V.Remove(const Value: Pointer; const LastIndex: boolean);
var
t:TValueVariant;
Key:integer;
begin
  Key:=IndexOf(value,LastIndex);
  if (Key>=0) then
  begin
    t:=DoRemove(Key, cnRemoved);
    if assigned(t) then
      t.Free;
  end;


end;

procedure TuList_V.Remove(const value:TValueVariant;const LastIndex:boolean);
var
t:TValueVariant;
Key:integer;
begin
  Key:=IndexOf(value,LastIndex);
  if (Key>=0) then
  begin
    t:=DoRemove(Key, cnRemoved);
    if assigned(t) then
      t.Free;
  end;

end;

procedure TuList_V.Reverse;
var
  tmp: TValueVariant;
  b, e: Integer;
begin
  b := 0;
  e := Count - 1;
  while b < e do
  begin
    tmp := Fvalue[b];
    Fvalue[b] := Fvalue[e];
    Fvalue[e] := tmp;
    Inc(b);
    Dec(e);
  end;
end;

procedure TuList_V.SetCapacity(ACapacity: Integer);
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


procedure TuList_V.SetItem(const Key: Integer; const Value: Variant);
begin
  if (Key < 0) or (Key>=Count) then
    raise EListError.Create('Error: Not Found key');
  FValue[Key]:=TValueVariant.Create(Value);
end;

procedure TuList_V.SetItemV(const Key: integer; const Value: TValueVariant);
begin
  if (Key < 0) or (Key>=Count) then
    raise EListError.Create('Error: Not Found key');
  FValue[Key]:=Value;

end;

procedure TuList_V.Sort;
begin
  Array_AllValue_Sort(fvalue,0,Count);
end;

procedure TuList_V.Sort(const AComparer: IuComparerValue_V);
begin
  Array_AllValue_Sort(fvalue, AComparer, 0, Count);
end;

function TuList_V.ToArray: TValueVariantArray;
begin
  result:=fvalue;
end;

procedure TuList_V.TrimExcess;
begin
  SetCapacity(Count + 1);
end;

function TuList_V.IndexOf(const Value: TObject;const LastIndex:boolean=false): integer;
var
n,d,i:integer;
begin
  result:=-1;
  if (Count<=0) or(not assigned(Value)) then exit;
  d:=1;
  i:=0;
  n:=Count;
  if (LastIndex) then
  begin
    d:=-1;
    i:=n-1;
  end;
  repeat
    if (fValue[i].GetType=avt_object) and (fValue[i].GetValueO=Value) then
    begin
      result:=i;
      exit;
    end;
    i:=i+d;
  until (i>=0) and (i<n);
end;

function TuList_V.IndexOf(const Value: Pointer;const LastIndex:boolean=false): integer;
var
n,d,i:integer;
begin
  result:=-1;
  if (Count<=0) or(Value=nil) then exit;
  d:=1;
  i:=0;
  n:=Count;
  if (LastIndex) then
  begin
    d:=-1;
    i:=n-1;
  end;
  repeat
    if (fValue[i].GetType=avt_pointer) and (fValue[i].GetValueP=Value) then
    begin
      result:=i;
      exit;
    end;
    i:=i+d;
  until (i>=0) and (i<n);
end;

function TuList_V.IndexOf(Value: TValueVariant;const LastIndex:boolean=false): integer;
var
n,d,i:integer;
begin
  result:=-1;
  if (Count<=0) or(not assigned(Value)) then exit;
  d:=1;
  i:=0;
  n:=Count;
  if (LastIndex) then
  begin
    d:=-1;
    i:=n-1;
  end;
  repeat
    if fValue[i]=Value then
    begin
      result:=i;
      exit;
    end;
    i:=i+d;
  until (i>=0) and (i<n);
end;

function TuList_V.IndexOf(const Value: Variant;const LastIndex:boolean=false): integer;
var
n,d,i:integer;
begin
  result:=-1;
  if (Count<=0) or(VarIsEmpty(Value)) then exit;
  d:=1;
  i:=0;
  n:=Count;
  if (LastIndex) then
  begin
    d:=-1;
    i:=n-1;
  end;
  repeat
    if (fValue[i].GetType=avt_variants) and (VarType(fValue[i].GetValueV)=VarType(Value)) then
    if (fValue[i].GetValueV=Value) then
    begin
      result:=i;
      exit;
    end;
    i:=i+d;
  until (i>=0) and (i<n);
end;



function TuList_V.IndexOf(const Value: IInterface;const LastIndex:boolean=false): integer;
var
n,d,i:integer;
begin
  result:=-1;
  if (Count<=0) or(Value=nil) then exit;
  d:=1;
  i:=0;
  n:=Count;
  if (LastIndex) then
  begin
    d:=-1;
    i:=n-1;
  end;
  repeat
    if (fValue[i].GetType=avt_interface) and (fValue[i].GetValueI=Value) then
    begin
      result:=i;
      exit;
    end;
    i:=i+d;
  until (i>=0) and (i<n);
end;


procedure TuList_V.Insert(Index: Integer; const Value: Variant);
begin
  Insert(Index,TValueVariant.Create(value));
end;

procedure TuList_V.Insert(Index: Integer; const Value: TValueVariant);
var
i:integer;
begin
  if (Index < 0) or (Index > Count) then
    raise Exception.Create('Error: Out of range');

  GrowCheck(Count + 1);
  for i := Count downto Index+1 do
  begin
    Fvalue[i] := Fvalue[i-1];
  end;
  Fvalue[Index] := Value;
  Inc(FCount);
  //Notify(Value, cnAdded);
end;

procedure TuList_V.Insert(Index: Integer; const Value: Pointer);
begin
  Insert(Index,TValueVariant.Create(value));
end;

procedure TuList_V.InsertRange(Index: Integer; const Values: array of Variant);
var
n,i:integer;
begin
  n:=length(Values);
  if (Index < 0) or (Index > Count) then
    raise Exception.Create('Error: Out of range');
  if (n=0) then
    raise Exception.Create('Error: Length values Zero');
  GrowCheck(FCount + length(Values));
  for i := 0 to n-1 do
  begin
    insert(Index+i,Values[i]);
  end;
end;

procedure TuList_V.InsertRange(Index: Integer;
  const Values: array of TValueVariant);
var
n,i:integer;
begin
  n:=length(Values);
  if (Index < 0) or (Index > Count) then
    raise Exception.Create('Error: Out of range');
  if (n=0) then
    raise Exception.Create('Error: Length values Zero');
  GrowCheck(FCount + length(Values));
  for i := 0 to n-1 do
  begin
    insert(Index+i,Values[i]);
  end;
end;

procedure TuList_V.InsertRange(Index: Integer; const Values: array of Pointer);
var
n,i:integer;
begin
  n:=length(Values);
  if (Index < 0) or (Index > Count) then
    raise Exception.Create('Error: Out of range');
  if (n=0) then
    raise Exception.Create('Error: Length values Zero');
  GrowCheck(FCount + length(Values));
  for i := 0 to n-1 do
  begin
    insert(Index+i,Values[i]);
  end;
end;

procedure TuList_V.InsertRange(Index: Integer;
  const Values: array of IInterface);
var
n,i:integer;
begin
  n:=length(Values);
  if (Index < 0) or (Index > Count) then
    raise Exception.Create('Error: Out of range');
  if (n=0) then
    raise Exception.Create('Error: Length values Zero');
  GrowCheck(FCount + length(Values));
  for i := 0 to n-1 do
  begin
    insert(Index+i,Values[i]);
  end;
end;

procedure TuList_V.Insert(Index: Integer; const Value: IInterface);
begin
  Insert(Index,TValueVariant.Create(value));
end;

function TuList_V.LastIndexOf(const Value: Pointer): integer;
begin
  result:=IndexOf(Value,true);
end;

function TuList_V.Last: TValueVariant;
begin
  result:=nil;
  if (FCount<0) then exit;
  result:=fvalue[FCount-1];
end;

function TuList_V.LastIndexOf(const Value: IInterface): integer;
begin
  result:=IndexOf(Value,true);
end;
{
procedure TuList_V.Move(CurIndex, NewIndex: Integer);
var
  temp: TValueVariant;
begin
  if CurIndex = NewIndex then
    Exit;
  if (NewIndex < 0) or (NewIndex >= FCount) then
    raise EOutOfMemory.Create('Error: Out of range');

  temp := fvalue[CurIndex];
  fvalue[CurIndex] := nil;
  if CurIndex < NewIndex then
    FArrayManager.Move(FItems, CurIndex + 1, CurIndex, NewIndex - CurIndex)
  else
    FArrayManager.Move(FItems, NewIndex, NewIndex + 1, CurIndex - NewIndex);

  FArrayManager.Finalize(FItems, NewIndex, 1);
  fvalue[NewIndex] := temp;
end;
}


function TuList_V.LastIndexOf(const Value: TObject): integer;
begin
  result:=IndexOf(Value,true);
end;

function TuList_V.LastIndexOf(Value: TValueVariant): integer;
begin
  result:=IndexOf(Value,true);
end;

function TuList_V.LastIndexOf(const Value: Variant): integer;
begin
  result:=IndexOf(Value,true);
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

{ TuStack_V }

procedure TuStack_V.Clear;
var
  i: Integer;
  oldItemsv: TValueVariantArray;
begin
  for i := 0 to FCount - 1 do
  begin
    fValue[i].Free;
  end;
  oldItemsv := fValue;
  FCount := 0;
  SetLength(fValue, 0);
  SetCapacity(0);
  FGrowThreshold := 0;

  for i := 0 to FCount - 1 do
  begin
    //KeyNotify(oldItems[i].Key, cnRemoved);
    //ValueNotify(oldItems[i].Value, cnRemoved);
  end;
end;


constructor TuStack_V.Create(Collection: TValueVariantArray);
var
ACapacity:integer;
item: TValueVariant;
n,i:integer;
begin
inherited Create;
ACapacity:=0;
n:=0;
if Collection<>nil then
  if length(Collection)>0 then
  begin
    n:=length(Collection);
    ACapacity:=n+10;
  end;

  if ACapacity < 0 then
    raise Exception.Create('Error: ACapacity less Zero');
  SetCapacity(ACapacity);

  for  i:=0 to n-1 do
  begin
    item:=Collection[i];
    Push(item);
  end;
end;

destructor TuStack_V.Destroy;
begin
  if Count<=0 then exit;
  Clear;
  inherited;
end;

function TuStack_V.Extract: TValueVariant;
begin
  result:=Pop;
end;

function TuStack_V.GetCapacity: Integer;
begin
  Result := Length(fvalue);
end;

procedure TuStack_V.Grow(const ACount: Integer);
var
  newCap: Integer;
begin
  newCap :=ACount;
  if (ACount=0) then
  begin
    newCap := Length(fvalue) * 2;
  end;
  if newCap = 0 then
    newCap := 4;
  Rehash(newCap);
end;

function TuStack_V.Peek: TValueVariant;
begin
  if Count = 0 then
    raise EListError.Create('Unbalanced stack or queue operation');
  Result := fValue[Count - 1];

end;

function TuStack_V.PopP: Pointer;
var
t:TValueVariant;
begin
t:=Pop;
result:=nil;
if (t<>nil) then
  result:=t.GetValueP;
end;

function TuStack_V.PopI: IInterface;
var
t:TValueVariant;
begin
t:=Pop;
if (t<>nil) then
  result:=t.GetValueI;
end;

function TuStack_V.PopV: Variant;
var
t:TValueVariant;
begin
t:=Pop;
if (t<>nil) then
  result:=t.GetValueV;
end;

function TuStack_V.PopO: TObject;
var
t:TValueVariant;
begin
t:=Pop;
result:=nil;
if (t<>nil) then
  result:=t.GetValueO;
end;

function TuStack_V.Pop: TValueVariant;
begin
  Result := nil;
  if Count = 0 then
    raise EListError.Create('Unbalanced stack or queue operation');
  Dec(FCount);
  Result := fValue[Count];
  fValue[Count]:=nil;
  //Notify(Result, Notification);
end;

procedure TuStack_V.Push(const Value: TValueVariant);
begin
  if Count = Length(fValue) then
    Grow(Count+4);
  fValue[Count] := Value;
  Inc(FCount);
  //Notify(Value, cnAdded);
end;

procedure TuStack_V.Rehash(NewCapPow2: Integer);
var
  oldItems, newItems: TValueVariantArray;
  i: Integer;
begin
  if NewCapPow2 = Length(fvalue) then
    Exit
  else if NewCapPow2 < 0 then
    OutOfMemoryError;

  oldItems := fValue;
  SetLength(newItems, NewCapPow2);

  fValue := newItems;
  FGrowThreshold := NewCapPow2 shr 1 + NewCapPow2 shr 2; // 75%

  for i := 0 to Length(oldItems) - 1 do
  begin
    fValue[i]:=oldItems[i];
  end;
  SetLength(oldItems, 0);
end;


procedure TuStack_V.SetCapacity(ACapacity: Integer);
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


function TuStack_V.ToArray: TValueVariantArray;
begin
  result:=fValue;
end;

procedure TuStack_V.TrimExcess;
begin
  SetCapacity(Count + 1);
end;

procedure  TuStack_V.PushP(const Value: Pointer);
begin
  push(TValueVariant.Create(Value));
end;

procedure TuStack_V.PushI(const Value: IInterface);
begin
  push(TValueVariant.Create(Value));
end;

procedure TuStack_V.PushV(const Value: Variant);
begin
  push(TValueVariant.Create(Value));
end;

procedure TuStack_V.PushO(const Value: TObject);
begin
  push(TValueVariant.Create(Value));
end;

end.
