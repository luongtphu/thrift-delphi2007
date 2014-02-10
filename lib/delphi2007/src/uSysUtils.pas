 {
  Develop to replace Generic.Collection/ThriftCollection Delphi version less 2010
  luongtphu@gmail.com
  Date:Nov 20 2013
 }
unit uSysUtils;

interface
uses Windows,SysUtils;

const
  TwoDigitLookup : packed array[0..99] of array[1..2] of Char =
    ('00','01','02','03','04','05','06','07','08','09',
     '10','11','12','13','14','15','16','17','18','19',
     '20','21','22','23','24','25','26','27','28','29',
     '30','31','32','33','34','35','36','37','38','39',
     '40','41','42','43','44','45','46','47','48','49',
     '50','51','52','53','54','55','56','57','58','59',
     '60','61','62','63','64','65','66','67','68','69',
     '70','71','72','73','74','75','76','77','78','79',
     '80','81','82','83','84','85','86','87','88','89',
     '90','91','92','93','94','95','96','97','98','99');

  function UIntToStr(Value: Cardinal): string;overload;
  function UIntToStr(Value: UInt64): string;overload;
  function _IntToStr32(Value: Cardinal; Negative: Boolean): string;
  function _IntToStr64(Value: UInt64; Negative: Boolean): string;
  function BytesToString(t:TBytes):string;
  function BytesOf(const Val: Pointer; const Len: integer): TBytes; overload;
  function StringBytesOf(const Val: string): TBytes; overload;
  function CharInSet(C: AnsiChar; const CharSet: TSysCharSet): Boolean;
  
implementation
function _IntToStr32(Value: Cardinal; Negative: Boolean): string;
var
  I, J, K : Cardinal;
  Digits  : Integer;
  P       : PChar;
  NewLen  : Integer;
begin
  I := Value;
  if I >= 10000 then
    if I >= 1000000 then
      if I >= 100000000 then
        Digits := 9 + Ord(I >= 1000000000)
      else
        Digits := 7 + Ord(I >= 10000000)
    else
      Digits := 5 + Ord(I >= 100000)
  else
    if I >= 100 then
      Digits := 3 + Ord(I >= 1000)
    else
      Digits := 1 + Ord(I >= 10);
  NewLen  := Digits + Ord(Negative);
  SetLength(Result, NewLen);
  P := PChar(Result);
  P^ := '-';
  Inc(P, Ord(Negative));
  if Digits > 2 then
    repeat
      J  := I div 100;           {Dividend div 100}
      K  := J * 100;
      K  := I - K;               {Dividend mod 100}
      I  := J;                   {Next Dividend}
      Dec(Digits, 2);
      PDWord(P + Digits)^ := PDWord(@TwoDigitLookup[K])^;
    until Digits <= 2;
  if Digits = 2 then
    PDWord(P+ Digits-2)^ := PDWord(@TwoDigitLookup[I])^
  else
    PChar(P)^ := Char(I or ord('0'));
end;

function _IntToStr64(Value: UInt64; Negative: Boolean): string;
var
  I64, J64, K64      : UInt64;
  I32, J32, K32, L32 : Cardinal;
  Digits             : Byte;
  P                  : PChar;
  NewLen             : Integer;
begin
  {Within Integer Range - Use Faster Integer Version}
  if (Negative and (Value <= High(Integer))) or
     (not Negative and (Value <= High(Cardinal))) then
     begin
       result:=_IntToStr32(Value, Negative);
       Exit;
     end;


  I64 := Value;
  if I64 >= 100000000000000 then
    if I64 >= 10000000000000000 then
      if I64 >= 1000000000000000000 then
        if I64 >= 10000000000000000000 then
          Digits := 20
        else
          Digits := 19
      else
        Digits := 17 + Ord(I64 >= 100000000000000000)
    else
      Digits := 15 + Ord(I64 >= 1000000000000000)
  else
    if I64 >= 1000000000000 then
      Digits := 13 + Ord(I64 >= 10000000000000)
    else
      if I64 >= 10000000000 then
        Digits := 11 + Ord(I64 >= 100000000000)
      else
        Digits := 10;
  NewLen  := Digits + Ord(Negative);
  SetLength(Result, NewLen);
  P := PChar(Result);
  P^ := '-';
  Inc(P, Ord(Negative));
  if Digits = 20 then
  begin
    P^ := '1';
    Inc(P);
    Dec(I64, 10000000000000000000);
    Dec(Digits);
  end;
  if Digits > 17 then
  begin {18 or 19 Digits}
    if Digits = 19 then
    begin
      P^ := '0';
      while I64 >= 1000000000000000000 do
      begin
        Dec(I64, 1000000000000000000);
        Inc(P^);
      end;
      Inc(P);
    end;
    P^ := '0';
    while I64 >= 100000000000000000 do
    begin
      Dec(I64, 100000000000000000);
      Inc(P^);
    end;
    Inc(P);
    Digits := 17;
  end;
  J64 := I64 div 100000000;
  K64 := I64 - (J64 * 100000000); {Remainder = 0..99999999}
  I32 := K64;
  J32 := I32 div 100;
  K32 := J32 * 100;
  K32 := I32 - K32;
  PDWord(P + Digits - 2)^ := PDWord(@TwoDigitLookup[K32])^;
  I32 := J32 div 100;
  L32 := I32 * 100;
  L32 := J32 - L32;
  PDWord(P + Digits - 4)^ := PDWord(@TwoDigitLookup[L32])^;
  J32 := I32 div 100;
  K32 := J32 * 100;
  K32 := I32 - K32;
  PDWord(P + Digits - 6)^ := PDWord(@TwoDigitLookup[K32])^;
  PDWord(P + Digits - 8)^ := PDWord(@TwoDigitLookup[J32])^;
  Dec(Digits, 8);
  I32 := J64; {Dividend now Fits within Integer - Use Faster Version}
  if Digits > 2 then
    repeat
      J32 := I32 div 100;
      K32 := J32 * 100;
      K32 := I32 - K32;
      I32 := J32;
      Dec(Digits, 2);
      PDWord(P + Digits)^ := PDWord(@TwoDigitLookup[K32])^;
    until Digits <= 2;
  if Digits = 2 then
    PDWord(P + Digits-2)^ := PDWord(@TwoDigitLookup[I32])^
  else
    P^ := Char(I32 or ord('0'));
end;

function UIntToStr(Value: Cardinal): string;
begin
  Result := _IntToStr32(Value, False);
end;

function UIntToStr(Value: UInt64): string;
begin
  Result := _IntToStr64(Value, False);
end;

function BytesToString(t:TBytes):string;
begin
  result:=string(t);
end;

function BytesOf(const Val: Pointer; const Len: integer): TBytes;
begin
  SetLength(Result, Len);
  Move(PByte(Val)^, Result[0], Len);
end;

function StringBytesOf(const Val: string): TBytes; overload;
var
n:integer;
begin
setlength(result,0);
n:=length(Val);
if (n<=0) then exit;
result:=BytesOf(pchar(Val),n);
end;

function CharInSet(C: AnsiChar; const CharSet: TSysCharSet): Boolean;
begin
  Result := C in CharSet;
end;

end.
