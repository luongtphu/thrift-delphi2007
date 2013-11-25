unit uStringBuilder;

interface
uses SysUtils,classes,uRTLConsts,uSysUtils;

{$I uDefine.inc}
{$ifdef NO_TStringBuilder}

type
  TCharArray = array of char;
  MarshaledString = PWideChar;
  
type
TStringBuilder = class
  private const
    DefaultCapacity = $10;
  private
    function GetCapacity: Integer;
    procedure SetCapacity(Value: Integer);
    function GetChars(Index: Integer): Char;
    procedure SetChars(Index: Integer; Value: Char);
    function GetLength: Integer; inline;
    procedure SetLength(Value: Integer);
    function GetMaxCapacity: Integer;
    procedure ExpandCapacity;
    procedure ReduceCapacity;
    procedure CheckBounds(Index: Integer);
    function _Replace(Index: Integer; const Old, New: string): Boolean;
  protected
    FData: TCharArray;
    FLength: Integer;
    FMaxCapacity: Integer;
  public
    constructor Create; overload;
    constructor Create(aCapacity: Integer); overload;
    constructor Create(const Value: string); overload;
    constructor Create(aCapacity: Integer; aMaxCapacity: Integer); overload;
    constructor Create(const Value: string; aCapacity: Integer); overload;
    constructor Create(const Value: string; StartIndex: Integer; Length: Integer; aCapacity: Integer); overload;

    function Append(const Value: Boolean): TStringBuilder; overload;
    function Append(const Value: Byte): TStringBuilder; overload;
    function Append(const Value: Char): TStringBuilder; overload;
    function Append(const Value: Currency): TStringBuilder; overload;
    function Append(const Value: Double): TStringBuilder; overload;
    function Append(const Value: Smallint): TStringBuilder; overload;
    function Append(const Value: Integer): TStringBuilder; overload;
    function Append(const Value: Int64): TStringBuilder; overload;
    function Append(const Value: TObject): TStringBuilder; overload;
    function Append(const Value: Shortint): TStringBuilder; overload;
    function Append(const Value: Single): TStringBuilder; overload;
    function Append(const Value: string): TStringBuilder; overload;
    function Append(const Value: UInt64): TStringBuilder; overload;
    function Append(const Value: TCharArray): TStringBuilder; overload;
    function Append(const Value: Word): TStringBuilder; overload;
    function Append(const Value: Cardinal): TStringBuilder; overload;

    function Append(const Value: Char; RepeatCount: Integer): TStringBuilder; overload;
    function Append(const Value: TCharArray; StartIndex: Integer; CharCount: Integer): TStringBuilder; overload;
    function Append(const Value: string; StartIndex: Integer; Count: Integer): TStringBuilder; overload;

    function AppendFormat(const Format: string; const Args: array of const): TStringBuilder; overload;
    function AppendLine: TStringBuilder; overload;
    function AppendLine(const Value: string): TStringBuilder; overload;
    procedure Clear;
    procedure CopyTo(SourceIndex: Integer; const Destination: TCharArray; DestinationIndex: Integer; Count: Integer);
    function EnsureCapacity(aCapacity: Integer): Integer;
    function Equals(StringBuilder: TStringBuilder): Boolean; reintroduce;

    function Insert(Index: Integer; const Value: Boolean): TStringBuilder; overload;
    function Insert(Index: Integer; const Value: Byte): TStringBuilder; overload;
    function Insert(Index: Integer; const Value: Char): TStringBuilder; overload;
    function Insert(Index: Integer; const Value: Currency): TStringBuilder; overload;
    function Insert(Index: Integer; const Value: Double): TStringBuilder; overload;
    function Insert(Index: Integer; const Value: Smallint): TStringBuilder; overload;
    function Insert(Index: Integer; const Value: Integer): TStringBuilder; overload;
    function Insert(Index: Integer; const Value: TCharArray): TStringBuilder; overload;
    function Insert(Index: Integer; const Value: Int64): TStringBuilder; overload;
    function Insert(Index: Integer; const Value: TObject): TStringBuilder; overload;
    function Insert(Index: Integer; const Value: Shortint): TStringBuilder; overload;
    function Insert(Index: Integer; const Value: Single): TStringBuilder; overload;
    function Insert(Index: Integer; const Value: string): TStringBuilder; overload;
    function Insert(Index: Integer; const Value: Word): TStringBuilder; overload;
    function Insert(Index: Integer; const Value: Cardinal): TStringBuilder; overload;
    function Insert(Index: Integer; const Value: UInt64): TStringBuilder; overload;
    function Insert(Index: Integer; const Value: string; count: Integer): TStringBuilder; overload;
    function Insert(Index: Integer; const Value: TCharArray; startIndex: Integer; charCount: Integer): TStringBuilder; overload;

    function Remove(StartIndex: Integer; RemLength: Integer): TStringBuilder;

    function Replace(const OldChar: Char; const NewChar: Char): TStringBuilder; overload;
    function Replace(const OldValue: string; const NewValue: string): TStringBuilder; overload;
    function Replace(const OldChar: Char; const NewChar: Char; StartIndex: Integer; Count: Integer): TStringBuilder; overload;
    function Replace(const OldValue: string; const NewValue: string; StartIndex: Integer; Count: Integer): TStringBuilder; overload;

    function ToString: string; overload; override;
    function ToString(StartIndex: Integer; StrLength: Integer): string; reintroduce; overload;

    property Capacity: Integer read GetCapacity write SetCapacity;
    property Chars[index: Integer]: Char read GetChars write SetChars; default;
    property Length: Integer read GetLength write SetLength;
    property MaxCapacity: Integer read GetMaxCapacity;
  end;
{$endif}
implementation
{$ifdef NO_TStringBuilder}
function TStringBuilder.GetLength: Integer;
begin
  Result := FLength;
