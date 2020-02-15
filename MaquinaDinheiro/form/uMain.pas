unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, UMaquinaDinheiro, UTroco, Vcl.ComCtrls, UExeptionExtension, Vcl.Grids;

type
  TFMain = class(TForm)
    edValor: TEdit;
    Label1: TLabel;
    btnProcessarTroco: TButton;
    gbResultado: TGroupBox;
    Label2: TLabel;
    reTroco: TRichEdit;
    procedure btnProcessarTrocoClick(Sender: TObject);
  private
    { Private declarations }
  public
  var
  list: TList;
    { Public declarations }
  end;

var
  FMain: TFMain;

implementation

{$R *.dfm}

// Efetua o processo de troco para a máquina de dinheiro.
procedure TFMain.btnProcessarTrocoClick(Sender: TObject);
var
  cMaquinaDinheiro: TMaquinaDinheiro;
  lstTroco: TList;
  I: Integer;
  strListImpressao: TStringList;
  dValor: Double;
begin
  if StrToFloatDef(edvalor.Text, -1) < 0 then
    raise EValidation.Create('Informe um valor válido.', edValor);

  reTroco.Clear;
  cMaquinaDinheiro := TMaquinaDinheiro.Create;
  dValor := StrToFloat(edValor.Text);
  lstTroco := cMaquinaDinheiro.MontarTroco(dValor);
  try
    strListImpressao := cMaquinaDinheiro.MontarImpressao(lstTroco, dValor);
    try
      reTroco.Lines.Add(strListImpressao.Text);
    finally
      strListImpressao.Free;
    end;
  finally
    for I := 0 to lstTroco.Count -1 do
    begin
      if Assigned(lstTroco.Items[I]) then
        Dispose(lstTroco.Items[I]);
    end;
    lstTroco.Free;
    cMaquinaDinheiro.Free;
  end;
  edValor.SetFocus;
end;

end.
