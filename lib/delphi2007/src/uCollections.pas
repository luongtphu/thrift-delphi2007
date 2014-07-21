unit uCollections;
 {
  Develop to replace Generic.Collection/ThriftCollection Delphi version less 2010
  luongtphu@gmail.com
  Date:July 20 2014
  Change to replace old uCollections
 }
interface
uses sysutils,variants,classes;

type
TAllValueType=(avtNull,avtEmpty,avtPointer,avtBool,avtInt,avtFloat,
avtString,avtObject,avtIntf);
TThreadProcedure=procedure;
type
TAllValueRec=record
  i:IInterface;
  case TAllValueType of
    avtPointer:(p:Pointer);
    avtBool:(b:Boolean);
    avtInt:(n:Int64);
    avtFloat:(f:double);
    avtString:(s:PAnsiString);
    avtobject:(o:Tobject);

end;
TAllValue=class(TObject)
  private
    fprefree:boolean;
    fvt:TAllValueType;
    fv:TAllValueRec;
    fhash:int64;
  private
    procedure setvalue(v:Variant);overload;
    function getvalue:Variant;
    procedure setvalueobj(v:Tobject);overload;
    function getvalueObj:Tobject;
    procedure setvalueintf(v:IInterface);overload;
    function getvalueIntf:IInterface;
    procedure setvalueptr(v:Pointer);overload;
    function getvaluePtr:Pointer;
  public
    constructor Create;overload;
    constructor Create(v:variant);overload;
    constructor Create(v: Tobject; const prefree:boolean=false);overload;
    constructor Create(v:IInterface);overload;
    constructor Create(v:Pointer);overload;
    destructor Destroy;override;
  public
    function IsEmpty:Boolean;
    function IsNull:Boolean;
    function AsString:string;
    function AsFloat:Double;
    function AsInt:int64;
    function AsObj:TObject;
    function AsIntf:IInterface;
    function AsPointer:Pointer;
  public
    procedure Free;

    property TypeValue:TAllValueType read fvt;
    property Hash:Int64 read fhash;
    property Value:Variant read getvalue write setvalue;
    property ValueObj:Tobject read getvalueobj write setvalueobj;
    property ValueIntf:IInterface read getvalueintf write setvalueintf;
    property ValuePtr:Pointer read getvalueptr write setvalueptr;
end;

  function AllValue_Compare_Default(const Left,Right: TAllValue): Integer;

  function _AllValue(v:variant):TAllValue;overload;
  function _AllValue(v:Tobject):TAllValue;overload;
  function _AllValue(v:IInterface):TAllValue;overload;
  function _AllValue(v:Pointer):TAllValue;overload;

  function HashString32(const S: AnsiString): LongWord;
  function HashString(const S: AnsiString): int64;
type
  TAllValueArray=array of TAllValue;
  TAllValuePair = class
    Key: TAllValue;
    Value: TAllValue;
    constructor Create(const AKey: TAllValue; const AValue: TAllValue);
  end;
  
  function _AllValueArray_Grow(var a:TAllValueArray;const sz:integer=0):TAllValueArray;
  procedure _AllValueArray_Delete(var a:TAllValueArray);
  procedure _AllValueArray_DeleteI(var a:TAllValueArray;const index:integer);



type
  TValueComparisonProc = function(const Left, Right: TAllValue): Integer;

  IuComparerValue = interface
    function Compare(const Left, Right: TAllValue): Integer;
  end;

  TuComparerValue_Default = class(TInterfacedObject, IuComparerValue)
  public
    function Compare(const Left, Right: TAllValue): Integer;
  end;

  IuEqualityComparerValue = interface
    function Equals(const Left, Right: TAllValue): Boolean;
  end;

  TIuEqualityComparerValue_Default = class(TInterfacedObject, IuEqualityComparerValue)
  public
      function Equals(const Left, Right: TAllValue): Boolean;
  end;


  TuComparerValue = class
  public
    class function Default: IuComparerValue;
    class function DefaultEqual: IuEqualityComparerValue;
  end;


type
  TuCollectionNotification = (cnAdded, cnRemoved, cnExtracted);
  TuCollectionNotifyEvent = procedure(Sender: TObject; const Item: TAllValue;
    Action: TCollectionNotification) of object;

type
  TuDictionary=class(TObject)
  private
     fKey:TAllValueArray;
     fValue:TAllValueArray;

    FCount: Integer;
    FComparer: IuEqualityComparerValue;
    FGrowThreshold: Integer;
    procedure Grow;
    procedure Rehash(NewCapPow2: Integer);
    procedure SetCapacity(ACapacity: Integer);
    function GetCapacity: Integer;
    function GetBucketIndex(const Key: TAllValue): Integer;
    function GetItem(const Key: TAllValue): Variant;
    procedure SetItem(const Key: TAllValue; const Value: Variant);
    function GetItemV(const Key: TAllValue): TAllValue;
    procedure SetItemV(const Key: TAllValue; const Value: TAllValue);
    procedure DoAdd(Index: Integer; const Key: TAllValue; const Value: TAllValue);
    procedure DoSetValue(Index: Integer; const Value: TAllValue);
    function DoRemove(const Key: TAllValue; Notification: TuCollectionNotification): TAllValue;
  public
    constructor Create(ACapacity: Integer = 0); overload;
    constructor Create(const AComparer: IuEqualityComparerValue); overload;
    constructor Create(ACapacity: Integer; const AComparer: IuEqualityComparerValue); overload;
    destructor Destroy; override;
    procedure Clear;
    procedure TrimExcess;

    function ContainsKey(const Key: TAllValue): Boolean;
    procedure Add(const Key: TAllValue; const Value: TAllValue);overload;
    procedure Add(const Key: Variant; const Value: TAllValue);overload;
    procedure AddOrSetValue(const Key: TAllValue; const Value: TAllValue);overload;
    procedure AddOrSetValue(const Key: Variant; const Value: TAllValue);overload;
    procedure Remove(const Key: TAllValue);overload;
    procedure Remove(const Key: Variant);overload;

    function ExtractPair(const Key: TAllValue): TAllValuePair;overload;
    function ExtractPair(const Key: Variant): TAllValuePair;overload;
    function GetPair(const index: Cardinal): TAllValuePair;
    procedure Add(const Key: TAllValue;const value:Variant);overload;
    procedure Add(const Key: TAllValue;const value:TObject);overload;
    procedure Add(const Key: TAllValue;const value:IInterface);overload;
    procedure Add(const Key: TAllValue;const value:Pointer);overload;

    procedure Add(const Key: Variant;const value:Variant);overload;
    procedure Add(const Key: Variant;const value:TObject);overload;
    procedure Add(const Key: Variant;const value:IInterface);overload;
    procedure Add(const Key: Variant;const value:Pointer);overload;

    procedure AddOrSetValue(const Key: TAllValue;const value:Variant);overload;
    procedure AddOrSetValue(const Key: TAllValue;const value:TObject);overload;
    procedure AddOrSetValue(const Key: TAllValue;const value:IInterface);overload;
    procedure AddOrSetValue(const Key: TAllValue;const value:Pointer);overload;

    procedure AddOrSetValue(const Key: Variant;const value:Variant);overload;
    procedure AddOrSetValue(const Key: Variant;const value:TObject);overload;
    procedure AddOrSetValue(const Key: Variant;const value:IInterface);overload;
    procedure AddOrSetValue(const Key: Variant;const value:Pointer);overload;

    function AsString(const Key: TAllValue):string;overload;
    function AsFloat(const Key: TAllValue):Double;overload;
    function AsInt(const Key: TAllValue):Integer;overload;
    function AsObj(const Key: TAllValue):TObject;overload;
    function AsIntf(const Key: TAllValue):IInterface;overload;
    function AsPointer(const Key: TAllValue):Pointer;overload;

    function AsString(const Key: Variant):string;overload;
    function AsFloat(const Key: Variant):Double;overload;
    function AsInt(const Key: Variant):Integer;overload;
    function AsObj(const Key: Variant):TObject;overload;
    function AsIntf(const Key: Variant):IInterface;overload;
    function AsPointer(const Key: Variant):Pointer;overload;

    function TryGetValue(const Key: TAllValue; out Value: TAllValue): Boolean;overload;
    function TryGetValueObj(const Key: TAllValue; out Value:TObject ):Boolean;overload;
    function TryGetValueIntf(const Key: TAllValue; out Value:IInterface):Boolean;overload;
    function TryGetValueString(const Key: TAllValue; out Value:string ):Boolean;overload;
    function TryGetValuePointer(const Key: TAllValue; out Value:Pointer ):Boolean;overload;

    function TryGetValue(const Key: Variant; out Value: TAllValue): Boolean;overload;
    function TryGetValueObj(const Key: Variant; out Value:TObject ):Boolean;overload;
    function TryGetValueIntf(const Key: Variant; out Value:IInterface):Boolean;overload;
    function TryGetValueString(const Key: Variant; out Value:string ):Boolean;overload;
    function TryGetValuePointer(const Key: Variant; out Value:Pointer ):Boolean;overload;
  public
    property Count: Integer read FCount;
    property Items[const Key: TAllValue]: TAllValue read GetItemV write SetItemV;
    property Value[const Key: TAllValue]: Variant read GetItem write SetItem;default;
    property Keys:TAllValueArray read fkey;
    property Values:TAllValueArray read fValue;
    property Capacity: Integer read GetCapacity;
  end;

type
  TuStack=class(TObject)
  private
    fValue:TAllValueArray;
    FCount: Integer;
    FGrowThreshold: Integer;
    procedure Grow(const ACount: Integer);
    function GetCapacity: Integer;
    procedure SetCapacity(ACapacity: Integer);
    procedure Rehash(NewCapPow2: Integer);
  public
    constructor Create(Collection: TAllValueArray);
    destructor Destroy; override;
    procedure Clear;
    procedure Push(const Value: TAllValue);overload;
    procedure PushV(const Value: Variant);overload;
    procedure PushO(const Value: TObject);overload;
    procedure PushP(const Value: Pointer);overload;
    procedure PushI(const Value: IInterface);overload;

    function Pop: TAllValue;overload;
    function PopV: Variant;overload;
    function PopO: TObject;overload;
    function PopP: Pointer;overload;
    function PopI: IInterface;overload;
    function Peek: TAllValue;
    function Extract: TAllValue;
    procedure TrimExcess;
    function ToArray: TAllValueArray;
    property Count: Integer read FCount;
    property Capacity: Integer read GetCapacity write SetCapacity;
  end;