end;

function TStringBuilder.Append(const Value: UInt64): TStringBuilder;
begin
  Append(UIntToStr(Value));
  Result := self;
end;

function TStringBuilder.Append(const Value: TCharArray): TStringBuilder;
var
  I: Integer;
begin
  Result := self;

  for I := 0 to System.Length(Value) - 1 do
    if Value[I] = #0 then
      Break;

  Append(Value, 0, I);
end;

function TStringBuilder.Append(const Value: Single): TStringBuilder;
begin
  Append(FloatToStr(Value));
  Result := self;
end;

function TStringBuilder.Append(const Value: string): TStringBuilder;
begin
  Length := Length + System.Length(Value);
  Move(PChar(Value)^, FData[Length - System.Length(Value)], System.Length(Value) * SizeOf(Char));
  Result := self;
end;

function TStringBuilder.Append(const Value: Word): TStringBuilder;
begin
  Append(IntToStr(Value));
  Result := self;
end;

function TStringBuilder.Append(const Value: TCharArray; StartIndex,
  CharCount: Integer): TStringBuilder;
begin
  if StartIndex + CharCount > System.Length(Value) then
    raise ERangeError.CreateResFmt(@SListIndexError, [StartIndex]);
  if StartIndex < 0 then
    raise ERangeError.CreateResFmt(@SListIndexError, [StartIndex]);

  Length := Length + CharCount;
  Move(Value[StartIndex], FData[Length - CharCount], CharCount * SizeOf(Char));
  Result := self;
end;

function TStringBuilder.Append(const Value: string; StartIndex,
  Count: Integer): TStringBuilder;
begin
  if StartIndex + Count > System.Length(Value) then
    raise ERangeError.CreateResFmt(@SListIndexError, [StartIndex]);
  if StartIndex < 0 then
    raise ERangeError.CreateResFmt(@SListIndexError, [StartIndex]);

  Length := Length + Count;
  Move(Value[StartIndex + Low(string)], FData[Length - Count], Count * SizeOf(Char));
  Result := Self;
