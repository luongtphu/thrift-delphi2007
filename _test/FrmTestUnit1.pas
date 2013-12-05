unit FrmTestUnit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses uSysUtils,uStringBuilder,uCollections;
{$R *.dfm}
procedure TForm1.Button1Click(Sender: TObject);
var
t:TStringBuilder;
a:TBytes;
begin
setlength(a,3);
a[0]:=65;
a[1]:=66;
a[2]:=67;
ShowMessage(string(a));
//Test String Builder
t:=TStringBuilder.Create;
t.Append('Test 1');
t.Append('Test 2');
t.Append('Test 3');
t.Append($FFFFFFF0);
ShowMessage(t.ToString);
t.Free;

end;

procedure TForm1.Button2Click(Sender: TObject);
var
t:TuDictionary_V_V;
v:variant;
tl:TuList_V;
begin

t:=TuDictionary_V_V.Create(0);
t.Add('a1','b1');
t.Add('a2','b2');
t.Add('a3','b3');
ShowMessage('Count..'+inttostr(t.Count));
t.Remove('a1');
ShowMessage('Count..'+inttostr(t.Count));
ShowMessage(t.AsString('a2'));
t.Free;
{
tl:=TuList_V.Create;
tl.Add('A Test 1');
tl.Add('D Test 2');
tl.Add('Z Test 3');
tl.Add('C Test 4');

ShowMessage('Count:'+inttostr(tl.Count));
ShowMessage(tl.Last.AsString);
tl.Remove('A Test 1');
ShowMessage('Count:'+inttostr(tl.Count));
ShowMessage(tl.First.AsString);
tl.Sort;
ShowMessage(tl.Last.AsString);
tl.DeleteRange(2,1);
ShowMessage('Count:'+inttostr(tl.Count));
ShowMessage(tl.Last.AsString);
tl.Free;
}
end;


end.
