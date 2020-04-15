unit uFRegistrationTemplate;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.UITypes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.WinXCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, dxSkinsCore, dxSkinsDefaultPainters, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, dxDateRanges, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Vcl.ComCtrls,
  uGenericService;

type
  TFRegistrationTemplate = class(TForm)
    pnAll: TPanel;
    pnButtons: TPanel;
    btnCloseForm: TButton;
    pgcRegisters: TPageControl;
    tsRegisters: TTabSheet;
    tsDetail: TTabSheet;
    gRegisters: TcxGrid;
    gRegistersLevel1: TcxGridLevel;
    gvRegisters: TcxGridTableView;
    pnButtonsDetail: TPanel;
    btnCancel: TButton;
    btnSave: TButton;
    pnFilter: TPanel;
    sbFilter: TSearchBox;
    btnShowAll: TButton;
    btnNewData: TButton;
    gbData: TGroupBox;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCloseFormClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnShowAllClick(Sender: TObject);
    procedure gvRegistersEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure sbFilterChange(Sender: TObject);
    procedure btnNewDataClick(Sender: TObject);
    procedure sbFilterKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure gvRegistersKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    FService: TGenericService;

    procedure ChangeTabCheet(const aTabIndex: Integer);
    function GetSelectedRow(): Integer;
    function GetValueFromIndex(const aRowIndex, aColumnIndex: Integer): Variant;
    procedure ShowData(var aDataset: TDataSet);
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TFRegistrationTemplate.btnCancelClick(Sender: TObject);
begin
  ChangeTabCheet(0);
end;

procedure TFRegistrationTemplate.btnCloseFormClick(Sender: TObject);
begin
  Close;
end;

procedure TFRegistrationTemplate.btnNewDataClick(Sender: TObject);
begin
  ChangeTabCheet(1);
end;

procedure TFRegistrationTemplate.btnSaveClick(Sender: TObject);
begin
  ChangeTabCheet(0);
end;

procedure TFRegistrationTemplate.btnShowAllClick(Sender: TObject);
begin
  gvRegisters.DataController.RecordCount := 0;
end;

procedure TFRegistrationTemplate.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(FService) then
    FService.Free;

  Action := caFree;
end;

procedure TFRegistrationTemplate.FormCreate(Sender: TObject);
begin
  FService := TGenericService.Create(ExtractFilePath(Application.ExeName));
end;

procedure TFRegistrationTemplate.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case key of
    VK_ESCAPE:
      begin
        if (MessageDlg('Deseja realmente fechar?', mtConfirmation, mbYesNo, 0, mbNo) = mrYes) then
          Close;
      end;
  end;
end;

procedure TFRegistrationTemplate.FormShow(Sender: TObject);
begin
  pgcRegisters.ActivePage := tsRegisters;
  ChangeTabCheet(pgcRegisters.ActivePageindex);
  sbFilter.SetFocus;
end;

function TFRegistrationTemplate.GetSelectedRow: Integer;
begin
  Result := gvRegisters.DataController.GetSelectedRowIndex(0);
end;

function TFRegistrationTemplate.GetValueFromIndex(const aRowIndex, aColumnIndex: Integer): Variant;
begin
  Result := gvRegisters.DataController.GetValue(aRowIndex, aColumnIndex);
end;

procedure TFRegistrationTemplate.gvRegistersEditKeyPress(Sender: TcxCustomGridTableView;
  AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
begin
  if CharInSet(Key, ['A'..'Z', 'a'..'z', #8]) then
  begin
    sbFilter.SetFocus;
    sbFilter.SelText := Key;
  end
  else
  if CharInSet(Key, [#13, #8]) then
  begin
    sbFilter.Clear;
    sbFilter.SetFocus;
  end;
end;

procedure TFRegistrationTemplate.gvRegistersKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (key = VK_RETURN) then
    ChangeTabCheet(1);
end;

procedure TFRegistrationTemplate.ChangeTabCheet(const aTabIndex: Integer);
begin
  tsRegisters.TabVisible := aTabIndex = 0;
  tsDetail.TabVisible    := aTabIndex = 1;

  if tsRegisters.TabVisible then
  begin
    if sbFilter.CanFocus then
      sbFilter.SetFocus;
  end;
end;

procedure TFRegistrationTemplate.sbFilterChange(Sender: TObject);
begin
  gvRegisters.DataController.RecordCount := 0;
end;

procedure TFRegistrationTemplate.sbFilterKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN:
      begin
        gRegisters.SetFocus;
        gvRegisters.DataController.FocusedRecordIndex := 0;
      end;
  end;
end;

procedure TFRegistrationTemplate.ShowData(var aDataset: TDataSet);
var
  Index: Integer;
  I: Integer;
begin
  gvRegisters.DataController.BeginUpdate;
  try
    aDataset.First;
    while not aDataset.Eof do
    begin
      Index := gvRegisters.DataController.AppendRecord;

      for I := 0 to adataset.Fields.Count -1 do
        gvRegisters.DataController.Values[Index, I]  := aDataset.Fields[I].Value;

      aDataset.Next;
    end;
  finally
    gvRegisters.DataController.EndUpdate;
  end;
end;

end.