end;


function TStringBuilder.Append(const Value: Cardinal): TStringBuilder;
begin
  Append(UIntToStr(Value));
  Result := self;
end;

function TStringBuilder.Append(const Value: Char;
  RepeatCount: Integer): TStringBuilder;
begin
  Append(System.StringOfChar(Value, RepeatCount));
  Result := Self;
end;

function TStringBuilder.Append(const Value: Shortint): TStringBuilder;
begin
  Append(IntToStr(Value));
  Result := Self;
end;

function TStringBuilder.Append(const Value: Char): TStringBuilder;
begin
  Length := Length + 1;
  FData[Length - 1] := Value;
  Result := Self;
end;

function TStringBuilder.Append(const Value: Currency): TStringBuilder;
begin
  Append(CurrToStr(Value));
  Result := Self;
end;

function TStringBuilder.Append(const Value: Boolean): TStringBuilder;
begin
  Append(BoolToStr(Value, True));
  Result := Self;
end;

function TStringBuilder.Append(const Value: Byte): TStringBuilder;
begin
  Append(IntToStr(Value));
  Result := Self;
end;

function TStringBuilder.Append(const Value: Double): TStringBuilder;
begin
  Append(FloatToStr(Value));
  Result := Self;
end;

function TStringBuilder.Append(const Value: Int64): TStringBuilder;
begin
  Append(IntToStr(Value));
  Result := Self;
end;

function TStringBuilder.Append(const Value: TObject): TStringBuilder;
begin

{$ifdef GEN_SUPPORT}
  Append(Value.ToString());
{$else}
  Append(IntToStr(Integer(Value)));
{$endif}

  Result := Self;
end;

function TStringBuilder.Append(const Value: Smallint): TStringBuilder;
begin
  Append(IntToStr(Value));
  Result := Self;
end;

function TStringBuilder.Append(const Value: Integer): TStringBuilder;
begin
  Append(IntToStr(Value));
  Result := Self;
end;

function TStringBuilder.AppendFormat(const Format: string; const Args: array of const): TStringBuilder;
begin
  Append(Format(Format, Args));
  Result := Self;
end;

function TStringBuilder.AppendLine: TStringBuilder;
begin
  Append(sLineBreak);
  Result := Self;
end;

function TStringBuilder.AppendLine(const Value: string): TStringBuilder;
begin
  Append(Value);
  AppendLine;
  Result := Self;
end;

procedure TStringBuilder.Clear ;
begin
  Length := 0;
  Capacity := DefaultCapacity;
end;

procedure TStringBuilder.CheckBounds(Index: Integer);
begin
  if Cardinal(Index) >= Cardinal(Length) then
    raise ERangeError.CreateResFmt(@SListIndexError, [Index]);
end;

procedure TStringBuilder.CopyTo(SourceIndex: Integer;
  const Destination: TCharArray; DestinationIndex, Count: Integer);
begin
  if Count < 0 then
    raise ERangeError.CreateResFmt(@SParamIsNegative, ['Count']); // DO NOT LOCALIZE
  if DestinationIndex < 0 then
    raise ERangeError.CreateResFmt(@SParamIsNegative, ['DestinationIndex']); // DO NOT LOCALIZE
  if DestinationIndex + Count > System.Length(Destination) then
    raise ERangeError.CreateResFmt(@SInputBufferExceed,
      ['DestinationIndex', DestinationIndex, 'Count', Count]);

  if Count > 0 then
  begin
    CheckBounds(SourceIndex);
    CheckBounds(SourceIndex + Count - 1);

    Move(FData[SourceIndex], Destination[DestinationIndex], Count * SizeOf(Char));
  end;
end;

constructor TStringBuilder.Create;
begin
  inherited Create;
  FMaxCapacity := MaxInt;
  Capacity := DefaultCapacity;
  FLength := 0;