type
  TuList=class(TObject)
  private
    fValue:TAllValueArray;
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
    function GetItemV(const Key: Integer): TAllValue;
    procedure SetItemV(const Key: Integer; const Value: TAllValue);
    procedure DoAdd(Index: Integer; const Value: TAllValue);
    procedure DoSetValue(Index: Integer; const Value: TAllValue);
    function DoRemove(const Key: integer; Notification: TuCollectionNotification): TAllValue;
  public
    constructor Create(ACapacity: Integer = 0);
    destructor Destroy; override;
    procedure Clear;
    procedure TrimExcess;
    function IndexOf(Value: TAllValue;const LastIndex:boolean=false): integer;overload;
    function IndexOf(const Value: Variant;const LastIndex:boolean=false): integer;overload;
    function IndexOf(const Value: TObject;const LastIndex:boolean=false): integer;overload;
    function IndexOf(const Value: Pointer;const LastIndex:boolean=false): integer;overload;
    function IndexOf(const Value: IInterface;const LastIndex:boolean=false): integer;overload;

    function LastIndexOf(Value: TAllValue): integer;overload;
    function LastIndexOf(const Value: Variant): integer;overload;
    function LastIndexOf(const Value: TObject): integer;overload;
    function LastIndexOf(const Value: Pointer): integer;overload;
    function LastIndexOf(const Value: IInterface): integer;overload;

    function Contains(Value: TAllValue): boolean;overload;
    function Contains(const Value: Variant): boolean;overload;
    function Contains(const Value: TObject): boolean;overload;
    function Contains(const Value: Pointer): boolean;overload;
    function Contains(const Value: IInterface): boolean;overload;

    procedure Exchange(Index1, Index2: Integer);
    //procedure Move(CurIndex, NewIndex: Integer);
    function First: TAllValue;
    function Last: TAllValue;
    procedure Reverse;
    procedure Sort; overload;
    procedure Sort(const AComparer: IuComparerValue); overload;
    function BinarySearch(const Item: Variant; out Index: Integer): Boolean; overload;
    function BinarySearch(const Item: TObject; out Index: Integer): Boolean; overload;
    function BinarySearch(const Item: IInterface; out Index: Integer): Boolean; overload;
    function BinarySearch(const Item: Pointer; out Index: Integer): Boolean; overload;
    function BinarySearch(const Item: TAllValue; out Index: Integer; const AComparer: IuComparerValue): Boolean; overload;

    procedure Remove(const value:TAllValue;const LastIndex:boolean=false);overload;
    procedure Remove(const Value: Variant;const LastIndex:boolean=false);overload;
    procedure Remove(const Value: TObject;const LastIndex:boolean=false);overload;
    procedure Remove(const Value: Pointer;const LastIndex:boolean=false);overload;
    procedure Remove(const Value: IInterface;const LastIndex:boolean=false);overload;

    procedure Delete(Index: Integer);
    procedure DeleteRange(AIndex, ACount: Integer);
    procedure Add(const Value: TAllValue);overload;
    procedure Add(const value:Variant);overload;
    procedure Add(const value:TObject);overload;
    procedure Add(const value:IInterface);overload;
    procedure Add(const value:Pointer);overload;

    procedure AddRange(const Values: array of TAllValue); overload;
    procedure AddRange(const Values: array of Variant); overload;
    procedure AddRange(const Values: array of IInterface); overload;
    procedure AddRange(const Values: array of Pointer); overload;

    procedure Insert(Index: Integer; const Value: TAllValue);overload;
    procedure Insert(Index: Integer; const Value: Variant);overload;
    procedure Insert(Index: Integer; const Value: IInterface);overload;
    procedure Insert(Index: Integer; const Value: Pointer);overload;

    procedure InsertRange(Index: Integer;const Values: array of TAllValue); overload;
    procedure InsertRange(Index: Integer;const Values: array of Variant); overload;
    procedure InsertRange(Index: Integer;const Values: array of IInterface); overload;
    procedure InsertRange(Index: Integer;const Values: array of Pointer); overload;

    procedure AddOrSetValue(const Key: Integer; const Value: TAllValue);overload;
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
    function ToArray:TAllValueArray;
  public
    property Count: Integer read FCount;
    property Items[const Key: integer]: TAllValue read GetItemV write SetItemV;
    property Value[const Key: integer]: Variant read GetItem write SetItem;default;
    property Values:TAllValueArray read ToArray;
    property Capacity: Integer read GetCapacity;
  end;

type
  IThriftContainer = interface
    ['{40AAF2AA-737F-45C5-B1E0-FCCC99C215D8}']
    function ToString: string;
  end;


type
  IThriftDictionary = interface(IThriftContainer)
    ['{95704BB4-5A0E-41CB-AB2F-43B4522A1168}']
    //function GetEnumerator: TAllValueArrayArray;

    function GetKeys: TAllValueArray;
    function GetValues: TAllValueArray;
    function GetItemI(const Key: TAllValue): Variant;
    procedure SetItemI(const Key: TAllValue; const Value: Variant);
    function GetItem(const Key: Variant): Variant;
    procedure SetItem(const Key: Variant; const Value: Variant);
    function GetItemV(const Key: TAllValue): TAllValue;
    procedure SetItemV(const Key: TAllValue; const Value: TAllValue);

    function GetCount: Integer;

    procedure Add(const Key: TAllValue; const Value: TAllValue);overload;
    procedure Add(const Key: Variant; const Value: TAllValue);overload;
    procedure Remove(const Key: TAllValue);overload;
    procedure Remove(const Key: Variant);overload;
    function ExtractPair(const Key: TAllValue): TAllValuePair;overload;
    function ExtractPair(const Key: Variant): TAllValuePair;overload;
    function GetPair(const index: Cardinal): TAllValuePair;
    procedure Clear;
    procedure TrimExcess;
    function TryGetValue(const Key: TAllValue; out Value: TAllValue): Boolean;overload;
    function TryGetValue(const Key: Variant; out Value: TAllValue): Boolean;overload;
    procedure AddOrSetValue(const Key: TAllValue; const Value: TAllValue);overload;
    procedure AddOrSetValue(const Key: Variant; const Value: TAllValue);overload;
    function ContainsKey(const Key: TAllValue): Boolean;
    function ContainsValue(const Value: TAllValue): Boolean;
    function ToArray: TAllValueArray;
    procedure Add(const Key: TAllValue;const value:Variant);overload;
    procedure Add(const Key: TAllValue;const value:TObject);overload;
    procedure Add(const Key: TAllValue;const value:IInterface);overload;
    procedure Add(const Key: TAllValue;const value:Pointer);overload;

    procedure Add(const Key: Variant;const value:Variant);overload;
    procedure Add(const Key: Variant;const value:TObject);overload;
    procedure Add(const Key: Variant;const value:IInterface);overload;
    procedure Add(const Key: Variant;const value:Pointer);overload;

    procedure AddOrSetValue(const Key: TAllValue;const value:Variant);overload;
    procedure AddOrSetValue(const Key: TAllValue;const value:TObject);overload;
    procedure AddOrSetValue(const Key: TAllValue;const value:IInterface);overload;
    procedure AddOrSetValue(const Key: TAllValue;const value:Pointer);overload;

    procedure AddOrSetValue(const Key: Variant;const value:Variant);overload;
    procedure AddOrSetValue(const Key: Variant;const value:TObject);overload;
    procedure AddOrSetValue(const Key: Variant;const value:IInterface);overload;
    procedure AddOrSetValue(const Key: Variant;const value:Pointer);overload;

    function AsString(const Key: TAllValue):string;overload;
    function AsFloat(const Key: TAllValue):Double;overload;
    function AsInt(const Key: TAllValue):Integer;overload;
    function AsObj(const Key: TAllValue):TObject;overload;
    function AsIntf(const Key: TAllValue):IInterface;overload;
    function AsPointer(const Key: TAllValue):Pointer;overload;

    function AsString(const Key: Variant):string;overload;
    function AsFloat(const Key: Variant):Double;overload;
    function AsInt(const Key: Variant):Integer;overload;
    function AsObj(const Key: Variant):TObject;overload;
    function AsIntf(const Key: Variant):IInterface;overload;
    function AsPointer(const Key: Variant):Pointer;overload;


    function TryGetValueObj(const Key: TAllValue; out Value:TObject ):Boolean;overload;
    function TryGetValueIntf(const Key: TAllValue; out Value:IInterface):Boolean;overload;
    function TryGetValueString(const Key: TAllValue; out Value:string ):Boolean;overload;
    function TryGetValuePointer(const Key: TAllValue; out Value:Pointer ):Boolean;overload;

    function TryGetValueObj(const Key: Variant; out Value:TObject ):Boolean;overload;
    function TryGetValueIntf(const Key: Variant; out Value:IInterface):Boolean;overload;
    function TryGetValueString(const Key: Variant; out Value:string ):Boolean;overload;
    function TryGetValuePointer(const Key: Variant; out Value:Pointer ):Boolean;overload;


    property Items[const Key: TAllValue]: TAllValue read GetItemV write SetItemV;
    property ValueI[const Key: TAllValue]: Variant read GetItemI write SetItemI;
    property Value[const Key: Variant]: Variant read GetItem write SetItem;default;
    property Count: Integer read GetCount;
    property Keys: TAllValueArray read GetKeys;
    property Values: TAllValueArray read GetValues;
  end;

type
  TThriftDictionaryImpl = class( TInterfacedObject, IThriftDictionary)
  private
    FDictionaly : TuDictionary;
  protected
    //function GetEnumerator: TAllValueArray;

    function GetKeys: TAllValueArray;
    function GetValues: TAllValueArray;
    function GetItemI(const Key: TAllValue): Variant;
    procedure SetItemI(const Key: TAllValue; const Value: Variant);
    function GetItem(const Key: Variant): Variant;
    procedure SetItem(const Key: Variant; const Value: Variant);
    function GetItemV(const Key: TAllValue): TAllValue;
    procedure SetItemV(const Key: TAllValue; const Value: TAllValue);

    function GetCount: Integer;

    procedure Add(const Key: TAllValue; const Value: TAllValue);overload;
    procedure Add(const Key: Variant; const Value: TAllValue);overload;
    procedure Remove(const Key: TAllValue);overload;
    procedure Remove(const Key: Variant);overload;
    function ExtractPair(const Key: TAllValue): TAllValuePair;overload;
    function ExtractPair(const Key: Variant): TAllValuePair;overload;
    function GetPair(const index: Cardinal): TAllValuePair;
    procedure Clear;
    procedure TrimExcess;
    function TryGetValue(const Key: TAllValue; out Value: TAllValue): Boolean;overload;
    function TryGetValue(const Key: Variant; out Value: TAllValue): Boolean;overload;
    procedure AddOrSetValue(const Key: TAllValue; const Value: TAllValue);overload;
    procedure AddOrSetValue(const Key: Variant; const Value: TAllValue);overload;
    function ContainsKey(const Key: TAllValue): Boolean;
    function ContainsValue(const Value: TAllValue): Boolean;
    function ToArray: TAllValueArray;

    procedure Add(const Key: TAllValue;const value:Variant);overload;
    procedure Add(const Key: TAllValue;const value:TObject);overload;
    procedure Add(const Key: TAllValue;const value:IInterface);overload;
    procedure Add(const Key: TAllValue;const value:Pointer);overload;

    procedure Add(const Key: Variant;const value:Variant);overload;
    procedure Add(const Key: Variant;const value:TObject);overload;
    procedure Add(const Key: Variant;const value:IInterface);overload;
    procedure Add(const Key: Variant;const value:Pointer);overload;

    procedure AddOrSetValue(const Key: TAllValue;const value:Variant);overload;
    procedure AddOrSetValue(const Key: TAllValue;const value:TObject);overload;
    procedure AddOrSetValue(const Key: TAllValue;const value:IInterface);overload;
    procedure AddOrSetValue(const Key: TAllValue;const value:Pointer);overload;

    procedure AddOrSetValue(const Key: Variant;const value:Variant);overload;
    procedure AddOrSetValue(const Key: Variant;const value:TObject);overload;
    procedure AddOrSetValue(const Key: Variant;const value:IInterface);overload;
    procedure AddOrSetValue(const Key: Variant;const value:Pointer);overload;

    function AsString(const Key: TAllValue):string;overload;
    function AsFloat(const Key: TAllValue):Double;overload;
    function AsInt(const Key: TAllValue):Integer;overload;
    function AsObj(const Key: TAllValue):TObject;overload;
    function AsIntf(const Key: TAllValue):IInterface;overload;
    function AsPointer(const Key: TAllValue):Pointer;overload;

    function AsString(const Key: Variant):string;overload;
    function AsFloat(const Key: Variant):Double;overload;
    function AsInt(const Key: Variant):Integer;overload;
    function AsObj(const Key: Variant):TObject;overload;
    function AsIntf(const Key: Variant):IInterface;overload;
    function AsPointer(const Key: Variant):Pointer;overload;


    function TryGetValueObj(const Key: TAllValue; out Value:TObject ):Boolean;overload;
    function TryGetValueIntf(const Key: TAllValue; out Value:IInterface):Boolean;overload;
    function TryGetValueString(const Key: TAllValue; out Value:string ):Boolean;overload;
    function TryGetValuePointer(const Key: TAllValue; out Value:Pointer ):Boolean;overload;

    function TryGetValueObj(const Key: Variant; out Value:TObject ):Boolean;overload;
    function TryGetValueIntf(const Key: Variant; out Value:IInterface):Boolean;overload;
    function TryGetValueString(const Key: Variant; out Value:string ):Boolean;overload;
    function TryGetValuePointer(const Key: Variant; out Value:Pointer ):Boolean;overload;


    property Items[const Key: TAllValue]: TAllValue read GetItemV write SetItemV;
    property ValueI[const Key: TAllValue]: Variant read GetItemI write SetItemI;
    property Value[const Key: Variant]: Variant read GetItem write SetItem;default;
    property Count: Integer read GetCount;
    property Keys: TAllValueArray read GetKeys;
    property Values: TAllValueArray read GetValues;
    function ToString: string;
  public
    constructor Create(ACapacity: Integer = 0);
    destructor Destroy; override;
  end;
