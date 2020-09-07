unit Financiamento.Factory;

interface

uses
  System.Sysutils,
  System.Generics.Collections,
  Spring.Container,
  Spring.DesignPatterns,
  Financiamento.Model, Financiamento.Types,
  IIFinanciamento.Service, IIFinanciamento, Financiamento.PagamentoUnico;
type
  TFinanciamentoFactory = class(TInterfacedObject, IFinanciamentoService)
  private
    FFinanciamentoFactory: TFactory<TTipoFinanciamento, IFinanciamento>;
    const
      FMinimoParcelas: Integer = 1;
      FMaximoParcelas: Integer = 24;
      FTaxaMinimaJuros: Integer = 1;
      FTaxaMaximaJuros: Integer = 100;
    var
      FQuantidadeParcelas: Integer;
      FCapital: Currency;
      FTaxaJuros: Currency;
      FParcela: Integer;
      FTipoFinanciamento: TTipoFinanciamento;
      FTotalDevedor: Currency;
  public
    constructor Create(); overload;
    constructor Create(const aTipoFinanciamento: TTipoFinanciamento; const aCapital: Currency; const aQuantidadeParcelas: Integer; const aTaxaJuros: Currency); overload;

    destructor Destroy; override;
    procedure CalculateFinanciamentoPagamentoUnico(const aList: TObjectList<TFinanciamentoModel>; const aTotais: TFinanciamentoTotais);
  published

  end;

implementation

{ TParcelas }

constructor TFinanciamentoFactory.Create(const aTipoFinanciamento: TTipoFinanciamento; const aCapital: Currency; const aQuantidadeParcelas: Integer; const aTaxaJuros: Currency);
var
  LFinanciamentoPagamentoUnico: TFactoryMethod<IFinanciamento>;
begin
  Assert(acapital > 0, 'Informe um valor positivo para o capital.');
  Assert(aQuantidadeParcelas >= FMinimoParcelas, Format('O mínimo de parcelas é %d.', [ FMinimoParcelas ]));
  Assert(aQuantidadeParcelas <= FMaximoParcelas , Format('O máximo de parcelas é %d.', [ FMaximoParcelas ]));
  Assert(aTaxaJuros >= FTaxaMinimaJuros, Format('O mínimo de juros é %d.', [ FTaxaMinimaJuros ]));
  Assert(aTaxaJuros <= FTaxaMaximaJuros, Format('O máximo de juros é %d.', [ FTaxaMaximaJuros ]));

  Create();

  FCapital            := aCapital;
  FQuantidadeParcelas := aQuantidadeParcelas;
  FTaxaJuros          := aTaxaJuros;
  FParcela            := 0;
  FTipoFinanciamento  := aTipoFinanciamento;
  FTotalDevedor       := aCapital;

  FFinanciamentoFactory := TFactory<TTipoFinanciamento, IFinanciamento>.Create;

  LFinanciamentoPagamentoUnico := function: IFinanciamento
                                  begin
                                    Result := TFinanciamentoPagamentoUnico.Create(aCapital, aQuantidadeParcelas, aTaxaJuros);
                                    Result.Calculate(FParcela, FTotalDevedor);
                                  end;
  FFinanciamentoFactory.RegisterFactoryMethod(tfPagamentoUnico, LFinanciamentoPagamentoUnico);
end;

constructor TFinanciamentoFactory.Create;
begin
end;

destructor TFinanciamentoFactory.Destroy;
begin
  if Assigned(FFinanciamentoFactory) then
    FFinanciamentoFactory.Free;
end;

procedure TFinanciamentoFactory.CalculateFinanciamentoPagamentoUnico(const aList: TObjectList<TFinanciamentoModel>; const aTotais: TFinanciamentoTotais);
var
  LParcela: Integer;
  LParcelasModel: TFinanciamentoModel;
  LPgtoUnico: TFinanciamentoPagamentoUnico;
  LTotalJuros: Currency;
begin
// TODO: Add RTTI para pegar valores dinamicamente e não olhar para o tipo TFinanciamentoPagamentoUnico, etc..
  LTotalJuros := 0;
  for LParcela := 1 to FQuantidadeParcelas do
  begin
    FParcela := LParcela;

    LPgtoUnico := FFinanciamentoFactory.GetInstance(FTipoFinanciamento) as TFinanciamentoPagamentoUnico;
    LParcelasModel := TFinanciamentoModel.Create;
    LParcelasModel.Parcela      := FParcela;
    LParcelasModel.ValorJuros   := FormatCurr(',0.00', LPgtoUnico.ValorJuros);
    LParcelasModel.Amortizacao  := FormatCurr(',0.00', LPgtoUnico.Amortizacao);
    LParcelasModel.Pagamento    := FormatCurr(',0.00', LPgtoUnico.Pagamento);
    LParcelasModel.SaldoDevedor := FormatCurr(',0.00', LPgtoUnico.SaldoDevedor);

    LTotalJuros := LTotalJuros + LPgtoUnico.ValorJuros;

    FTotalDevedor := LPgtoUnico.SaldoDevedor;
    aList.Add(LParcelasModel);
  end;

  aTotais.TotalJuros := FormatCurr(',0.00', LTotalJuros);
  aTotais.TotalAmortizacao := FormatCurr(',0.00', FCapital);
  aTotais.TotalPagamento := FormatCurr(',0.00', LPgtoUnico.Pagamento);
  aTotais.TotalSaldoDevedor := FormatCurr(',0.00', FTotalDevedor);
end;

initialization
  GlobalContainer.RegisterType<IFinanciamentoService, TFinanciamentoFactory>;

end.