end;

constructor TStringBuilder.Create(const Value: string; aCapacity: Integer);
begin
  inherited Create;
  FMaxCapacity := MaxInt;
  Capacity := aCapacity;
  FLength := 0;
  Append(Value);
end;

constructor TStringBuilder.Create(const Value: string; StartIndex, length,
  aCapacity: Integer);
begin
  //Create(Copy(Value, StartIndex + 1, length), aCapacity);
  Create(Value.Substring( StartIndex, length), aCapacity);
end;

constructor TStringBuilder.Create(aCapacity, aMaxCapacity: Integer);
begin
  Create(aCapacity);
  FMaxCapacity := aMaxCapacity;
end;

constructor TStringBuilder.Create(aCapacity: Integer);
begin
  inherited Create;
  FMaxCapacity := MaxInt;
  Capacity := aCapacity;
  FLength := 0;
end;

constructor TStringBuilder.Create(const Value: string);
begin
  Create;
  Append(Value);
end;

function TStringBuilder.EnsureCapacity(aCapacity: Integer): Integer;
begin
  if Cardinal(aCapacity) > Cardinal(MaxCapacity) then
    raise ERangeError.CreateResFmt(@SListIndexError, [aCapacity]);

  if Capacity < aCapacity then
    Capacity := aCapacity;

  Result := Capacity;
end;

function TStringBuilder.Equals(StringBuilder: TStringBuilder): Boolean;
begin
  Result := (StringBuilder <> nil) and (Length = StringBuilder.Length) and
    (MaxCapacity = StringBuilder.MaxCapacity) and
    CompareMem(@FData[0], @StringBuilder.FData[0], Length * SizeOf(Char));
end;

procedure TStringBuilder.ExpandCapacity;
var
  NewCapacity: Integer;
begin
  NewCapacity := Capacity * 2;
  if Length > NewCapacity then
    NewCapacity := Length * 2; // this line may overflow NewCapacity to a negative value
  if NewCapacity > MaxCapacity then
    NewCapacity := MaxCapacity;
  if NewCapacity < 0 then // if NewCapacity has been overflowed
    NewCapacity := Length;
  Capacity := NewCapacity;
end;

function TStringBuilder.GetCapacity: Integer;
begin
  Result := System.Length(FData);
end;

function TStringBuilder.GetChars(Index: Integer): Char;
begin
  if Index < 0 then
    raise ERangeError.CreateResFmt(@SParamIsNegative, ['Index']); // DO NOT LOCALIZE
  CheckBounds(Index);

  Result := FData[Index];
end;

function TStringBuilder.GetMaxCapacity: Integer;
begin
  Result := FMaxCapacity;
end;

function TStringBuilder.Insert(Index: Integer; const Value: TObject): TStringBuilder;
begin
{$ifdef GEN_SUPPORT}
  Insert(Index, Value.ToString());
{$else}
  Insert(Index, IntToStr(Integer(Value)));
{$endif}
  Result := Self;
end;

function TStringBuilder.Insert(Index: Integer; const Value: Int64): TStringBuilder;
begin
  Insert(Index, IntToStr(Value));
  Result := Self;
end;

function TStringBuilder.Insert(Index: Integer; const Value: Single): TStringBuilder;
begin
  Insert(Index, FloatToStr(Value));
  Result := Self;
end;

function TStringBuilder.Insert(Index: Integer; const Value: string): TStringBuilder;
begin
  if Index < 0 then
    raise ERangeError.CreateResFmt(@SParamIsNegative, ['Index']); // DO NOT LOCALIZE
  if Index > Length then
    raise ERangeError.CreateResFmt(@SListIndexError, [Index]);

  Length := Length + System.Length(Value);
  Move(FData[Index], FData[Index + System.Length(Value)], (Length - System.Length(Value) - Index) * SizeOf(Char));
  Move(Value[Low(string)], FData[Index], System.Length(Value) * SizeOf(Char));
  Result := Self;
