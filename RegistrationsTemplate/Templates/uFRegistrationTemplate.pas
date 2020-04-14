unit uFRegistrationTemplate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.WinXCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, dxSkinsCore, dxSkinsDefaultPainters, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, dxDateRanges, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid;

type
  TFRegistrationTemplate = class(TForm)
    pnAll: TPanel;
    pnFilter: TPanel;
    SearchBox1: TSearchBox;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    pnButtons: TPanel;
    btnCloseForm: TButton;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCloseFormClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FRegistrationTemplate: TFRegistrationTemplate;

implementation

{$R *.dfm}

procedure TFRegistrationTemplate.btnCloseFormClick(Sender: TObject);
begin
  Close;
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

end.
