unit UStudentRegistration;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.Math, System.UItypes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFRegistrationTemplate, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore,
  dxSkinsDefaultPainters, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, dxDateRanges, cxGridCustomTableView, cxGridTableView,
  cxGridLevel, cxClasses, cxGridCustomView, cxGrid, cxDataUtils, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.WinXCtrls, Vcl.ExtCtrls,
  Data.DB, uIConexaoDatabase, uStudentEntity, uException.Validation;

type
  TFStudentRegistration = class(TFRegistrationTemplate)
    gvRegisters_MATRICULA: TcxGridColumn;
    gvRegisters_NOME_ALUNO: TcxGridColumn;
    gvRegisters_ENDERECO: TcxGridColumn;
    gvRegisters_TELEFONE: TcxGridColumn;
    gvRegisters_CPF: TcxGridColumn;
    Label1: TLabel;
    edMatricula: TEdit;
    Label2: TLabel;
    edNome: TEdit;
    Label3: TLabel;
    edEndereco: TEdit;
    edCPF: TEdit;
    Label5: TLabel;
    edFone: TEdit;
    Label4: TLabel;
    gvRegisters_ID: TcxGridColumn;
    Label6: TLabel;
    edID: TEdit;
    procedure sbFilterChange(Sender: TObject);
    procedure btnShowAllClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSaveClick(Sender: TObject);
    procedure btnNewDataClick(Sender: TObject);
    procedure gvRegistersKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FStudentEntity: TStudentEntity;
    procedure EditStudent(const aSelectedRow: Integer);
    procedure Validate;
    procedure ClearData;
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TFStudentRegistration.sbFilterChange(Sender: TObject);
var
  Ldataset: TDataset;
begin
  inherited;

  if sbFilter.Text = EmptyStr then
    Exit;

// No filtro pode ser passado SQL já definido ou apenas a entidade e seus parâmetros.
  FService.AddParamsDB('NOME_ALUNO', sbFilter.Text, ftString, True);
//  LDataset := FService.Filter(rsFilterSQL); //Assim tb funciona
  LDataset := FService.Filter(FStudentEntity, ['NOME_ALUNO']);

  if Assigned(Ldataset) then
  begin
    try
      ShowData(LDataset);
    finally
      Ldataset.Free;
    end;
  end;
end;

procedure TFStudentRegistration.btnNewDataClick(Sender: TObject);
begin
  inherited;
  ClearData();
  edMatricula.SetFocus;
end;

procedure TFStudentRegistration.btnSaveClick(Sender: TObject);
begin
  FStudentEntity.ID        := IfThen(Trim(edID.Text).IsEmpty, 0, StrToIntDef(edID.Text, 0));
  FStudentEntity.Matricula := edMatricula.Text;
  FStudentEntity.Nome      := edNome.Text;
  FStudentEntity.Endereco  := edEndereco.Text;
  FStudentEntity.Telefone  := edFone.Text;
  FStudentEntity.CPF       := edCPF.Text;

  Validate();
  try
    FService.StartTransaction;
    FService.Save(FStudentEntity);
    FService.Commit;

    ClearData();

    inherited;
  except
    on E: Exception do
    begin
      FService.Rollback;
      MessageDlg('Erro ao gravar os dados do estudante. ' + sLineBreak + 'Detalhes: ' + e.Message, mtError, [mbOK], 0);
    end;
  end;
end;

procedure TFStudentRegistration.btnShowAllClick(Sender: TObject);
var
  LDataset: TDataSet;
begin
  inherited;

  LDataset := FService.GetAll(FStudentEntity);
  if Assigned(LDataset) then
  begin
    try
      ShowData(LDataset);
    finally
      LDataset.Free;
    end;
  end;
end;

procedure TFStudentRegistration.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FStudentEntity.Free;
  inherited;
end;

procedure TFStudentRegistration.FormCreate(Sender: TObject);
begin
  inherited;
  FStudentEntity := TStudentEntity.Create;
end;

procedure TFStudentRegistration.gvRegistersKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  case Key of
    VK_RETURN:
      begin
        EditStudent(GetSelectedRow());
        sbFilter.Clear;
      end;
  end;
end;

procedure TFStudentRegistration.EditStudent(const aSelectedRow: Integer);
begin
  edID.Text         := GetValueFromIndex(aSelectedRow, gvRegisters_ID.Index);
  edMatricula.Text  := GetValueFromIndex(aSelectedRow, gvRegisters_MATRICULA.Index);
  edNome.Text       := GetValueFromIndex(aSelectedRow, gvRegisters_NOME_ALUNO.Index);
  edEndereco.Text   := GetValueFromIndex(aSelectedRow, gvRegisters_ENDERECO.Index);
  edFone.Text       := GetValueFromIndex(aSelectedRow, gvRegisters_TELEFONE.Index);
  edCPF.Text        := GetValueFromIndex(aSelectedRow, gvRegisters_CPF.Index);
  edNome.SetFocus;
end;

procedure TFStudentRegistration.Validate();
begin
  if FStudentEntity.Matricula.Trim.IsEmpty then
    raise EValidation.Create('Informe a matrícula.', edMatricula);

  if FStudentEntity.Nome.Trim.IsEmpty then
    raise EValidation.Create('Informe o nome.', edNome);

  if FStudentEntity.Endereco.Trim.IsEmpty then
    raise EValidation.Create('Informe o endereço.', edEndereco);

  if FStudentEntity.Telefone.Trim.IsEmpty then
    raise EValidation.Create('Informe o telefone.', edFone);

  if FStudentEntity.CPF.Trim.IsEmpty then
    raise EValidation.Create('Informe o CPF.', edCPF);
end;

procedure TFStudentRegistration.ClearData();
begin
  edID.Clear;
  edMatricula.Enabled := True;
  edMatricula.Clear;
  edNome.Clear;
  edEndereco.Clear;
  edFone.Clear;
  edCPF.Clear;

  if Assigned(FStudentEntity) then
    FStudentEntity.Free;

  FStudentEntity := TStudentEntity.Create;
end;

end.