end;

function TStringBuilder.Insert(Index: Integer; const Value: Word): TStringBuilder;
begin
  Insert(Index, IntToStr(Value));
  Result := Self;
end;

function TStringBuilder.Insert(Index: Integer; const Value: Shortint): TStringBuilder;
begin
  Insert(Index, IntToStr(Value));
  Result := Self;
end;

function TStringBuilder.Insert(Index: Integer;
  const Value: TCharArray): TStringBuilder;
begin
  if Index < 0 then
    raise ERangeError.CreateResFmt(@SParamIsNegative, ['Index']); // DO NOT LOCALIZE
  if Index > Length then
    raise ERangeError.CreateResFmt(@SListIndexError, [Index]);

  Length := Length + System.Length(Value);
  Move(FData[Index], FData[Index + System.Length(Value)], System.Length(Value) * SizeOf(Char));
  Move(Value[0], FData[Index], System.Length(Value) * SizeOf(Char));
  Result := Self;
end;

function TStringBuilder.Insert(Index: Integer; const Value: Currency): TStringBuilder;
begin
  Insert(Index, CurrToStr(Value));
  Result := Self;
end;

function TStringBuilder.Insert(Index: Integer; const Value: Char): TStringBuilder;
begin
  if Index < 0 then
    raise ERangeError.CreateResFmt(@SParamIsNegative, ['Index']); // DO NOT LOCALIZE
  if Index > Length then
    raise ERangeError.CreateResFmt(@SListIndexError, [Index]);

  Length := Length + 1;
  Move(FData[Index], FData[Index + 1], (Length - Index - 1) * SizeOf(Char));
  FData[Index] := Value;
  Result := Self;
end;

function TStringBuilder.Insert(Index: Integer; const Value: Byte): TStringBuilder;
begin
  Insert(Index, IntToStr(Value));
  Result := Self;
end;

function TStringBuilder.Insert(Index: Integer; const Value: Double): TStringBuilder;
begin
  Insert(Index, FloatToStr(Value));
  Result := Self;
end;

function TStringBuilder.Insert(Index: Integer; const Value: Integer): TStringBuilder;
begin
  Insert(Index, IntToStr(Value));
  Result := Self;
end;

function TStringBuilder.Insert(Index: Integer; const Value: Smallint): TStringBuilder;
begin
  Insert(Index, IntToStr(Value));
  Result := Self;
end;

function TStringBuilder.Insert(Index: Integer; const Value: Boolean): TStringBuilder;
begin
  Insert(Index, BoolToStr(Value, True));
  Result := Self;
end;

function TStringBuilder.Insert(Index: Integer; const Value: string;
  Count: Integer): TStringBuilder;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Insert(Index, Value);
  Result := Self;
end;

function TStringBuilder.Insert(Index: Integer; const Value: TCharArray; StartIndex,
  CharCount: Integer): TStringBuilder;
begin
  if Index - 1 >= Length then
    raise ERangeError.CreateResFmt(@SListIndexError, [Index])
  else if Index < 0 then
    raise ERangeError.CreateResFmt(@SListIndexError, [Index]);
  if StartIndex < 0 then
    raise ERangeError.CreateResFmt(@SParamIsNegative, ['StartIndex']); // DO NOT LOCALIZE
  if CharCount < 0 then
    raise ERangeError.CreateResFmt(@SParamIsNegative, ['CharCount']); // DO NOT LOCALIZE
  if StartIndex + CharCount > System.Length(Value) then
    raise ERangeError.CreateResFmt(@SInputBufferExceed,
      ['StartIndex', StartIndex, 'CharCount', CharCount]);

  Length := Length + CharCount;

  if Length - Index > 0 then
    Move(FData[Index], FData[Index + CharCount], (Length - Index) * SizeOf(Char));
  Move(Value[StartIndex], FData[Index], CharCount * SizeOf(Char));
  Result := Self;