type
  IThriftList = interface(IThriftContainer)
    ['{29BEEE31-9CB4-401B-AA04-5148A75F473B}']
    //function GetEnumerator: TVariantArray;
    function GetCapacity: Integer;
    procedure SetCapacity(Value: Integer);
    function GetCount: Integer;
    procedure SetCount(Value: Integer);
    function GetItem(const Key: Integer): Variant;
    procedure SetItem(const Key: Integer; const Value: Variant);
    function GetItemV(const Key: Integer): TAllValue;
    procedure SetItemV(const Key: Integer; const Value: TAllValue);
    //procedure AddRange(Collection: TEnumerable<T>); overload;
    //procedure InsertRange(Index: Integer; const Collection: TVariantArray); overload;
    //procedure InsertRange(Index: Integer; const Collection: TEnumerable<T>); overload;
    function Extract(const Value: TAllValue): TAllValue;
    procedure Exchange(Index1, Index2: Integer);
    procedure Move(CurIndex, NewIndex: Integer);
    function First: TAllValue;
    function Last: TAllValue;
    procedure Clear;
    function IndexOf(Value: TAllValue;const LastIndex:boolean=false): integer;overload;
    function IndexOf(const Value: Variant;const LastIndex:boolean=false): integer;overload;
    function IndexOf(const Value: TObject;const LastIndex:boolean=false): integer;overload;
    function IndexOf(const Value: Pointer;const LastIndex:boolean=false): integer;overload;
    function IndexOf(const Value: IInterface;const LastIndex:boolean=false): integer;overload;

    function LastIndexOf(Value: TAllValue): integer;overload;
    function LastIndexOf(const Value: Variant): integer;overload;
    function LastIndexOf(const Value: TObject): integer;overload;
    function LastIndexOf(const Value: Pointer): integer;overload;
    function LastIndexOf(const Value: IInterface): integer;overload;

    function Contains(Value: TAllValue): boolean;overload;
    function Contains(const Value: Variant): boolean;overload;
    function Contains(const Value: TObject): boolean;overload;
    function Contains(const Value: Pointer): boolean;overload;
    function Contains(const Value: IInterface): boolean;overload;

    procedure Remove(const value:TAllValue;const LastIndex:boolean=false);overload;
    procedure Remove(const Value: Variant;const LastIndex:boolean=false);overload;
    procedure Remove(const Value: TObject;const LastIndex:boolean=false);overload;
    procedure Remove(const Value: Pointer;const LastIndex:boolean=false);overload;
    procedure Remove(const Value: IInterface;const LastIndex:boolean=false);overload;

    procedure Delete(Index: Integer);
    procedure DeleteRange(AIndex, ACount: Integer);

    procedure Add(const Value: TAllValue);overload;
    procedure Add(const value:Variant);overload;
    procedure Add(const value:TObject);overload;
    procedure Add(const value:IInterface);overload;
    procedure Add(const value:Pointer);overload;
    procedure AddRange(const Values: array of TAllValue); overload;
    procedure AddRange(const Values: array of Variant); overload;
    procedure AddRange(const Values: array of IInterface); overload;
    procedure AddRange(const Values: array of Pointer); overload;

    procedure Insert(Index: Integer; const Value: TAllValue);overload;
    procedure Insert(Index: Integer; const Value: Variant);overload;
    procedure Insert(Index: Integer; const Value: IInterface);overload;
    procedure Insert(Index: Integer; const Value: Pointer);overload;

    procedure InsertRange(Index: Integer;const Values: array of TAllValue); overload;
    procedure InsertRange(Index: Integer;const Values: array of Variant); overload;
    procedure InsertRange(Index: Integer;const Values: array of IInterface); overload;
    procedure InsertRange(Index: Integer;const Values: array of Pointer); overload;
    

    procedure AddOrSetValue(const Key: Integer; const Value: TAllValue);overload;
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
    procedure Sort(const AComparer: IuComparerValue); overload;
    function BinarySearch(const Item: Variant; out Index: Integer): Boolean; overload;
    function BinarySearch(const Item: TObject; out Index: Integer): Boolean; overload;
    function BinarySearch(const Item: IInterface; out Index: Integer): Boolean; overload;
    function BinarySearch(const Item: Pointer; out Index: Integer): Boolean; overload;
    function BinarySearch(const Item: TAllValue; out Index: Integer; const AComparer: IuComparerValue): Boolean; overload;

    procedure TrimExcess;
    function ToArray: TAllValueArray;
    property Capacity: Integer read GetCapacity write SetCapacity;
    property Count: Integer read GetCount write SetCount;
    property Items[const Key: integer]: TAllValue read GetItemV write SetItemV;
    property Value[const Key: integer]: Variant read GetItem write SetItem;default;
    property Values:TAllValueArray read ToArray;
  end;

  TThriftListImpl = class( TInterfacedObject, IThriftList)
    private
    FList : TuList;
    protected
    //function GetEnumerator: TVariantArray;
    function GetCapacity: Integer;
    procedure SetCapacity(Value: Integer);
    function GetCount: Integer;
    procedure SetCount(Value: Integer);
    function GetItem(const Key: Integer): Variant;
    procedure SetItem(const Key: Integer; const Value: Variant);
    function GetItemV(const Key: Integer): TAllValue;
    procedure SetItemV(const Key: Integer; const Value: TAllValue);
    //procedure AddRange(Collection: TEnumerable<T>); overload;
    //procedure InsertRange(Index: Integer; const Values: array of TAllValue); overload;
    //procedure InsertRange(Index: Integer; const Collection: TVariantArray); overload;
    //procedure InsertRange(Index: Integer; const Collection: TEnumerable<T>); overload;
    function Extract(const Value: TAllValue): TAllValue;
    procedure Exchange(Index1, Index2: Integer);
    procedure Move(CurIndex, NewIndex: Integer);
    function First: TAllValue;
    function Last: TAllValue;
    procedure Clear;
    function IndexOf(Value: TAllValue;const LastIndex:boolean=false): integer;overload;
    function IndexOf(const Value: Variant;const LastIndex:boolean=false): integer;overload;
    function IndexOf(const Value: TObject;const LastIndex:boolean=false): integer;overload;
    function IndexOf(const Value: Pointer;const LastIndex:boolean=false): integer;overload;
    function IndexOf(const Value: IInterface;const LastIndex:boolean=false): integer;overload;

    function LastIndexOf(Value: TAllValue): integer;overload;
    function LastIndexOf(const Value: Variant): integer;overload;
    function LastIndexOf(const Value: TObject): integer;overload;
    function LastIndexOf(const Value: Pointer): integer;overload;
    function LastIndexOf(const Value: IInterface): integer;overload;

    function Contains(Value: TAllValue): boolean;overload;
    function Contains(const Value: Variant): boolean;overload;
    function Contains(const Value: TObject): boolean;overload;
    function Contains(const Value: Pointer): boolean;overload;
    function Contains(const Value: IInterface): boolean;overload;

    procedure Remove(const value:TAllValue;const LastIndex:boolean=false);overload;
    procedure Remove(const Value: Variant;const LastIndex:boolean=false);overload;
    procedure Remove(const Value: TObject;const LastIndex:boolean=false);overload;
    procedure Remove(const Value: Pointer;const LastIndex:boolean=false);overload;
    procedure Remove(const Value: IInterface;const LastIndex:boolean=false);overload;

    procedure Delete(Index: Integer);
    procedure DeleteRange(AIndex, ACount: Integer);

    procedure Add(const Value: TAllValue);overload;
    procedure Add(const value:Variant);overload;
    procedure Add(const value:TObject);overload;
    procedure Add(const value:IInterface);overload;
    procedure Add(const value:Pointer);overload;
    procedure AddRange(const Values: array of TAllValue); overload;
    procedure AddRange(const Values: array of Variant); overload;
    procedure AddRange(const Values: array of IInterface); overload;
    procedure AddRange(const Values: array of Pointer); overload;

    procedure Insert(Index: Integer; const Value: TAllValue);overload;
    procedure Insert(Index: Integer; const Value: Variant);overload;
    procedure Insert(Index: Integer; const Value: IInterface);overload;
    procedure Insert(Index: Integer; const Value: Pointer);overload;

    procedure InsertRange(Index: Integer;const Values: array of TAllValue); overload;
    procedure InsertRange(Index: Integer;const Values: array of Variant); overload;
    procedure InsertRange(Index: Integer;const Values: array of IInterface); overload;
    procedure InsertRange(Index: Integer;const Values: array of Pointer); overload;


    procedure AddOrSetValue(const Key: Integer; const Value: TAllValue);overload;
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
    procedure Sort(const AComparer: IuComparerValue); overload;
    function BinarySearch(const Item: Variant; out Index: Integer): Boolean; overload;
    function BinarySearch(const Item: TObject; out Index: Integer): Boolean; overload;
    function BinarySearch(const Item: IInterface; out Index: Integer): Boolean; overload;
    function BinarySearch(const Item: Pointer; out Index: Integer): Boolean; overload;
    function BinarySearch(const Item: TAllValue; out Index: Integer; const AComparer: IuComparerValue): Boolean; overload;


    procedure TrimExcess;
    function ToArray: TAllValueArray;
    property Capacity: Integer read GetCapacity write SetCapacity;
    property Count: Integer read GetCount write SetCount;
    property Items[const Key: integer]: TAllValue read GetItemV write SetItemV;
    property Value[const Key: integer]: Variant read GetItem write SetItem;default;
    property Values:TAllValueArray read ToArray;
    function ToString: string;
  public
    constructor Create(ACapacity: Integer = 0);
    destructor Destroy; override;
  end;

  IHashSet = interface(IThriftContainer)
    ['{F5ECAFF0-179F-4312-8B67-044DD79DAD0F}']
    function GetItem(const Key: Integer): Variant;
    procedure SetItem(const Key: Integer; const Value: Variant);
    function GetItemV(const Key: Integer): TAllValue;
    procedure SetItemV(const Key: Integer; const Value: TAllValue);
    function GetIsReadOnly: Boolean;
    function GetCount: Integer;
    property Count: Integer read GetCount;
    property IsReadOnly: Boolean read GetIsReadOnly;
    procedure Add( const item: TAllValue);overload;
    procedure Add(const value:Variant);overload;
    procedure Add(const value:TObject);overload;
    procedure Add(const value:IInterface);overload;
    procedure Add(const value:Pointer);overload;    
    procedure Clear;
    function Contains( const item: TAllValue): Boolean;
    procedure CopyTo(var A: TAllValueArray; arrayIndex: Integer);
    function Remove( const item: TAllValue ): Boolean;
    property Items[const Key: integer]: TAllValue read GetItemV write SetItemV;
    property Value[const Key: integer]: Variant read GetItem write SetItem;default;    
  end;

  THashSetImpl = class( TInterfacedObject, IHashSet)
  private
    FList:IThriftList;
    FIsReadOnly: Boolean;
    function GetItem(const Key: Integer): Variant;
    procedure SetItem(const Key: Integer; const Value: Variant);
    function GetItemV(const Key: Integer): TAllValue;
    procedure SetItemV(const Key: Integer; const Value: TAllValue);

  protected
    //function GetEnumerator: TVariantArray;
    function GetIsReadOnly: Boolean;
    function GetCount: Integer;
    property Count: Integer read GetCount;
    property IsReadOnly: Boolean read GetIsReadOnly;
    procedure Add( const item: TAllValue);overload;
    procedure Add(const value:Variant);overload;
    procedure Add(const value:TObject);overload;
    procedure Add(const value:IInterface);overload;
    procedure Add(const value:Pointer);overload;
    procedure Clear;
    function Contains( const item: TAllValue): Boolean;
    procedure CopyTo(var A: TAllValueArray; arrayIndex: Integer);
    property Items[const Key: integer]: TAllValue read GetItemV write SetItemV;
    property Value[const Key: integer]: Variant read GetItem write SetItem;default;

    function Remove( const item: TAllValue ): Boolean;
    function ToString: string;
  public
    constructor Create;

  end;


procedure Array_AllValue_QuickSort(var Values: array of TAllValue; const Comparer: IuComparerValue;L, R: Integer);overload;
procedure Array_AllValue_QuickSort(var Values: array of TAllValue; L, R: Integer);overload;
procedure Array_AllValue_QuickSort(var Values: array of TAllValue);overload;

