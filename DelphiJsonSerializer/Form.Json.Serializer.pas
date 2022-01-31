unit Form.Json.Serializer;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  ServiceRestJson, uPeople, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    mmoJson: TMemo;
    gbPeople: TGroupBox;
    edName: TLabeledEdit;
    edAge: TLabeledEdit;
    gpAddress: TGroupBox;
    edStreet: TLabeledEdit;
    edNumber: TLabeledEdit;
    Panel1: TPanel;
    btnSerializeJson: TButton;
    btnDeserializeJson: TButton;
    btnClear: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnDeserializeJsonClick(Sender: TObject);
    procedure btnSerializeJsonClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
  private
    procedure ClearMemo();
    procedure DeserializeJson(const Value: string);
    procedure SerializeJson;
    function ValidateInputs: Boolean;
    procedure ClearInputs;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{ TForm1 }

procedure TForm1.btnSerializeJsonClick(Sender: TObject);
begin
  if not ValidateInputs() then
    Exit;

  SerializeJson();
  ClearInputs();
end;

procedure TForm1.btnClearClick(Sender: TObject);
begin
  ClearMemo();
  ClearInputs();
end;

procedure TForm1.btnDeserializeJsonClick(Sender: TObject);
begin
  if mmoJson.Lines.Text.Trim.IsEmpty then
    Exit;

  DeserializeJson(mmoJson.Lines.Text);
  ClearMemo();
end;

procedure TForm1.ClearMemo;
begin
  mmoJson.Lines.Clear;
end;

procedure TForm1.ClearInputs();
begin
  edName.Clear;
  edAge.Clear;
  edStreet.Clear;
  edNumber.Clear;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  edName.SetFocus;
  ClearMemo;
end;

procedure TForm1.DeserializeJson(const Value: string);
var
  LServiceRestJson: TServiceRestJson;
  LPeople: TPeople;
begin
  LServiceRestJson := TServiceRestJson.Create(nil);
  try
    LPeople := LServiceRestJson.GetPeople(mmoJson.Text);
    if not Assigned(LPeople) then
    begin
      MessageDlg('Wrong Json: ' + mmoJson.Text, mtError, [mbok], 0);
      Exit;
    end;
    try
      edName.Text := LPeople.Name;
      edAge.Text   := LPeople.AgeStr();
      edStreet.Text := LPeople.Address.Street;
      edNumber.Text := LPeople.Address.Number;
    finally
      LPeople.Free;
    end;
  finally
    if Assigned(LServiceRestJson) then
      LServiceRestJson.Free;
  end;
end;

procedure TForm1.SerializeJson();
var
  LServiceRestJson: TServiceRestJson;
  LPeople: TPeople;
begin
  LPeople := TPeople.Create(Self);
  try
    LPeople.Age := StrToInt(edAge.Text);
    LPeople.Name := edName.Text;
    LPeople.Address.Street := edStreet.Text;
    LPeople.Address.Number := edNumber.Text;

    LServiceRestJson := TServiceRestJson.Create(LPeople);
    try
      mmoJson.Lines.Text := LServiceRestJson.GetJson();
    finally
      LServiceRestJson.Free;
    end;
  finally
    LPeople.Free;
  end;
end;

function TForm1.ValidateInputs(): Boolean;
var
  LStringBuilderErrors: TStringBuilder;
begin
  Result := False;

  LStringBuilderErrors := TStringBuilder.Create;
  try
    if Trim(edName.Text).IsEmpty then
      LStringBuilderErrors.AppendLine('Name is required.');

    if StrToIntDef(Trim(edAge.Text), 0) = 0 then
      LStringBuilderErrors.AppendLine('Age is required.');

    if Trim(edStreet.Text).IsEmpty then
      LStringBuilderErrors.AppendLine('Street is required.');

    if Trim(edNumber.Text).IsEmpty then
      LStringBuilderErrors.AppendLine('Number is required.');

    if LStringBuilderErrors.Length = 0 then
      Exit(True);

    MessageDlg(LStringBuilderErrors.ToString, mtError, [mbok], 0);

  finally
    LStringBuilderErrors.Free;
  end;
end;

end.