end;

function TStringBuilder.Insert(Index: Integer; const Value: Cardinal): TStringBuilder;
begin
  Insert(Index, IntToStr(Value));
  Result := self;
end;

function TStringBuilder.Insert(Index: Integer; const Value: UInt64): TStringBuilder;
begin
  Insert(Index, UIntToStr(Value));
  Result := self;
end;

procedure TStringBuilder.ReduceCapacity;
var
  NewCapacity: Integer;
begin
  if Length > Capacity div 4 then
    Exit;

  NewCapacity := Capacity div 2;
  if NewCapacity < Length then
    NewCapacity := Length;
  Capacity := NewCapacity;
end;

function TStringBuilder.Remove(StartIndex, RemLength: Integer): TStringBuilder;
begin
  if RemLength <> 0 then
  begin
    if StartIndex < 0 then
      raise ERangeError.CreateResFmt(@SParamIsNegative, ['StartIndex']); // DO NOT LOCALIZE
    if RemLength < 0 then
      raise ERangeError.CreateResFmt(@SParamIsNegative, ['RemLength']); // DO NOT LOCALIZE
    CheckBounds(StartIndex);
    CheckBounds(StartIndex + RemLength - 1);

    if (Length - (StartIndex + RemLength)) > 0 then
      Move(FData[StartIndex + RemLength], FData[StartIndex], (Length - (StartIndex + RemLength)) * SizeOf(Char));
    Length := Length - RemLength;

    ReduceCapacity;
  end;
  Result := Self;
end;

function TStringBuilder.Replace(const OldValue, NewValue: string; StartIndex,
  Count: Integer): TStringBuilder;
var
  CurPtr: PChar;
  EndPtr: PChar;
  Index: Integer;
  EndIndex: Integer;
  OldLen, NewLen: Integer;
begin
  Result := Self;

  if Count <> 0 then
  begin
    if StartIndex < 0 then
      raise ERangeError.CreateResFmt(@SParamIsNegative, ['StartIndex']); // DO NOT LOCALIZE
    if Count < 0 then
      raise ERangeError.CreateResFmt(@SParamIsNegative, ['Count']); // DO NOT LOCALIZE
    if StartIndex + Count > Length then
      raise ERangeError.CreateResFmt(@SInputBufferExceed,
        ['StartIndex', StartIndex, 'Count', Count]);

    OldLen := System.Length(OldValue);
    NewLen := System.Length(NewValue);
    Index := StartIndex;
    CurPtr := @FData[StartIndex];
    EndIndex := StartIndex + Count - OldLen;
    EndPtr := @FData[EndIndex];

    while CurPtr <= EndPtr do
    begin
      if CurPtr^ = OldValue[Low(string)] then
      begin
        if StrLComp(CurPtr, PChar(OldValue), OldLen) = 0 then
        begin
          if _Replace(Index, OldValue, NewValue) then
          begin
            CurPtr := @FData[Index];
            EndPtr := @FData[EndIndex];
          end;
          Inc(CurPtr, NewLen - 1);
          Inc(Index, NewLen - 1);
          Inc(EndPtr, NewLen - OldLen);
          Inc(EndIndex, NewLen - OldLen);
        end;
      end;

      Inc(CurPtr);
      Inc(Index);
    end;
  end;
end;

function TStringBuilder.Replace(const OldChar, NewChar: Char; StartIndex,
  Count: Integer): TStringBuilder;
var
  Ptr: PChar;
  EndPtr: PChar;
begin
  if Count <> 0 then
  begin
    if StartIndex < 0 then
      raise ERangeError.CreateResFmt(@SParamIsNegative, ['StartIndex']); // DO NOT LOCALIZE
    if Count < 0 then
      raise ERangeError.CreateResFmt(@SParamIsNegative, ['Count']); // DO NOT LOCALIZE
    CheckBounds(StartIndex);
    CheckBounds(StartIndex + Count - 1);

    EndPtr := @FData[StartIndex + Count - 1];
    Ptr := @FData[StartIndex];
    while Ptr <= EndPtr do
    begin
      if Ptr^ = OldChar then
        Ptr^ := NewChar;
      Inc(Ptr);
    end;
  end;
  Result := Self;
