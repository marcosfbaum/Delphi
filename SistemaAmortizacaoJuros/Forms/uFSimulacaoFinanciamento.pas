unit uFSimulacaoFinanciamento;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.UITypes, System.Generics.Collections,
  System.Math,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Firedac.Comp.Client, UFDMemTableHelper, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ComCtrls, uTEditHelper, uException.Validation, uTDBGridHelper,
  uFinance.Controller, uIFinancing, uFinancing, uInstallment, uSystemUtils,
  uResources.Utils;

type
  TFSimulacaoFinanciamento = class(TForm)
    pnAll: TPanel;
    pnBottom: TPanel;
    btnClose: TButton;
    gbEntradaDados: TGroupBox;
    btnCalculate: TButton;
    edCapital: TEdit;
    Label1: TLabel;
    dbgAmortizacao: TDBGrid;
    gbTotais: TGroupBox;
    edLastInstallment: TEdit;
    Label2: TLabel;
    edAmortization: TEdit;
    Label3: TLabel;
    edTotalPay: TEdit;
    Label4: TLabel;
    cbInstallment: TComboBox;
    Label5: TLabel;
    Label6: TLabel;
    btnCancel: TButton;
    edInterestRate: TEdit;
    Label7: TLabel;
    edTotalInterest: TEdit;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edCapitalKeyPress(Sender: TObject; var Key: Char);
    procedure dbgAmortizacaoDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgAmortizacaoTitleClick(Column: TColumn);
    procedure btnCalculateClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edCapitalExit(Sender: TObject);
    procedure edInterestRateKeyPress(Sender: TObject; var Key: Char);
    procedure edCapitalEnter(Sender: TObject);
  private
    FMtAmortizacaoJuros: TFdmemTable;
    FDsAmortizacaoJuros: TDataSource;
    FFinanceController: TFinanceController;
    procedure InitializeInstallments();
    procedure PrepareDataset();
    procedure SetComponents();
    procedure ClearFormValues;
    procedure ClearDataset;
    procedure BasicValidate();
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TFSimulacaoFinanciamento.BasicValidate;
var
  LValueCapital: Currency;
begin
  if Trim(edInterestRate.Text).IsEmpty then
    raise EValidation.Create('Informe a taxa de juros.', edInterestRate);

  if (cbInstallment.ItemIndex = -1) then
    raise EValidation.Create('Informe a quantidade de parcelas', cbInstallment);

  if Trim(edCapital.Text).IsEmpty then
    raise EValidation.Create('Informe o capital.', edCapital);

  if not TryStrToCurr(TSystemUtils.NumbersOnly(edCapital.Text), LValueCapital) then
    raise EValidation.Create('Capital informado é inválido.', edCapital);

  if (FMtAmortizacaoJuros.RecordCount > 0) then
  begin
    if MessageDlg(Concat('Deseja realizar nova simulação? ', sLineBreak, 'Os dados da simulação atual serão perdidos.'), mtConfirmation, mbYesNo, 0, mbNo) <> mrYes then
      Exit;

    ClearDataset();
  end;
end;

procedure TFSimulacaoFinanciamento.btnCalculateClick(Sender: TObject);
var
  LOutFinancing: TFinancing;
  Linstallment: TInstallment;
  LValueCapital: Currency;
begin
  BasicValidate();

  LValueCapital := StrToFloat(TSystemUtils.NumbersOnly(edCapital.Text));

  LOutFinancing := TFinancing.Create;
  try
    LOutFinancing.InterestRate         := StrToCurr(edInterestRate.Text);
    LOutFinancing.Quantityinstallments := Integer(cbInstallment.Items.Objects[cbInstallment.ItemIndex]);
    LOutFinancing.Capital              := IfThen((LValueCapital > 0), LValueCapital / 100, LValueCapital);

    FFinanceController.CalculateFinancing(LOutFinancing);

    for Linstallment in LOutFinancing.Installments do
      FMtAmortizacaoJuros.AppendRecord(
        [ Linstallment.InstallmentNumber,
          Linstallment.AmountInterest,
          Linstallment.OutstandingBalance ]);

    if not FMtAmortizacaoJuros.Bof then
      FMtAmortizacaoJuros.First;

    edLastInstallment.Text := LOutFinancing.LastInstallmentNumber.ToString;
    edAmortization.Text    := edCapital.Text;
    edTotalPay.Text        := FormatCurr(',0.00', LOutFinancing.TotalOutstandingBalance);
    edTotalInterest.Text   := FormatCurr(',0.00', LOutFinancing.TotalInterest);
  finally
    LOutFinancing.Free;
  end;
end;

procedure TFSimulacaoFinanciamento.btnCancelClick(Sender: TObject);
begin
  ClearFormValues;
end;

