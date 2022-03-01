unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    CheckGroup1: TCheckGroup;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Sort;
  private

  public

  end;

type

  // базовый класс
  { TPerson }
  TPerson = class
    fName: string; // имя
    constructor Create(Name: string);
    function info: string; virtual;
  end;
  // класс Студент
  { TStud }
  TStud = class(TPerson)// номер группы
    fGr: string;
    constructor Create(Name: string; gr: string);
    function info: string;
      override;
  end;
  // класс Преподаватель
  { TProf }
  TProf = class(TPerson)
    fdep: string; // название кафедры
    constructor Create(Name: string; dep: string);
    function info: string;
      override;
  end;


const
  SZL = 10; // размер списка
  l=25;

var
  Form1: TForm1;
  List: array[1..SZL] of TPerson; // список
  //bb: array[1..L] of string;
  n: integer = 0; // кол-во людей в списке

implementation

{$R *.lfm}

{ TStud }

constructor TStud.Create(Name: string; gr: string);
begin
  inherited Create(Name);
  // вызвать конструктор базового класса
  fGr := gr;
end;

function TStud.info: string;
begin
   Result := fname + ' каф.' + fGr;
end;

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  if n < SZL then
  begin
    // добавить объект в список
    n := n + 1;
    if Radiobutton1.Checked then // создадим объект TStud
      List[n] := TStud.Create(Edit1.Text, Edit2.Text)
    else // создать объект TProf
      List[n] := TProf.Create(Edit1.Text, Edit2.Text);
    //очистить поля ввода
    Edit1.Text := ' ';
    Edit2.Text := ' ';
    Edit1.SetFocus; // курсор в поле Фамилия
  end
  else
    ShowMessage('Список заполнен!');
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i: integer; // индекс
  st: string; // список
begin
  for i := 1 to SZL do
    if list[i] <> nil then
      st := st + list[i].info + #13;
  ShowMessage('Список' + #13 + st);
end;

procedure TForm1.Sort;
var
i, tmp, n: Integer;
Sortik: Boolean;
begin
  Sortik:=True;
n:=0;
while Sortik do
  begin
    for i:=SZL to SZL-1-n do
     if List[i]>List[i+1] then
       begin
         Sortik:=True;
         tmp:=List[i]; List[i]:=List[i+1]; List[i+1]:=tmp;
       end;
   n:=n+1;
  end;
end;

{ TProf }
constructor TProf.Create(Name: string; dep: string);
begin
  inherited Create(Name);
  // вызвать конструктор базового класса
  fDep := dep;
end;

function TProf.info: string;
begin
  Result := fname + ' каф.' + fDep;
end;
{ TPerson }
constructor TPerson.Create(Name: string);
begin
  fName := Name;
end;

function TPerson.info: string;
begin
  Result := fname;
end;

end.
