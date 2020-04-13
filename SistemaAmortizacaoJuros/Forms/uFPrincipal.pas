unit uFPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.Math,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.CategoryButtons, Vcl.WinXCtrls, System.Actions,
  Vcl.ActnList, uFSimulacaoFinanciamento, uResources.Utils;

type
  TFPrincipal = class(TForm)
    pnAll: TPanel;
    pnBottom: TPanel;
    btnCloseApp: TButton;
    SplitView1: TSplitView;
    CategoryButtons: TCategoryButtons;
    ActionList1: TActionList;
    acSimuladorFinanciamento: TAction;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CategoryButtonsCategoryCollapase(Sender: TObject;
      const Category: TButtonCategory);
    procedure acSimuladorFinanciamentoExecute(Sender: TObject);
    procedure btnCloseAppClick(Sender: TObject);
  private
    procedure MostrarEsconderMenu;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPrincipal: TFPrincipal;

implementation

{$R *.dfm}

procedure TFPrincipal.acSimuladorFinanciamentoExecute(Sender: TObject);
begin
  MostrarEsconderMenu;
  TFSimulacaoFinanciamento.Create(Self).Show;
end;

procedure TFPrincipal.btnCloseAppClick(Sender: TObject);
begin
  Close;
end;

procedure TFPrincipal.CategoryButtonsCategoryCollapase(Sender: TObject; const Category: TButtonCategory);
begin
  //  Altera o tamanho do Menu para que a cor fique conforme a cor de fundo.
  CategoryButtons.Height := IfThen(Category.Collapsed, 30, Trunc(Category.Items.Count * 70));
end;

procedure TFPrincipal.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE:
      begin
        if (MessageDlg('Deseja realmente fechar o sistema de simulação de financiamento?', mtConfirmation, mbYesNo, 0) = mrYes) then
          Close;
      end;
  end;
end;

procedure TFPrincipal.MostrarEsconderMenu;
begin
//  Esconde o menu após seu uso.
  CategoryButtons.CurrentCategory.Collapsed := (not (CategoryButtons.CurrentCategory.Collapsed));
  CategoryButtons.Update;
end;

end.