procedure Array_AllValue_Sort(var Values: array of TAllValue; const Comparer: IuComparerValue;index, Count: Integer);overload;
procedure Array_AllValue_Sort(var Values: array of TAllValue; index, Count: Integer);overload;


function Array_AllValue_BinarySearch(const Values: array of TAllValue; const Item: TAllValue;
  out FoundIndex: Integer; const Comparer: IuComparerValue; Index,
  Count: Integer): Boolean;overload;
function Array_AllValue_BinarySearch(const Values: array of TAllValue; const Item: TAllValue;
  out FoundIndex: Integer; const Comparer: IuComparerValue): Boolean;overload;
function Array_AllValue_BinarySearch(const Values: array of TAllValue; const Item: TAllValue;
  out FoundIndex: Integer): Boolean;overload;


implementation

{function using to compare}
function AllValue_Compare_Default(const Left,
  Right: TAllValue): Integer;
var
p1,p2:UInt64;
begin
  result:=0;
  if (Left.TypeValue=Right.TypeValue) then
  begin
    if Left.TypeValue=avtString then
      result:=StrComp(pchar(VarToStr(Left.Value)),pchar(VarToStr(Right.Value)))
    else
    begin
      if (Left.Hash=Right.Hash) then result:=0
      else if (Left.Hash<Right.Hash) then result:=-1
      else result:=1;
    end;
  end
  else
  begin
    result:=0;
  end;
end;

function _AllValue(v:variant):TAllValue;
begin
  result:=TAllValue.Create(v);
end;
function _AllValue(v:Tobject):TAllValue;
begin
  result:=TAllValue.Create(v);
end;
function _AllValue(v:IInterface):TAllValue;
begin
  result:=TAllValue.Create(v);
end;
function _AllValue(v:Pointer):TAllValue;
begin
  result:=TAllValue.Create(v);
end;


function HashString32(const S: AnsiString): LongWord;
const Seed: LongWord=$9747b28c;
var
    h: LongWord;
    len: LongWord;
    k: LongWord;
    data: Integer;
const
    // 'm' and 'r' are mixing constants generated offline.
    // They're not really 'magic', they just happen to work well.
    m = $5bd1e995;
    r = 24;
begin
    len := Length(S);

    //The default seed, $9747b28c, is from the original C library

    // Initialize the hash to a 'random' value
    h := seed xor len;

    // Mix 4 bytes at a time into the hash
    data := 1;

    while(len >= 4) do
    begin
        k := PLongWord(@S[data])^;

        k := k*m;
        k := k xor (k shr r);
        k := k* m;

        h := h*m;
        h := h xor k;

        data := data+4;
        len := len-4;
    end;

    {   Handle the last few bytes of the input array
            S: ... $69 $18 $2f
    }
    Assert(len <= 3);
    if len = 3 then
        h := h xor (LongWord(s[data+2]) shl 16);
    if len >= 2 then
        h := h xor (LongWord(s[data+1]) shl 8);
    if len >= 1 then
    begin
        h := h xor (LongWord(s[data]));
        h := h * m;
    end;
    // Do a few final mixes of the hash to ensure the last few
    // bytes are well-incorporated.
    h := h xor (h shr 13);
    h := h * m;
    h := h xor (h shr 15);

    Result := h;
end;
function HashString(const S: AnsiString): int64;
const
mc:array[0..7] of byte=($AA,$55,$2A,$A2,$B3,$2C,$33,$7E);
var
s1:AnsiString;
i,n:integer;
r1,r2:LongWord;
begin
  n:=length(s);
  for i := 1 to n do
  begin
    s1:=chr(ord(s[i]) xor mc[i mod 8]);
  end;
  r1:=HashString32(s);
  r2:=HashString32(s1);
  Result:=r1;
  Result:=(Result shl 32) or r2;
end;

function _AllValueArray_Grow(var a:TAllValueArray;const sz:integer):TAllValueArray;
var
i,nnew,nold:integer;
an:TAllValueArray;
begin
  nold:=length(a);
  nnew:=sz;
  if (nnew<=0)  then
  begin
    if (nold=0) then
      nnew:=64;
  end;
  SetLength(an, nnew);
  for i := 0 to nold - 1 do
  begin
    an[i]:=a[i];
  end;
  SetLength(a, 0);
  result:=an;
end;
procedure _AllValueArray_Delete(var a:TAllValueArray);
var
i,nold:integer;
begin
  nold:=length(a);
  for i := 0 to nold - 1 do
  begin
  if (a[i]<>nil) then
    if (assigned(a[i])) then
    begin
      a[i].Free;
      a[i]:=nil;
    end;
  end;
  setlength(a,0);
end;
procedure _AllValueArray_DeleteI(var a:TAllValueArray;const index:integer);
var
i,nold:integer;
v:TAllValue;
begin
  nold:=length(a);
  v:=a[index];
  if (index < 0) or (index>=nold) then  Exit;
  for i := index+1 to nold - 1 do
  begin
    a[i-1]:=a[i];
  end;
  //v.Free;
end;
{ TAllValue }
constructor TAllValue.Create;
begin
  fhash:=0;
  fvt:=avtNull;
end;
constructor TAllValue.Create(v: variant);
begin
  setvalue(v);
end;

function TAllValue.AsFloat: Double;
begin
  result:=getvalue;
end;

function TAllValue.AsInt: int64;
begin
  result:=getvalue;
end;

function TAllValue.AsIntf: IInterface;
begin
  result:=getvalueIntf;
end;

function TAllValue.AsObj: TObject;
begin
  result:=getvalueObj;
end;

function TAllValue.AsPointer: Pointer;
begin
  result:=getvaluePtr;
end;

function TAllValue.AsString: string;
begin
  result:=getvalue;
end;

constructor TAllValue.Create(v: Tobject;const prefree:boolean);
begin
  fprefree:=prefree;
  setvalueobj(v);
end;


constructor TAllValue.Create(v: Pointer);
begin
  setvalueptr(v);
end;
constructor TAllValue.Create(v: IInterface);
begin
  setvalueintf(v);
end;

destructor TAllValue.Destroy;
begin
  Free;
end;

procedure TAllValue.Free;
begin
  if (fvt=avtString) then
  begin
    DisposeStr(fv.s);
  end
  else if (fvt=avtObject) then
  begin
    if fprefree then fv.o.Free;
  end;
  

end;

function TAllValue.getvalue: Variant;
begin
  result:=vaNull;
  case fvt of
  avtBool:result:=fv.b;
  avtFloat:result:=fv.f;
  avtInt:result:=fv.n;
  avtString:if (fv.s<>nil) then result:=fv.s^;
  end;
end;

function TAllValue.getvalueIntf: IInterface;
begin
  if (fvt=avtIntf) and (fv.i<>nil) then
    result:=IInterface(fv.i);
end;

function TAllValue.getvalueObj: Tobject;
begin
  if (fvt=avtObject) and (assigned(fv.o)) then
    result:=fv.o;

end;

function TAllValue.getvaluePtr: Pointer;
begin
  result:=fv.p;
end;

function TAllValue.IsEmpty: Boolean;
begin
  result:=(fvt=avtEmpty);
end;

function TAllValue.IsNull: Boolean;
begin
  result:=(fvt=avtNull);
end;

procedure TAllValue.setvalue(v: Variant);
var
vt:Word;
begin
  fvt:=avtNull;
  vt:=VarType(v);
  case vt of
  varByte,varWord,varLongWord,varShortInt,varSmallint,varInteger,varInt64:begin
    fvt:=avtInt;
    fv.n:=v;
    fhash:=v;
  end;
  varSingle,varDouble,varCurrency,varDate:begin
    fvt:=avtFloat;
    fv.f:=v;
    fhash:=v;    
  end;
  varBoolean:begin
    fvt:=avtBool;
    fv.b:=v;
    fhash:=v;
  end;
  varString:begin
    fvt:=avtString;
    if (fv.s<>nil) then
      DisposeStr(fv.s);
    fv.s:=NewStr(v);
    fhash:=HashString(v);
  end;
  end;
end;

procedure TAllValue.setvalueintf(v: IInterface);
begin
  fvt:=avtIntf;
  fv.i:=v;
  fhash:=int64(Pointer(fv.i));
end;

procedure TAllValue.setvalueobj(v: Tobject);
begin
  fvt:=avtObject;
  fv.o:=v;
  fhash:=int64(Pointer(v));
end;

procedure TAllValue.setvalueptr(v: Pointer);
begin
  fvt:=avtPointer;
  fv.p:=v;
  fhash:=int64(Pointer(v));
end;

{ TAllValuePair }

constructor TAllValuePair.Create(const AKey, AValue: TAllValue);
begin
  Key := AKey;
  Value := AValue;
end;

//{Functions Utils}
procedure Array_AllValue_QuickSort(var Values: array of TAllValue; const Comparer: IuComparerValue;
  L, R: Integer);
var
  I, J: Integer;
  pivot, temp: TAllValue;
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

procedure Array_AllValue_QuickSort(var Values: array of TAllValue; L, R: Integer);
begin
  Array_AllValue_QuickSort(Values,TuComparerValue.Default,L, R);
end;

procedure Array_AllValue_QuickSort(var Values: array of TAllValue);
begin
  Array_AllValue_QuickSort(Values,TuComparerValue.Default,low(Values), High(Values));
end;

procedure Array_AllValue_Sort(var Values: array of TAllValue; const Comparer: IuComparerValue;index, Count: Integer);
begin
  if (Index < Low(Values)) or ((Index > High(Values)) and (Count > 0))
    or (Index + Count - 1 > High(Values)) or (Count < 0)
    or (Index + Count < 0) then
    raise EOutOfMemory.Create('Out of Memory range');
  if Count <= 1 then
    Exit;
  Array_AllValue_QuickSort(Values,Comparer,Index, Index + Count - 1);
end;

procedure Array_AllValue_Sort(var Values: array of TAllValue; index, Count: Integer);
begin
  Array_AllValue_Sort(Values,TuComparerValue.Default,index, Count);
end;



