unit FSimulacaoFinanciamento;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes, System.Generics.Collections,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.Bind.GenData,
  Data.Bind.Components, Data.Bind.ObjectScope, Financiamento.Model, Vcl.ComCtrls, System.Rtti, System.Bindings.Outputs,
  Vcl.Bind.Editors, Data.Bind.EngExt, Vcl.Bind.DBEngExt, Vcl.Bind.Grid,
  Data.Bind.Grid, Vcl.Grids, Vcl.Bind.GenData, Data.Bind.Controls, Vcl.Buttons, Vcl.Bind.Navigator,
  Financiamento.Types, IIFinanciamento.Factory, IIFinanciamento.Service,
  Spring.Container, IIFinanciamento.PagamentoUnico, IFinanciamento.Observer;

type
  TSimulacaoFinanciamento = class(TForm, IFinanciamentoObserver)
    edCapital: TLabeledEdit;
    edTaxaJuros: TLabeledEdit;
    edParcelas: TLabeledEdit;
    btnCalcular: TButton;
    PrototypeBindSource1: TPrototypeBindSource;
    BindingList1: TBindingsList;
    StringGrid1: TStringGrid;
    LinkGridToDataSourcePrototypeBindSource1: TLinkGridToDataSource;
    NavigatorPrototypeBindSource1: TBindNavigator;
    edTotJuros: TEdit;
    edTotAmortizacao: TEdit;
    edTotPagamento: TEdit;
    edTotSaldoDevedor: TEdit;
    Label1: TLabel;
    PrototypeBindSource2: TPrototypeBindSource;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    procedure btnCalcularClick(Sender: TObject);
    procedure PrototypeBindSource1CreateAdapter(Sender: TObject; var ABindSourceAdapter: TBindSourceAdapter);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure PrototypeBindSource2CreateAdapter(Sender: TObject; var ABindSourceAdapter: TBindSourceAdapter);
  private
    FListFinanciamento: TObjectList<TFinanciamento>;
    FTotaisFinanciamento: TFinanciamentoTotais;

    procedure ClearParcelas;
    { Private declarations }
  public
    procedure Atualizar(const aFinanciamentoModel: TFinanciamentoModel);
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TSimulacaoFinanciamento.btnCalcularClick(Sender: TObject);
var
  LFinanciamentoFactory: IFinanciamentoFactory;
  LFinanciamentoService: IFinanciamentoService;
begin
  LFinanciamentoFactory := GlobalContainer.Resolve<IFinanciamentoFactory>;
  LFinanciamentoService := LFinanciamentoFactory.Create();

  ClearParcelas();

  LFinanciamentoService
    .Financiamento(TTipoFinanciamento.tfPagamentoUnico, Self)
    .Calculate(StrToCurr(edCapital.Text),
               StrToInt(edParcelas.Text),
               StrToCurr(edTaxaJuros.Text));
end;

procedure TSimulacaoFinanciamento.ClearParcelas();
begin
  FListFinanciamento.Clear;;
  FTotaisFinanciamento.Reset();
end;

procedure TSimulacaoFinanciamento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ClearParcelas();
  PrototypeBindSource1.Active := False;
  PrototypeBindSource2.Active := False;
  Action := caFree;
end;

procedure TSimulacaoFinanciamento.FormCreate(Sender: TObject);
begin
  GlobalContainer.Build;
end;

procedure TSimulacaoFinanciamento.PrototypeBindSource1CreateAdapter(Sender: TObject; var ABindSourceAdapter: TBindSourceAdapter);
begin
  FListFinanciamento := TObjectList<TFinanciamento>.Create(False);
  ABindSourceAdapter := TListBindSourceAdapter<TFinanciamento>.Create(Self, FListFinanciamento, True);
end;

procedure TSimulacaoFinanciamento.PrototypeBindSource2CreateAdapter(Sender: TObject; var ABindSourceAdapter: TBindSourceAdapter);
begin
  FTotaisFinanciamento := TFinanciamentoTotais.Create;
  ABindSourceAdapter := TObjectBindSourceAdapter<TFinanciamentoTotais>.Create(Self, FTotaisFinanciamento, True);
end;

procedure TSimulacaoFinanciamento.Atualizar(const aFinanciamentoModel: TFinanciamentoModel);
begin
  FListFinanciamento.AddRange(aFinanciamentoModel.FinanciamentoParcelas);

  FTotaisFinanciamento.Clone(aFinanciamentoModel.Totais);

  PrototypeBindSource1.Active := False;
  PrototypeBindSource1.Active := True;

  PrototypeBindSource2.Active := False;
  PrototypeBindSource2.Active := True;
end;

end.