end;

function TStringBuilder.Replace(const OldChar, NewChar: Char): TStringBuilder;
var
  Ptr: PChar;
  EndPtr: PChar;
begin
  EndPtr := @FData[Length - 1];
  Ptr := @FData[0];
  while Ptr <= EndPtr do
  begin
    if Ptr^ = OldChar then
      Ptr^ := NewChar;
    Inc(Ptr);
  end;
  Result := Self;
end;

function TStringBuilder.Replace(const OldValue, NewValue: string): TStringBuilder;
begin
  Result := self;
  Replace(OldValue, NewValue, 0, Length);
end;

procedure TStringBuilder.SetCapacity(Value: Integer);
begin
  if Value < Length then
    raise ERangeError.CreateResFmt(@SListCapacityError, [Value]);
  if Value > FMaxCapacity then
    raise ERangeError.CreateResFmt(@SListCapacityError, [Value]);

  System.SetLength(FData, Value);
end;

procedure TStringBuilder.SetChars(Index: Integer; Value: Char);
begin
  if Index < 0 then
    raise ERangeError.CreateResFmt(@SParamIsNegative, ['Index']); // DO NOT LOCALIZE
  CheckBounds(Index);

  FData[Index] := Value;
end;

procedure TStringBuilder.SetLength(Value: Integer);
var
  LOldLength: Integer;
begin
  if Value < 0 then
    raise ERangeError.CreateResFmt(@SParamIsNegative, ['Value']); // DO NOT LOCALIZE
  if Value > MaxCapacity then
    raise ERangeError.CreateResFmt(@SListCapacityError, [Value]);

  LOldLength := FLength;
  try
    FLength := Value;
    if FLength > Capacity then
      ExpandCapacity;
  except
    on E: EOutOfMemory do
    begin
      FLength := LOldLength;
      raise;
    end;
  end;
end;

function TStringBuilder.ToString: string;
begin
  SetString(Result, MarshaledString(FData), Length);
end;

function TStringBuilder.ToString(StartIndex, StrLength: Integer): string;
begin
  if StrLength <> 0 then
  begin
    if StartIndex < 0 then
      raise ERangeError.CreateResFmt(@SParamIsNegative, ['StartIndex']); // DO NOT LOCALIZE
    if StrLength < 0 then
      raise ERangeError.CreateResFmt(@SParamIsNegative, ['StrLength']); // DO NOT LOCALIZE
    CheckBounds(StartIndex);
    CheckBounds(StartIndex + StrLength - 1);

    Result := string.Create(FData, StartIndex, StrLength);
  end else
    Result := '';
end;

function TStringBuilder._Replace(Index: Integer; const Old, New: string): Boolean;
var
  OldLength: Integer;
  OldCapacity: Integer;
  SizeChange: Integer;
begin
  Result := False;
  SizeChange := System.Length(New) - System.Length(Old);

  if SizeChange = 0 then
  begin
    Move(New[Low(string)], FData[Index], System.Length(New) * SizeOf(Char));
  end
  else
  begin
    OldLength := Length;
    if SizeChange > 0 then
    begin
      OldCapacity := Capacity;
      Length := Length + SizeChange;
      if OldCapacity <> Capacity then
        Result := True;
    end;

    Move(FData[Index + System.Length(Old)], FData[Index + System.Length(New)],
      (OldLength - (System.Length(Old) + Index)) * SizeOf(Char));
    Move(New[Low(String)], FData[Index], System.Length(New) * SizeOf(Char));

    if SizeChange < 0 then
      Length := Length + SizeChange;
  end;
end;
{$endif}
end.