function Array_AllValue_BinarySearch(const Values: array of TAllValue; const Item: TAllValue;
  out FoundIndex: Integer; const Comparer: IuComparerValue; Index,
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

function Array_AllValue_BinarySearch(const Values: array of TAllValue; const Item: TAllValue;
  out FoundIndex: Integer; const Comparer: IuComparerValue): Boolean;
begin
  Result := Array_AllValue_BinarySearch(Values, Item, FoundIndex, Comparer,
    Low(Values), Length(Values));
end;

function Array_AllValue_BinarySearch(const Values: array of TAllValue; const Item: TAllValue;
  out FoundIndex: Integer): Boolean;
begin
  Result := Array_AllValue_BinarySearch(Values, Item, FoundIndex, TuComparerValue.Default,
    Low(Values), Length(Values));
end;


{ TThriftDictionary_V_VImpl }

procedure TThriftDictionaryImpl.Add(const Key: TAllValue;
  const Value: TAllValue);
begin
  FDictionaly.Add(Key,Value);
end;

procedure TThriftDictionaryImpl.AddOrSetValue(const Key: TAllValue;
  const Value: TAllValue);
begin
  FDictionaly.AddOrSetValue(key,value);
end;

procedure TThriftDictionaryImpl.AddOrSetValue(const Key: TAllValue;
  const value: TObject);
begin
  FDictionaly.AddOrSetValue(Key,value);
end;

procedure TThriftDictionaryImpl.AddOrSetValue(const Key: TAllValue;
  const value: IInterface);
begin
  FDictionaly.AddOrSetValue(Key,value);
end;

procedure TThriftDictionaryImpl.AddOrSetValue(const Key: TAllValue;
  const value: Pointer);
begin
  FDictionaly.AddOrSetValue(Key,value);
end;

procedure TThriftDictionaryImpl.AddOrSetValue(const Key: TAllValue;
  const value: Variant);
begin
  FDictionaly.AddOrSetValue(Key,value);
end;

procedure TThriftDictionaryImpl.Clear;
begin
  FDictionaly.Clear;
end;

function TThriftDictionaryImpl.ContainsKey(const Key: TAllValue): Boolean;
begin
  result:=FDictionaly.ContainsKey(Key);
end;

function TThriftDictionaryImpl.ContainsValue(
  const Value: TAllValue): Boolean;
begin

end;

constructor TThriftDictionaryImpl.Create(ACapacity: Integer);
begin
  FDictionaly := TuDictionary.Create( ACapacity );
end;

destructor TThriftDictionaryImpl.Destroy;
begin
  FDictionaly.Free;
  inherited;
end;

function TThriftDictionaryImpl.ExtractPair(
  const Key: Variant): TAllValuePair;
begin
  result:=FDictionaly.ExtractPair(Key);
end;

function TThriftDictionaryImpl.ExtractPair(
  const Key: TAllValue): TAllValuePair;
begin
  result:=FDictionaly.ExtractPair(Key);
end;

function TThriftDictionaryImpl.GetCount: Integer;
begin
  result:=FDictionaly.Count;
end;


function TThriftDictionaryImpl.GetItem(const Key: Variant): Variant;
begin
  result:=FDictionaly.GetItem(_AllValue(Key));
end;

function TThriftDictionaryImpl.GetItemI(
  const Key: TAllValue): Variant;
begin
  result:=FDictionaly.GetItem(Key);
end;

function TThriftDictionaryImpl.GetItemV(
  const Key: TAllValue): TAllValue;
begin
  FDictionaly.GetItemV(Key);
end;

function TThriftDictionaryImpl.GetKeys: TAllValueArray;
begin
  result:=FDictionaly.Keys;
end;

function TThriftDictionaryImpl.GetPair(const index: Cardinal): TAllValuePair;
begin
  result:=FDictionaly.GetPair(index);
end;

function TThriftDictionaryImpl.GetValues: TAllValueArray;
begin
  result:=FDictionaly.Values;
end;

procedure TThriftDictionaryImpl.Remove(const Key: Variant);
begin
  FDictionaly.Remove(Key);
end;

procedure TThriftDictionaryImpl.Remove(const Key: TAllValue);
begin
  FDictionaly.Remove(Key);
end;

procedure TThriftDictionaryImpl.SetItem(const Key, Value: Variant);
begin
  FDictionaly.SetItem(_AllValue(Key),Value);
end;

procedure TThriftDictionaryImpl.SetItemI(const Key: TAllValue;
  const Value: Variant);
begin
  FDictionaly.SetItem(Key,Value);
end;

procedure TThriftDictionaryImpl.SetItemV(const Key: TAllValue;
  const Value: TAllValue);
begin
  FDictionaly.SetItemV(Key,Value);
end;

function TThriftDictionaryImpl.ToArray: TAllValueArray;
begin

end;

function TThriftDictionaryImpl.ToString: string;
begin

end;

procedure TThriftDictionaryImpl.TrimExcess;
begin
  FDictionaly.TrimExcess;
end;

function TThriftDictionaryImpl.TryGetValue(const Key: TAllValue;
  out Value: TAllValue): Boolean;
begin
  result:=FDictionaly.TryGetValue(Key,value);
end;

function TThriftDictionaryImpl.TryGetValue(const Key: Variant;
  out Value: TAllValue): Boolean;
begin
  result:=FDictionaly.TryGetValue(_AllValue(Key),value);
end;

function TThriftDictionaryImpl.TryGetValueIntf(const Key: Variant;
  out Value: IInterface): Boolean;
begin
  result:=FDictionaly.TryGetValueIntf(Key,value);
end;

procedure TThriftDictionaryImpl.Add(const Key: TAllValue;
  const value: IInterface);
begin
  FDictionaly.Add(Key,value);
end;

procedure TThriftDictionaryImpl.Add(const Key: TAllValue;
  const value: TObject);
begin
  FDictionaly.Add(Key,value);
end;

procedure TThriftDictionaryImpl.Add(const Key: TAllValue;
  const value: Variant);
begin
  FDictionaly.Add(Key,value);
end;

procedure TThriftDictionaryImpl.Add(const Key: TAllValue;
  const value: Pointer);
begin
  FDictionaly.Add(Key,value);
end;

function TThriftDictionaryImpl.AsFloat(const Key: TAllValue): Double;
begin
  result:=FDictionaly.AsFloat(Key);
end;

function TThriftDictionaryImpl.AsInt(const Key: TAllValue): Integer;
begin
  result:=FDictionaly.AsInt(Key);
end;

function TThriftDictionaryImpl.AsIntf(const Key: TAllValue): IInterface;
begin
  result:=FDictionaly.AsIntf(Key);
end;

function TThriftDictionaryImpl.AsObj(const Key: TAllValue): TObject;
begin
  result:=FDictionaly.AsObj(Key);
end;

function TThriftDictionaryImpl.AsPointer(const Key: TAllValue): Pointer;
begin
  result:=FDictionaly.AsPointer(Key);
end;

function TThriftDictionaryImpl.AsString(const Key: TAllValue): string;
begin
  result:=FDictionaly.AsString(Key);
end;

function TThriftDictionaryImpl.TryGetValueIntf(const Key: TAllValue;
  out Value: IInterface): Boolean;
begin
  result:=FDictionaly.TryGetValueIntf(Key,value);
end;

function TThriftDictionaryImpl.TryGetValueObj(const Key: TAllValue;
  out Value: TObject): Boolean;
begin
  result:=FDictionaly.TryGetValueObj(Key,value);
end;

function TThriftDictionaryImpl.TryGetValuePointer(const Key: TAllValue;
  out Value: Pointer): Boolean;
begin
  result:=FDictionaly.TryGetValuePointer(Key,value);
end;

function TThriftDictionaryImpl.TryGetValueString(const Key: TAllValue;
  out Value: string): Boolean;
begin
  result:=FDictionaly.TryGetValueString(Key,value);
end;

procedure TThriftDictionaryImpl.Add(const Key: Variant;
  const value: IInterface);
begin
  FDictionaly.Add(Key,value);
end;

procedure TThriftDictionaryImpl.Add(const Key: Variant;
  const value: TObject);
begin
  FDictionaly.Add(Key,value);
end;

procedure TThriftDictionaryImpl.Add(const Key, value: Variant);
begin
  FDictionaly.Add(Key,value);
end;

procedure TThriftDictionaryImpl.Add(const Key: Variant;
  const value: Pointer);
begin
  FDictionaly.Add(Key,value);
end;

procedure TThriftDictionaryImpl.Add(const Key: Variant;
  const Value: TAllValue);
begin
  FDictionaly.Add(_AllValue(Key),Value);
end;

procedure TThriftDictionaryImpl.AddOrSetValue(const Key: Variant;
  const value: Pointer);
begin
  FDictionaly.AddOrSetValue(Key,value);
end;

procedure TThriftDictionaryImpl.AddOrSetValue(const Key: Variant;
  const Value: TAllValue);
begin
  FDictionaly.AddOrSetValue(_AllValue(key),value);
end;

procedure TThriftDictionaryImpl.AddOrSetValue(const Key, value: Variant);
begin
  FDictionaly.AddOrSetValue(Key,value);
end;

procedure TThriftDictionaryImpl.AddOrSetValue(const Key: Variant;
  const value: TObject);
begin
  FDictionaly.AddOrSetValue(Key,value);
end;

procedure TThriftDictionaryImpl.AddOrSetValue(const Key: Variant;
  const value: IInterface);
begin
  FDictionaly.AddOrSetValue(Key,value);
end;

function TThriftDictionaryImpl.AsFloat(const Key: Variant): Double;
begin
  result:=FDictionaly.AsFloat(Key);
end;

function TThriftDictionaryImpl.AsInt(const Key: Variant): Integer;
begin
  result:=FDictionaly.AsInt(Key);
end;

function TThriftDictionaryImpl.AsIntf(const Key: Variant): IInterface;
begin
  result:=FDictionaly.AsIntf(Key);
end;

function TThriftDictionaryImpl.AsObj(const Key: Variant): TObject;
begin
  result:=FDictionaly.AsObj(Key);
end;

function TThriftDictionaryImpl.AsPointer(const Key: Variant): Pointer;
begin
  result:=FDictionaly.AsPointer(Key);
end;

function TThriftDictionaryImpl.AsString(const Key: Variant): string;
begin
  result:=FDictionaly.AsString(Key);
end;

function TThriftDictionaryImpl.TryGetValueObj(const Key: Variant;
  out Value: TObject): Boolean;
begin
  result:=FDictionaly.TryGetValueObj(Key,value);
end;

function TThriftDictionaryImpl.TryGetValuePointer(const Key: Variant;
  out Value: Pointer): Boolean;
begin
  result:=FDictionaly.TryGetValuePointer(Key,value);
end;

function TThriftDictionaryImpl.TryGetValueString(const Key: Variant;
  out Value: string): Boolean;
begin
  result:=FDictionaly.TryGetValueString(Key,value);
end;

{ THashSet_VImpl }

procedure THashSetImpl.Add(const item: TAllValue);
begin
  if not Contains(item) then
  begin
    FList.Add( item);
  end;
end;

procedure THashSetImpl.Add(const value: TObject);
begin
  Flist.Add(value);
end;

procedure THashSetImpl.Add(const value: Variant);
begin
  Flist.Add(value);
end;

procedure THashSetImpl.Add(const value: Pointer);
begin
  Flist.Add(value);
end;

procedure THashSetImpl.Add(const value: IInterface);
begin
  Flist.Add(value);
end;

procedure THashSetImpl.Clear;
begin
  Flist.Clear;
end;

function THashSetImpl.Contains(const item: TAllValue): Boolean;
begin
  result:=Flist.Contains(item);
end;

procedure THashSetImpl.CopyTo(var A: TAllValueArray; arrayIndex: Integer);
var
n,i:integer;
begin
  n:=FList.Count;
  for i := 0 to n - 1 do
  begin
   A[i+arrayIndex]:=FList.Items[i];
  end;
end;

constructor THashSetImpl.Create;
begin
    FList :=TThriftListImpl.Create;
end;

function THashSetImpl.GetCount: Integer;
begin
  result:=FList.Count;
end;


function THashSetImpl.GetIsReadOnly: Boolean;
begin

end;

function THashSetImpl.GetItem(const Key: Integer): Variant;
begin
  result:=Flist.GetItem(Key);
end;

function THashSetImpl.GetItemV(const Key: Integer): TAllValue;
begin
  result:=Flist.GetItemV(Key);
end;

function THashSetImpl.Remove(const item: TAllValue): Boolean;
begin
  FList.Remove(item);
  Result := not Contains(item);
end;

procedure THashSetImpl.SetItem(const Key: Integer; const Value: Variant);
begin
  Flist.SetItem(Key,Value);
end;

procedure THashSetImpl.SetItemV(const Key: Integer;
  const Value: TAllValue);
begin
  Flist.SetItemV(Key,Value);
end;

function THashSetImpl.ToString: string;
begin

end;

{ TThriftList_VImpl }


function TThriftListImpl.BinarySearch(const Item: TObject;
  out Index: Integer): Boolean;
begin
  result:=FList.BinarySearch(Item,Index);
end;

function TThriftListImpl.BinarySearch(const Item: Variant;
  out Index: Integer): Boolean;
begin
  result:=FList.BinarySearch(Item,Index);
end;

function TThriftListImpl.BinarySearch(const Item: IInterface;
  out Index: Integer): Boolean;
begin
  result:=FList.BinarySearch(Item,Index);
end;

procedure TThriftListImpl.Add(const value: TObject);
begin
  FList.Add(Value);
end;

procedure TThriftListImpl.Add(const value: Variant);
begin
  FList.Add(Value);
end;

procedure TThriftListImpl.Add(const Value: TAllValue);
begin
  FList.Add(Value);
end;

procedure TThriftListImpl.Add(const value: Pointer);
begin
  FList.Add(Value);
end;

procedure TThriftListImpl.Add(const value: IInterface);
begin
  FList.Add(Value);
end;

procedure TThriftListImpl.AddOrSetValue(const Key: Integer;
  const value: IInterface);
begin
  FList.AddOrSetValue(Key,Value);
end;

procedure TThriftListImpl.AddOrSetValue(const Key: Integer;
  const value: Pointer);
begin
  FList.AddOrSetValue(Key,Value);
end;

procedure TThriftListImpl.AddRange(const Values: array of Variant);
begin
  FList.AddRange(Values);
end;

procedure TThriftListImpl.AddRange(const Values: array of TAllValue);
begin
  FList.AddRange(Values);
end;

procedure TThriftListImpl.AddRange(const Values: array of Pointer);
begin
  FList.AddRange(Values);
end;

procedure TThriftListImpl.AddRange(const Values: array of IInterface);
begin
  FList.AddRange(Values);
end;

procedure TThriftListImpl.AddOrSetValue(const Key: Integer;
  const Value: TAllValue);
begin
  FList.AddOrSetValue(Key,Value);
end;

procedure TThriftListImpl.AddOrSetValue(const Key: Integer;
  const value: Variant);
begin
  FList.AddOrSetValue(Key,Value);
end;

procedure TThriftListImpl.AddOrSetValue(const Key: Integer;
  const value: TObject);
begin
  FList.AddOrSetValue(Key,Value);
end;

function TThriftListImpl.AsFloat(const Key: Integer): Double;
begin
  result:=FList.AsFloat(Key);
end;

function TThriftListImpl.AsInt(const Key: Integer): Integer;
begin
  result:=FList.AsInt(Key);
end;

function TThriftListImpl.AsIntf(const Key: Integer): IInterface;
begin
  result:=FList.AsIntf(Key);
end;

function TThriftListImpl.AsObj(const Key: Integer): TObject;
begin
  result:=FList.AsObj(Key);
end;

function TThriftListImpl.AsPointer(const Key: Integer): Pointer;
begin
  result:=FList.AsPointer(Key);
end;

function TThriftListImpl.AsString(const Key: Integer): string;
begin
  result:=FList.AsString(Key);
end;

function TThriftListImpl.BinarySearch(const Item: TAllValue;
  out Index: Integer; const AComparer: IuComparerValue): Boolean;
begin
  result:=FList.BinarySearch(Item,Index,AComparer);
end;

function TThriftListImpl.BinarySearch(const Item: Pointer;
  out Index: Integer): Boolean;
begin
  result:=FList.BinarySearch(Item,Index);
end;

procedure TThriftListImpl.Clear;
begin
  FList.Clear;
end;


function TThriftListImpl.Contains(const Value: Variant): boolean;
begin
  result:=FList.Contains(Value);
end;

function TThriftListImpl.Contains(Value: TAllValue): boolean;
begin
  result:=FList.Contains(Value);
end;

function TThriftListImpl.Contains(const Value: TObject): boolean;
begin
  result:=FList.Contains(Value);
end;

function TThriftListImpl.Contains(const Value: IInterface): boolean;
begin
  result:=FList.Contains(Value);
end;

function TThriftListImpl.Contains(const Value: Pointer): boolean;
begin
  result:=FList.Contains(Value);
end;

constructor TThriftListImpl.Create(ACapacity: Integer = 0);
begin
  FList:=TuList.Create(ACapacity);
end;

procedure TThriftListImpl.Delete(Index: Integer);
begin
  FList.Delete(index);
end;

procedure TThriftListImpl.DeleteRange(AIndex, ACount: Integer);
begin
  FList.DeleteRange(Aindex,ACount);
end;

destructor TThriftListImpl.Destroy;
begin
  if assigned(FList) then
    FList.Free;
  inherited;
end;

procedure TThriftListImpl.Exchange(Index1, Index2: Integer);
begin
  FList.Exchange(index1,index2);
end;

function TThriftListImpl.Extract(const Value: TAllValue): TAllValue;
begin

end;

function TThriftListImpl.First: TAllValue;
begin
  result:=FList.First;
end;

function TThriftListImpl.GetCapacity: Integer;
begin
  result:=FList.GetCapacity;
end;

function TThriftListImpl.GetCount: Integer;
begin
  result:=FList.Count;
end;

function TThriftListImpl.GetItem(const Key: Integer): Variant;
begin
  result:=FList.GetItem(Key);
end;

function TThriftListImpl.GetItemV(const Key: Integer): TAllValue;
begin
  result:=FList.GetItemV(Key);
end;

function TThriftListImpl.IndexOf(const Value: Pointer;
  const LastIndex: boolean): integer;
begin
  result:=FList.IndexOf(Value,LastIndex);
end;

function TThriftListImpl.IndexOf(const Value: IInterface;
  const LastIndex: boolean): integer;
begin
  result:=FList.IndexOf(Value,LastIndex);
end;

procedure TThriftListImpl.Insert(Index: Integer; const Value: Variant);
begin
  FList.Insert(index,Value);
end;

procedure TThriftListImpl.Insert(Index: Integer; const Value: IInterface);
begin
  FList.Insert(index,Value);
end;

procedure TThriftListImpl.Insert(Index: Integer; const Value: Pointer);
begin
  FList.Insert(index,Value);
end;

procedure TThriftListImpl.InsertRange(Index: Integer;
  const Values: array of Variant);
begin
  FList.InsertRange(Index,Values);
end;

procedure TThriftListImpl.InsertRange(Index: Integer;
  const Values: array of TAllValue);
begin
  FList.InsertRange(Index,Values);
end;

procedure TThriftListImpl.InsertRange(Index: Integer;
  const Values: array of Pointer);
begin
  FList.InsertRange(Index,Values);
end;

procedure TThriftListImpl.InsertRange(Index: Integer;
  const Values: array of IInterface);
begin
  FList.InsertRange(Index,Values);
end;

function TThriftListImpl.IndexOf(const Value: TObject;
  const LastIndex: boolean): integer;
begin
  result:=FList.IndexOf(Value,LastIndex);
end;

function TThriftListImpl.IndexOf(Value: TAllValue;
  const LastIndex: boolean): integer;
begin
  result:=FList.IndexOf(Value,LastIndex);
end;

function TThriftListImpl.IndexOf(const Value: Variant;
  const LastIndex: boolean): integer;
begin
  result:=FList.IndexOf(Value,LastIndex);
end;

procedure TThriftListImpl.Insert(Index: Integer; const Value: TAllValue);
begin
  FList.Insert(index,Value);
end;

function TThriftListImpl.Last: TAllValue;
begin
  result:=FList.Last;
end;

function TThriftListImpl.LastIndexOf(const Value: Pointer): integer;
begin
  result:=FList.LastIndexOf(Value);
end;

function TThriftListImpl.LastIndexOf(const Value: IInterface): integer;
begin
  result:=FList.LastIndexOf(Value);
end;

function TThriftListImpl.LastIndexOf(const Value: TObject): integer;
begin
  result:=FList.LastIndexOf(Value);
end;

function TThriftListImpl.LastIndexOf(Value: TAllValue): integer;
begin
  result:=FList.LastIndexOf(Value);
end;

function TThriftListImpl.LastIndexOf(const Value: Variant): integer;
begin
  result:=FList.LastIndexOf(Value);
end;

procedure TThriftListImpl.Move(CurIndex, NewIndex: Integer);
begin

end;

procedure TThriftListImpl.Remove(const Value: Variant;
  const LastIndex: boolean);
begin
  FList.Remove(Value,LastIndex);
end;

procedure TThriftListImpl.Remove(const value: TAllValue;
  const LastIndex: boolean);
begin
  FList.Remove(Value,LastIndex);
end;

procedure TThriftListImpl.Remove(const Value: TObject;
  const LastIndex: boolean);
begin
  FList.Remove(Value,LastIndex);
end;

procedure TThriftListImpl.Remove(const Value: IInterface;
  const LastIndex: boolean);
begin
  FList.Remove(Value,LastIndex);
end;

procedure TThriftListImpl.Remove(const Value: Pointer;
  const LastIndex: boolean);
begin
  FList.Remove(Value,LastIndex);
end;

procedure TThriftListImpl.Reverse;
begin
  FList.Reverse;
end;

procedure TThriftListImpl.SetCapacity(Value: Integer);
begin
  FList.SetCapacity(Value);
end;

procedure TThriftListImpl.SetCount(Value: Integer);
begin
  FList.SetCount(Value);
end;

procedure TThriftListImpl.SetItem(const Key: Integer; const Value: Variant);
begin
  FList.SetItem(Key,value);
end;

procedure TThriftListImpl.SetItemV(const Key: Integer;
  const Value: TAllValue);
begin
  FList.SetItemV(Key,value);
end;

procedure TThriftListImpl.Sort;
begin
  FList.Sort;
end;

procedure TThriftListImpl.Sort(const AComparer: IuComparerValue);
begin
  FList.Sort(AComparer);
end;

function TThriftListImpl.ToArray: TAllValueArray;
begin
  result:=FList.ToArray;
end;

function TThriftListImpl.ToString: string;
begin

end;

procedure TThriftListImpl.TrimExcess;
begin
  FList.TrimExcess;
end;

{ TuDictionary_V_V }

constructor TuDictionary.Create(ACapacity: Integer);
begin
  Create(ACapacity, nil);
end;

constructor TuDictionary.Create(const AComparer: IuEqualityComparerValue);
begin
  Create(0, AComparer);
end;

procedure TuDictionary.Add(const Key: TAllValue;
  const Value: TAllValue);
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

procedure TuDictionary.Add(const Key: TAllValue; const value: Variant);
begin
  add(key,TAllValue.Create(value));
end;

procedure TuDictionary.Add(const Key: TAllValue; const value: TObject);
begin
  add(key,TAllValue.Create(value));
end;

procedure TuDictionary.Add(const Key: TAllValue; const value: IInterface);
begin
  add(key,TAllValue.Create(value));
end;

procedure TuDictionary.AddOrSetValue(const Key: TAllValue;
  const value: Variant);
begin
  AddOrSetValue(key,TAllValue.Create(value));
end;

procedure TuDictionary.AddOrSetValue(const Key: TAllValue;
  const Value: TAllValue);
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

procedure TuDictionary.AddOrSetValue(const Key: TAllValue;
  const value: IInterface);
begin
  AddOrSetValue(key,TAllValue.Create(value));
end;

procedure TuDictionary.AddOrSetValue(const Key: TAllValue;
  const value: TObject);
begin
  AddOrSetValue(key,TAllValue.Create(value));
end;

function TuDictionary.AsFloat(const Key: TAllValue): Double;
var
it:TAllValue;
begin
  it:=GetItemV(Key);
  if assigned(it) then
    result:=it.AsFloat;
end;

function TuDictionary.AsInt(const Key: TAllValue): Integer;
var
it:TAllValue;
begin
  it:=GetItemV(Key);
  if assigned(it) then
    result:=it.AsInt;
end;

function TuDictionary.AsIntf(const Key: TAllValue): IInterface;
var
it:TAllValue;
begin
  it:=GetItemV(Key);
  if assigned(it) then
    result:=it.AsIntf;
end;

function TuDictionary.AsObj(const Key: TAllValue): TObject;
var
it:TAllValue;
begin
  result:=nil;
  it:=GetItemV(Key);
  if assigned(it) then
    result:=it.AsObj;
end;

function TuDictionary.AsPointer(const Key: TAllValue): Pointer;
var
it:TAllValue;
begin
  result:=nil;
  it:=GetItemV(Key);
  if assigned(it) then
    result:=it.AsPointer;
end;

function TuDictionary.AsString(const Key: TAllValue): string;
var
it:TAllValue;
begin
  result:='';
  it:=GetItemV(Key);
  if assigned(it) then
    result:=it.AsString;
end;

procedure TuDictionary.Clear;
var
  i: Integer;
begin
  FCount := 0;
  _AllValueArray_Delete(fValue);
  _AllValueArray_Delete(fkey);
  SetCapacity(0);
  FGrowThreshold := 0;
  for i := 0 to Count - 1 do
  begin
    //KeyNotify(oldItems[i].Key, cnRemoved);
    //ValueNotify(oldItems[i].Value, cnRemoved);
  end;
end;

function TuDictionary.ContainsKey(const Key: TAllValue): Boolean;
begin
  result:=(GetBucketIndex(Key)>=0);
end;

constructor TuDictionary.Create(ACapacity: Integer;
  const AComparer: IuEqualityComparerValue);
begin
  inherited Create;
  if ACapacity < 0 then
    raise Exception.Create('Error: ACapacity less Zero');
  FComparer := AComparer;
  if FComparer = nil then
    FComparer := TuComparerValue.DefaultEqual;
  SetCapacity(ACapacity);
end;

destructor TuDictionary.Destroy;
var
i:integer;
begin
  if Count<=0 then exit;
  Clear;
  inherited;
end;

procedure TuDictionary.DoAdd(Index: Integer; const Key: TAllValue;
  const Value: TAllValue);
begin
  fKey[Index]:= Key;
  fValue[Index]:= Value;
  Inc(FCount);

  //KeyNotify(Key, cnAdded);
  //ValueNotify(Value, cnAdded);
end;

function TuDictionary.DoRemove(const Key: TAllValue;
  Notification: TuCollectionNotification): TAllValue;
var
  index: Integer;
begin
  Result :=nil;
  index := GetBucketIndex(Key);
  _AllValueArray_DeleteI(fKey,index);
  _AllValueArray_DeleteI(fvalue,index);
  Result := fvalue[index];
  if (Notification=cnRemoved) then
  begin
    Result.Free;
    Result:=nil;

  end;
  
  Dec(FCount);
  //KeyNotify(Key, Notification);
  //ValueNotify(Result, Notification);

end;

procedure TuDictionary.DoSetValue(Index: Integer;
  const Value: TAllValue);
var
  oldValue: TAllValue;
begin
  oldValue := Fvalue[Index];
  Fvalue[Index]:= Value;
  //ValueNotify(oldValue, cnRemoved);
  //ValueNotify(Value, cnAdded);
end;

function TuDictionary.ExtractPair(const Key: Variant): TAllValuePair;
begin
  result:=ExtractPair(_AllValue(Key));
end;

function TuDictionary.ExtractPair(const Key: TAllValue): TAllValuePair;
var
  index: Integer;
begin
  result:=nil;
  index := GetBucketIndex(Key);
  if index >=0 then
  begin
    Result := TAllValuePair.Create(Key, DoRemove(Key, cnExtracted));
  end;

end;

function TuDictionary.GetBucketIndex(const Key: TAllValue): Integer;
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

function TuDictionary.GetCapacity: Integer;
begin
  Result := Length(fvalue);
end;

function TuDictionary.GetItemV(const Key: TAllValue): TAllValue;
var
  index: Integer;
begin
  Result :=nil;
  index := GetBucketIndex(Key);
  if index < 0 then
    raise EListError.Create('Error: Not Found key');
  Result := FValue[index];
end;

function TuDictionary.GetPair(const index: Cardinal): TAllValuePair;
begin
  result:=nil;
  if (index >=0) and (Index<Count) then
  begin
    Result := TAllValuePair.Create(fKey[index], fvalue[index]);
  end;
end;

function TuDictionary.GetItem(const Key: TAllValue): Variant;
var
  i: Integer;
begin
  i := GetBucketIndex(Key);
  if i < 0 then
    raise EListError.Create('Error: Not Found key');
  Result := FValue[i].Value;
end;

procedure TuDictionary.Grow;
var
  newCap: Integer;
begin
  newCap := Length(fKey) * 2;
  if newCap = 0 then
    newCap := 4;
  Rehash(newCap);
end;

procedure TuDictionary.Rehash(NewCapPow2: Integer);
begin
  if NewCapPow2 = Length(fKey) then
    Exit
  else if NewCapPow2 < 0 then
    OutOfMemoryError;
  fKey := _AllValueArray_Grow(fKey,NewCapPow2);
  fValue := _AllValueArray_Grow(fValue,NewCapPow2);
end;


procedure TuDictionary.Remove(const Key: Variant);
begin
  Remove(_AllValue(Key));
end;

procedure TuDictionary.Remove(const Key: TAllValue);
var
t:TAllValue;
begin
  t:=DoRemove(Key, cnRemoved);
  if assigned(t) then
    t.Free;

end;

procedure TuDictionary.SetCapacity(ACapacity: Integer);
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

procedure TuDictionary.SetItemV(const Key: TAllValue;
  const Value: TAllValue);
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

procedure TuDictionary.SetItem(const Key: TAllValue;
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
    FValue[i]:=TAllValue.Create(Value);
  end;
end;

procedure TuDictionary.TrimExcess;
begin
  SetCapacity(Count + 1);
end;

function TuDictionary.TryGetValue(const Key: TAllValue;
  out Value: TAllValue): Boolean;
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

function TuDictionary.TryGetValueIntf(const Key: TAllValue;
  out Value: IInterface): Boolean;
var
t: TAllValue;
begin
  Value:=nil;
  result:=TryGetValue(Key,t);
  if (result) then
  begin
    Value:=t.AsIntf;
  end;
end;

function TuDictionary.TryGetValueObj(const Key: TAllValue;
  out Value: TObject): Boolean;
var
t: TAllValue;
begin
  Value:=nil;
  result:=TryGetValue(Key,t);
  if (result) then
  begin
    Value:=t.AsObj;
  end;
end;

function TuDictionary.TryGetValuePointer(const Key: TAllValue;
  out Value: Pointer): Boolean;
var
t: TAllValue;
begin
  Value:=nil;
  result:=TryGetValue(Key,t);
  if (result) then
  begin
    Value:=t.AsPointer;
  end;
end;

function TuDictionary.TryGetValueString(const Key: TAllValue;
  out Value: string): Boolean;
var
t: TAllValue;
begin
  Value:='';
  result:=TryGetValue(Key,t);
  if (result) then
  begin
    Value:=t.AsString;
  end;

end;

procedure TuDictionary.Add(const Key: TAllValue; const value: Pointer);
begin
  add(key,TAllValue.Create(Pointer(value)));
end;

procedure TuDictionary.AddOrSetValue(const Key: TAllValue;
  const value: Pointer);
begin
  AddOrSetValue(key,TAllValue.Create(value));
end;


procedure TuDictionary.Add(const Key: Variant; const value: IInterface);
begin
  Add(_AllValue(Key),value);
end;

procedure TuDictionary.Add(const Key: Variant; const value: TObject);
begin
  Add(_AllValue(Key),value);
end;

procedure TuDictionary.Add(const Key, value: Variant);
begin
  Add(_AllValue(Key),value);
end;

procedure TuDictionary.Add(const Key: Variant; const value: Pointer);
begin
  Add(_AllValue(Key),value);
end;

procedure TuDictionary.Add(const Key: Variant; const Value: TAllValue);
begin
  Add(_AllValue(Key),value);
end;

procedure TuDictionary.AddOrSetValue(const Key: Variant;
  const value: Pointer);
begin
  AddOrSetValue(_AllValue(Key),value);
end;

procedure TuDictionary.AddOrSetValue(const Key: Variant;
  const Value: TAllValue);
begin
  AddOrSetValue(_AllValue(Key),value);
end;

procedure TuDictionary.AddOrSetValue(const Key, value: Variant);
begin
  AddOrSetValue(_AllValue(Key),value);
end;

procedure TuDictionary.AddOrSetValue(const Key: Variant;
  const value: IInterface);
begin
  AddOrSetValue(_AllValue(Key),value);
end;

procedure TuDictionary.AddOrSetValue(const Key: Variant;
  const value: TObject);
begin
  AddOrSetValue(_AllValue(Key),value);
end;

function TuDictionary.AsFloat(const Key: Variant): Double;
begin
  result:=  AsFloat(_AllValue(Key));
end;

function TuDictionary.AsInt(const Key: Variant): Integer;
begin
  result:=  AsInt(_AllValue(Key));
end;

function TuDictionary.AsIntf(const Key: Variant): IInterface;
begin
  result:=  AsIntf(_AllValue(Key));
end;

function TuDictionary.AsObj(const Key: Variant): TObject;
begin
  result:=  AsObj(_AllValue(Key));
end;

function TuDictionary.AsPointer(const Key: Variant): Pointer;
begin
  result:=  AsPointer(_AllValue(Key));
end;

function TuDictionary.AsString(const Key: Variant): string;
begin
  result:=  AsString(_AllValue(Key));
end;

function TuDictionary.TryGetValue(const Key: Variant;
  out Value: TAllValue): Boolean;
begin
  result:=  TryGetValue(_AllValue(Key),Value);
end;

function TuDictionary.TryGetValueIntf(const Key: Variant;
  out Value: IInterface): Boolean;
begin
  result:=  TryGetValueIntf(_AllValue(Key),Value);
end;

function TuDictionary.TryGetValueObj(const Key: Variant;
  out Value: TObject): Boolean;
begin
  result:=  TryGetValueObj(_AllValue(Key),Value);
end;

function TuDictionary.TryGetValuePointer(const Key: Variant;
  out Value: Pointer): Boolean;
begin
  result:=  TryGetValuePointer(_AllValue(Key),Value);
end;

function TuDictionary.TryGetValueString(const Key: Variant;
  out Value: string): Boolean;
begin
  result:=  TryGetValueString(_AllValue(Key),Value);
end;

{ TuList_V }

procedure TuList.Add(const value: Pointer);
begin
  add(TAllValue.Create(value));
end;

procedure TuList.Add(const Value: TAllValue);
begin
  if (FCount >= FGrowThreshold) or (FCount>=High(fvalue)) then
    Grow;
  DoAdd(Count, Value);
end;

procedure TuList.Add(const value: IInterface);
begin
  add(TAllValue.Create(value));
end;

procedure TuList.Add( const value: Variant);
begin
  add(TAllValue.Create(value));
end;

procedure TuList.Add(const value: TObject);
begin
  add(TAllValue.Create(value));
end;

procedure TuList.AddOrSetValue(const Key: integer; const value: Pointer);
begin
  AddOrSetValue(key,TAllValue.Create(value));
end;

procedure TuList.AddRange(const Values: array of Variant);
var
i,n:integer;
begin
  n:=length(Values);
  if n<=0 then exit;
  for i := 0 to n - 1 do
    Add(Values[i]);
end;

procedure TuList.AddRange(const Values: array of TAllValue);
var
i,n:integer;
begin
  n:=length(Values);
  if n<=0 then exit;
  for i := 0 to n - 1 do
    Add(Values[i]);
end;

procedure TuList.AddRange(const Values: array of Pointer);
var
i,n:integer;
begin
  n:=length(Values);
  if n<=0 then exit;
  for i := 0 to n - 1 do
    Add(Values[i]);
end;

procedure TuList.AddRange(const Values: array of IInterface);
var
i,n:integer;
begin
  n:=length(Values);
  if n<=0 then exit;
  for i := 0 to n - 1 do
    Add(Values[i]);
end;

procedure TuList.AddOrSetValue(const Key: Integer; const value: Variant);
begin
  AddOrSetValue(key,TAllValue.Create(value));
end;

procedure TuList.AddOrSetValue(const Key: Integer;
  const Value: TAllValue);
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

procedure TuList.AddOrSetValue(const Key: Integer; const value: TObject);
begin
  AddOrSetValue(key,TAllValue.Create(value));
end;

procedure TuList.AddOrSetValue(const Key: Integer;
  const value: IInterface);
begin
  AddOrSetValue(key,TAllValue.Create(value));
end;

function TuList.AsFloat(const Key: Integer): Double;
begin
  result:=GetItemV(Key).AsFloat;
end;

function TuList.AsInt(const Key: Integer): Integer;
begin
  result:=GetItemV(Key).AsInt;
end;

function TuList.AsIntf(const Key: Integer): IInterface;
begin
  result:=GetItemV(Key).AsIntf;
end;

function TuList.AsObj(const Key: Integer): TObject;
begin
  result:=GetItemV(Key).AsPointer;
end;

function TuList.AsPointer(const Key: Integer): Pointer;
begin
  result:=GetItemV(Key).AsPointer;
end;

function TuList.AsString(const Key: Integer): string;
begin
  result:=GetItemV(Key).AsString;
end;

function TuList.BinarySearch(const Item: TObject;
  out Index: Integer): Boolean;
var
Itemt:TAllValue;
begin
  Itemt:=TAllValue.Create(Item,true);
  result:=Array_AllValue_BinarySearch(fvalue,Itemt,Index);
end;


function TuList.BinarySearch(const Item: Variant;
  out Index: Integer): Boolean;
var
Itemt:TAllValue;
begin
  Itemt:=TAllValue.Create(Item);
  result:=Array_AllValue_BinarySearch(fvalue,Itemt,Index);
end;

function TuList.BinarySearch(const Item: IInterface;
  out Index: Integer): Boolean;
var
Itemt:TAllValue;
begin
  Itemt:=TAllValue.Create(Item);
  result:=Array_AllValue_BinarySearch(fvalue,Itemt,Index);
end;

function TuList.BinarySearch(const Item: TAllValue; out Index: Integer;
  const AComparer: IuComparerValue): Boolean;
begin
  result:=Array_AllValue_BinarySearch(fvalue,Item,Index,AComparer);
end;

function TuList.BinarySearch(const Item: Pointer;
  out Index: Integer): Boolean;
var
Itemt:TAllValue;
begin
  Itemt:=TAllValue.Create(Item);
  result:=Array_AllValue_BinarySearch(fvalue,Itemt,Index);
end;

procedure TuList.Clear;
var
  i: Integer;
  oldItemsv: TAllValueArray;
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

function TuList.Contains(const Value: Pointer): boolean;
begin
  result:=(IndexOf(Value)>=0);
end;

function TuList.Contains(const Value: IInterface): boolean;
begin
  result:=(IndexOf(Value)>=0);
end;

function TuList.Contains(const Value: TObject): boolean;
begin
  result:=(IndexOf(Value)>=0);
end;

function TuList.Contains(Value: TAllValue): boolean;
begin
  result:=(IndexOf(Value)>=0);
end;

function TuList.Contains(const Value: Variant): boolean;
begin
  result:=(IndexOf(Value)>=0);
end;

constructor TuList.Create(ACapacity: Integer);
begin
  inherited Create;
  if ACapacity < 0 then
    raise Exception.Create('Error: ACapacity less Zero');
  SetCapacity(ACapacity);
end;

procedure TuList.Delete(Index: Integer);
var
t:TAllValue;
begin
  t:=DoRemove(Index, cnRemoved);
  if assigned(t) then
    t.Free;
end;

procedure TuList.DeleteRange(AIndex, ACount: Integer);
var
  newItems: array of TAllValue;
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

destructor TuList.Destroy;
begin
  if Count<=0 then exit;
  Clear;
  inherited;
end;

procedure TuList.DoAdd(Index: Integer; const Value: TAllValue);
begin
  fValue[Index]:= Value;
  Inc(FCount);

end;

function TuList.DoRemove(const Key: integer;
  Notification: TuCollectionNotification): TAllValue;
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

procedure TuList.DoSetValue(Index: Integer; const Value: TAllValue);
var
  oldValue: TAllValue;
begin
  if (Index<0) or (Index>=count) then exit;
  oldValue := Fvalue[Index];
  Fvalue[Index]:= Value;
  //ValueNotify(oldValue, cnRemoved);
  //ValueNotify(Value, cnAdded);
end;

procedure TuList.Exchange(Index1, Index2: Integer);
var
v:TAllValue;
begin
  if (Index1=Index2) then exit;
  if (Index1<0) or (Index1>=Count) then exit;
  if (Index2<0) or (Index2>=Count) then exit;
  v:=fvalue[Index1];
  fvalue[Index1]:=fvalue[Index2];
  fvalue[Index2]:=v;
  

end;

function TuList.First: TAllValue;
begin
  result:=nil;
  if (Count<0) then exit;
  result:=fvalue[0];
end;

function TuList.GetCapacity: Integer;
begin
  Result := Length(fvalue);
end;

procedure TuList.SetCount(Value: Integer);
begin
  if Value < 0 then
    raise Exception.Create('Error: Count less Zero');
  if Value > Capacity then
    SetCapacity(Value);
  if Value < Count then
    DeleteRange(Value, Count - Value);
  FCount := Value;
end;

function TuList.GetItem(const Key: integer): Variant;
begin
  if (Key < 0) or (Key>=Count) then
    raise EListError.Create('Error: Not Found key');
  Result := FValue[Key].Value;
end;

function TuList.GetItemV(const Key: integer): TAllValue;
begin
  if (Key < 0) or (Key>=Count) then
    raise EListError.Create('Error: Not Found key');
  Result := FValue[Key];
end;

procedure TuList.Grow(const ACount: Integer);
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

procedure TuList.GrowCheck(ACount: Integer);
begin
  if ACount > Length(fValue) then
    Grow
  else if ACount < 0 then
    OutOfMemoryError;
end;

procedure TuList.Rehash(NewCapPow2: Integer);
var
  i: Integer;
begin
  if NewCapPow2 = Length(fvalue) then
    Exit
  else if NewCapPow2 < 0 then
    OutOfMemoryError;
  fValue := _AllValueArray_Grow(fValue,NewCapPow2);

end;


procedure TuList.Remove(const Value: TObject; const LastIndex: boolean);
var
t:TAllValue;
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

procedure TuList.Remove(const Value: Variant; const LastIndex: boolean);
var
t:TAllValue;
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

procedure TuList.Remove(const Value: IInterface; const LastIndex: boolean);
var
t:TAllValue;
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

procedure TuList.Remove(const Value: Pointer; const LastIndex: boolean);
var
t:TAllValue;
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

procedure TuList.Remove(const value:TAllValue;const LastIndex:boolean);
var
t:TAllValue;
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

procedure TuList.Reverse;
var
  tmp: TAllValue;
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

procedure TuList.SetCapacity(ACapacity: Integer);
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


procedure TuList.SetItem(const Key: Integer; const Value: Variant);
begin
  if (Key < 0) or (Key>=Count) then
    raise EListError.Create('Error: Not Found key');
  FValue[Key]:=TAllValue.Create(Value);
end;

procedure TuList.SetItemV(const Key: integer; const Value: TAllValue);
begin
  if (Key < 0) or (Key>=Count) then
    raise EListError.Create('Error: Not Found key');
  FValue[Key]:=Value;

end;

procedure TuList.Sort;
begin
  Array_AllValue_Sort(fvalue,0,Count);
end;

procedure TuList.Sort(const AComparer: IuComparerValue);
begin
  Array_AllValue_Sort(fvalue, AComparer, 0, Count);
end;

function TuList.ToArray: TAllValueArray;
begin
  result:=fvalue;
end;

procedure TuList.TrimExcess;
begin
  SetCapacity(Count + 1);
end;

function TuList.IndexOf(const Value: TObject;const LastIndex:boolean=false): integer;
var
V: TAllValue;
begin
  V:=TAllValue.Create(Value);
  result:=IndexOf(v,LastIndex);
end;

function TuList.IndexOf(const Value: Pointer;const LastIndex:boolean=false): integer;
var
V: TAllValue;
begin
  V:=TAllValue.Create(Value);
  result:=IndexOf(v,LastIndex);
end;

function TuList.IndexOf(Value: TAllValue;const LastIndex:boolean=false): integer;
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
    if fValue[i].Hash=Value.Hash then
    begin
      result:=i;
      exit;
    end;
    i:=i+d;
  until (i>=0) and (i<n);
end;

function TuList.IndexOf(const Value: Variant;const LastIndex:boolean=false): integer;
var
V: TAllValue;
begin
  V:=TAllValue.Create(Value);
  result:=IndexOf(v,LastIndex);
end;



function TuList.IndexOf(const Value: IInterface;const LastIndex:boolean=false): integer;
var
V: TAllValue;
begin
  V:=TAllValue.Create(Value);
  result:=IndexOf(v,LastIndex);
end;

procedure TuList.Insert(Index: Integer; const Value: Variant);
begin
  Insert(Index,TAllValue.Create(value));
end;

procedure TuList.Insert(Index: Integer; const Value: TAllValue);
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

procedure TuList.Insert(Index: Integer; const Value: Pointer);
begin
  Insert(Index,TAllValue.Create(value));
end;

procedure TuList.InsertRange(Index: Integer; const Values: array of Variant);
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

procedure TuList.InsertRange(Index: Integer;
  const Values: array of TAllValue);
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

procedure TuList.InsertRange(Index: Integer; const Values: array of Pointer);
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

procedure TuList.InsertRange(Index: Integer;
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

procedure TuList.Insert(Index: Integer; const Value: IInterface);
begin
  Insert(Index,TAllValue.Create(value));
end;

function TuList.LastIndexOf(const Value: Pointer): integer;
begin
  result:=IndexOf(Value,true);
end;

function TuList.Last: TAllValue;
begin
  result:=nil;
  if (FCount<0) then exit;
  result:=fvalue[FCount-1];
end;

function TuList.LastIndexOf(const Value: IInterface): integer;
begin
  result:=IndexOf(Value,true);
end;
{
procedure TuList_V.Move(CurIndex, NewIndex: Integer);
var
  temp: TAllValue;
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


function TuList.LastIndexOf(const Value: TObject): integer;
begin
  result:=IndexOf(Value,true);
end;

function TuList.LastIndexOf(Value: TAllValue): integer;
begin
  result:=IndexOf(Value,true);
end;

function TuList.LastIndexOf(const Value: Variant): integer;
begin
  result:=IndexOf(Value,true);
end;

{ TuComparerValue_VDefault }

function TuComparerValue_Default.Compare(const Left,
  Right: TAllValue): Integer;
begin
  result:=AllValue_Compare_Default(Left,Right);
end;

{ TIuEqualityComparerValue_VDefault }

function TIuEqualityComparerValue_Default.Equals(const Left,
  Right: TAllValue): Boolean;
begin
  result:=AllValue_Compare_Default(Left,Right)=0;
end;

{ TuComparerValue_V }

class function TuComparerValue.Default: IuComparerValue;
begin
  result:=IuComparerValue(TuComparerValue_Default.Create);
end;

class function TuComparerValue.DefaultEqual: IuEqualityComparerValue;
begin
  result:=IuEqualityComparerValue(TIuEqualityComparerValue_Default.Create);
end;


{ TuStack_V }

procedure TuStack.Clear;
var
  i: Integer;
  oldItemsv: TAllValueArray;
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


constructor TuStack.Create(Collection: TAllValueArray);
var
ACapacity:integer;
item: TAllValue;
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

destructor TuStack.Destroy;
begin
  if Count<=0 then exit;
  Clear;
  inherited;
end;

function TuStack.Extract: TAllValue;
begin
  result:=Pop;
end;

function TuStack.GetCapacity: Integer;
begin
  Result := Length(fvalue);
end;

procedure TuStack.Grow(const ACount: Integer);
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

function TuStack.Peek: TAllValue;
begin
  if Count = 0 then
    raise EListError.Create('Unbalanced stack or queue operation');
  Result := fValue[Count - 1];

end;

function TuStack.PopP: Pointer;
var
t:TAllValue;
begin
t:=Pop;
result:=nil;
if (t<>nil) then
  result:=t.ValuePtr;
end;

function TuStack.PopI: IInterface;
var
t:TAllValue;
begin
t:=Pop;
if (t<>nil) then
  result:=t.ValueIntf;
end;

function TuStack.PopV: Variant;
var
t:TAllValue;
begin
t:=Pop;
if (t<>nil) then
  result:=t.Value;
end;

function TuStack.PopO: TObject;
var
t:TAllValue;
begin
t:=Pop;
result:=nil;
if (t<>nil) then
  result:=t.ValueObj;
end;

function TuStack.Pop: TAllValue;
begin
  Result := nil;
  if Count = 0 then
    raise EListError.Create('Unbalanced stack or queue operation');
  Dec(FCount);
  Result := fValue[Count];
  fValue[Count]:=nil;
  //Notify(Result, Notification);
end;

procedure TuStack.Push(const Value: TAllValue);
begin
  if Count = Length(fValue) then
    Grow(Count+4);
  fValue[Count] := Value;
  Inc(FCount);
  //Notify(Value, cnAdded);
end;

procedure TuStack.Rehash(NewCapPow2: Integer);
var
  i: Integer;
begin
  if NewCapPow2 = Length(fvalue) then
    Exit
  else if NewCapPow2 < 0 then
    OutOfMemoryError;
  fValue := _AllValueArray_Grow(fValue,NewCapPow2);
end;


procedure TuStack.SetCapacity(ACapacity: Integer);
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


function TuStack.ToArray: TAllValueArray;
begin
  result:=fValue;
end;

procedure TuStack.TrimExcess;
begin
  SetCapacity(Count + 1);
end;

procedure  TuStack.PushP(const Value: Pointer);
begin
  push(TAllValue.Create(Value));
end;

procedure TuStack.PushI(const Value: IInterface);
begin
  push(TAllValue.Create(Value));
end;

procedure TuStack.PushV(const Value: Variant);
begin
  push(TAllValue.Create(Value));
end;

procedure TuStack.PushO(const Value: TObject);
begin
  push(TAllValue.Create(Value));
end;
end.
