unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.UITypes,
  Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, UExeptionExtension, USubstitui;

type
  TFMain = class(TForm)
    edFrase: TEdit;
    edVelha: TEdit;
    edNova: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btnProcess: TButton;
    procedure btnProcessClick(Sender: TObject);
  private
    procedure ValidarEntradaDados;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMain: TFMain;

implementation

{$R *.dfm}

// Esta procedure efetua o processamento da de uma string e substituição da palavra velha por uma nova,
// caso haja ocorrências da mesma na frase e mostra o resultado do processamento.
procedure TFMain.btnProcessClick(Sender: TObject);
var
  ClassSubstitui: TSubstitui;
  strRetorno: string;
begin
  ValidarEntradaDados;
  try
    ClassSubstitui := TSubstitui.Create;
    try
      strRetorno := ClassSubstitui.Substituir(edFrase.Text, edVelha.Text, edNova.Text);
      MessageDlg(Concat(
        'Frase: ', QuotedStr(edFrase.Text), sLineBreak,
        'Velha: ', QuotedStr(edVelha.Text), sLineBreak,
        'Nova:  ', QuotedStr(edNova.Text),  sLineBreak,
        'Resultado: ', strRetorno),
        mtInformation, [mbOK], 0);
    finally
      ClassSubstitui.Free;
    end;
  except
    on E: Exception do
    begin
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
end;

//  Procedure utilizada para validar se os dados necessários foram informados.
procedure TFMain.ValidarEntradaDados;
begin
  if ((edFrase.Text) = EmptyStr) then
    raise EValidation.Create('Informe uma frase.', edFrase);

  if ((edVelha.Text) = EmptyStr) then
    raise EValidation.Create('Informe a parte do texto que será removida.', edVelha);

  if ((edNova.Text)= EmptyStr) then
    raise EValidation.Create('Informe a parte do texto que será adicionada.', edNova);
end;

end.
