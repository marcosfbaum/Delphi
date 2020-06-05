unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uInputQuery;

type
  TForm1 = class(TForm)
    btnAddInteger: TButton;
    AddIntegerArray: TButton;
    btnAddIntegerWithRangeValidation: TButton;
    AddIntegerArrayWithRangeValidation: TButton;
    mResults: TMemo;
    btnResetResult: TButton;
    procedure btnAddIntegerClick(Sender: TObject);
    procedure btnResetResultClick(Sender: TObject);
    procedure btnAddIntegerWithRangeValidationClick(Sender: TObject);
    procedure AddIntegerArrayClick(Sender: TObject);
    procedure AddIntegerArrayWithRangeValidationClick(Sender: TObject);
  private
    procedure WriteValue(const aValue: string);
    procedure Reset;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}



procedure TForm1.btnAddIntegerClick(Sender: TObject);
var
  LValue: Integer;
  LValidationFunc: TInputIntegerCloseQueryFunc;
begin
// Add Integer with anonymous function to validate data
  WriteValue('Add Integer - Start');
  LValue := 0;

  LValidationFunc := function(const aValue: Integer): Boolean
  begin
    Result := (aValue > 0);
    if (aValue <= 0) then
      MessageDlg('Valor deve ser maior que zero.', mterror, [mbok], 0);
  end;

  if TInputQuery.AddInteger('Add integer', 'Value', LValue, LValidationFunc) then
    WriteValue(LValue.ToString);

  WriteValue('Add Integer - End');
  WriteValue('');
end;

procedure TForm1.btnAddIntegerWithRangeValidationClick(Sender: TObject);
var
  LValue: Integer;
begin
// Add Integer with range validation
  WriteValue('Add Integer with range validation - Start');
  LValue := 0;

  if TInputQuery.AddIntegerInRange('Add integer', 'Value', 1, 100, LValue) then
    WriteValue(LValue.ToString);

  WriteValue('Add Integer with range validation - End');
  WriteValue('');
end;

procedure TForm1.AddIntegerArrayClick(Sender: TObject);
var
  LValues: array of Integer;
  LValue: Integer;
  LValidationFunc: TInputIntegerArrayCloseQueryFunc;
begin
// Add Integer Array with anonymous function to validate data array
  WriteValue('Add integer aArray- Start');
  SetLength(LValues, 4);

  LValidationFunc := function(const aValues: array of Integer): Boolean
  var
    LValue: Integer;
    LMsg: string;
  begin
    LMsg := Emptystr;

    for LValue in aValues do
    begin
      if LValue <= 0 then
        LMsg := LMsg + Format('%d, ', [ lvalue]);
    end;

    Result := Lmsg.IsEmpty;

    if (not LMsg.IsEmpty) then
      MessageDlg(Concat('Todos valores devem ser maior que zero.', sLineBreak, LMsg), mtError, [ mbOK ], 0);
  end;

  if TInputQuery.AddInteger('Add integer', [ 'Value 1', 'Value 2', 'Value 3', 'Value 4'], LValues, LValidationFunc) then
  begin
    for LValue in LValues do
      WriteValue(LValue.ToString);
  end;

  WriteValue('Add integer array - End');
  WriteValue('');
end;

procedure TForm1.AddIntegerArrayWithRangeValidationClick(Sender: TObject);
var
  LValues: array of Integer;
  LValue: Integer;
begin
// Add Integer Array with range validation
  WriteValue('Add integer array with range validation - Start');
  SetLength(LValues, 4);

  if TInputQuery.AddIntegerInRange('Add integer', [ 'Value 1', 'Value 2', 'Value 3', 'Value 4'], 1, 99, LValues) then
  begin
    for LValue in LValues do
      WriteValue(LValue.ToString);
  end;

  WriteValue('Add integer array with range validation - End');
  WriteValue('');
end;

procedure TForm1.WriteValue(const aValue: string);
begin
  mResults.Lines.Add(aValue);
end;

procedure TForm1.btnResetResultClick(Sender: TObject);
begin
  Reset();
end;

procedure TForm1.Reset();
begin
  mResults.Lines.Clear;
end;

end.