procedure TFSimulacaoFinanciamento.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFSimulacaoFinanciamento.dbgAmortizacaoDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  dbgAmortizacao.ZebrarDBGrid(Rect, DataCol, Column, State);
end;

procedure TFSimulacaoFinanciamento.dbgAmortizacaoTitleClick(Column: TColumn);
begin
  dbgAmortizacao.OnUserTitleClick(Column);
end;

procedure TFSimulacaoFinanciamento.edCapitalEnter(Sender: TObject);
begin
  edCapital.Clear;
end;

procedure TFSimulacaoFinanciamento.edCapitalExit(Sender: TObject);
var
  LOutValue: Currency;
begin
  if Trim(edCapital.Text).IsEmpty then
    Exit;

  if (not TryStrToCurr(edCapital.Text, LOutValue)) then
    raise EValidation.Create('Informe um valor válido para o capital;', edCapital);

  edCapital.Text := FormatCurr(',0.00', LOutValue);
end;

procedure TFSimulacaoFinanciamento.edCapitalKeyPress(Sender: TObject; var Key: Char);
begin
  if CharInSet(key, [#13, #27]) then
    Exit;

  if not edCapital.IsNumber(Key) then
  begin
    key := #0;
    raise EValidation.Create('Informe apenas números para o capital.', edCapital);
  end;
end;

procedure TFSimulacaoFinanciamento.edInterestRateKeyPress(Sender: TObject; var Key: Char);
begin
  if CharInSet(key, [#13, #27]) then
    Exit;

  if not edInterestRate.IsNumberOrComma(Key) then
  begin
    key := #0;
    raise EValidation.Create('Informe apenas números e vírgula para a taxa de juros.', edInterestRate);
  end;
end;

procedure TFSimulacaoFinanciamento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FMtAmortizacaoJuros.Free;
  FFinanceController.Free;
end;

procedure TFSimulacaoFinanciamento.FormCreate(Sender: TObject);
begin
  FMtAmortizacaoJuros := TFDMemTable.Create(nil);
  FDsAmortizacaoJuros := TDataSource.Create(FMtAmortizacaoJuros);

  SetComponents();
  PrepareDataset();

  FFinanceController := TFinanceController.Create;

  InitializeInstallments();
end;

procedure TFSimulacaoFinanciamento.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case key of
    VK_ESCAPE:
      begin
        if (MessageDlg('Deseja realmente fechar a tela de simulação de financiamento?', mtConfirmation, mbYesNo, 0) = mrYes) then
          Close;
      end;
  end;
end;

procedure TFSimulacaoFinanciamento.FormShow(Sender: TObject);
begin
  ClearFormValues;
end;

procedure TFSimulacaoFinanciamento.InitializeInstallments;
var
  LItems: TList<Integer>;
  I: Integer;
begin
  LItems := TList<Integer>.Create;
  try
    FFinanceController.GetDefaultInstallments(Litems);

    for I in LItems do
      cbInstallment.Items.AddObject(I.ToString, TObject(I));
  finally
    LItems.Free;
  end;
end;

procedure TFSimulacaoFinanciamento.PrepareDataset;
begin
  FMtAmortizacaoJuros.FieldDefs.BeginUpdate;
  try
    if (FMtAmortizacaoJuros.FieldDefs.Count > 0) then
    FMtAmortizacaoJuros.FieldDefs.Clear;

    FMtAmortizacaoJuros.FieldDefs.Add('PARCELA', ftSmallint);
    FMtAmortizacaoJuros.FieldDefs.Add('JUROS', ftCurrency);
    FMtAmortizacaoJuros.FieldDefs.Add('SALDO DEVEDOR', ftCurrency);
  finally
    FMtAmortizacaoJuros.FieldDefs.EndUpdate;
  end;

  ClearDataset();
end;

procedure TFSimulacaoFinanciamento.SetComponents;
begin
  FDsAmortizacaoJuros.DataSet := FMtAmortizacaoJuros;
  dbgAmortizacao.DataSource   := FDsAmortizacaoJuros;
end;

procedure TFSimulacaoFinanciamento.ClearFormValues;
begin
  edInterestRate.Clear;
  cbInstallment.ItemIndex := -1;
  edCapital.Clear;
  edLastInstallment.Clear;
  edAmortization.Clear;
  edTotalPay.Clear;
  edTotalInterest.Clear;

  if (not FMtAmortizacaoJuros.IsEmpty) then
    ClearDataset();

  if edInterestRate.CanFocus then
    edInterestRate.SetFocus;
end;

procedure TFSimulacaoFinanciamento.ClearDataset();
begin
  FMtAmortizacaoJuros.Close;
  FMtAmortizacaoJuros.Open;
  FMtAmortizacaoJuros.EmptyDataSet;
  FMtAmortizacaoJuros.LogChanges := False;
  FMtAmortizacaoJuros.CreateIndices;
  dbgAmortizacao.FormatCurrencyFields();
end;

end.
