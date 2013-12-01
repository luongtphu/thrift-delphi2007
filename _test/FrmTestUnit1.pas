unit FrmTestUnit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses uSysUtils,uStringBuilder;
{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
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

end.
