unit Financiamento.PagamentoUnico;

interface

uses
  Spring.Container,
  System.Generics.Collections,
  IIFinanciamento.PagamentoUnico, FinanciamentoModel.Subject, IFinanciamento.Observer, Financiamento.Model;

type
  TFinanciamentoPagamentoUnico = class(TInterfacedObject, IFinanciamentoPagamentoUnico)
    private
    var
      FUltimaParcela: Integer;
      FCapital: Currency;
      FTaxaJuros: Currency;
      FParcela: Integer;
      FSaldoDevedor: Currency;
      FTotalJuros: Currency;
      FSubject: TFinanciamentoModelSubject;
    public
      constructor Create();
      destructor Destroy; Override;
      function Calculate(const aCapital: Currency; const aQuantidadeParcelas: Integer; const aTaxaJuros: Currency): IFinanciamentoBase;
      function GetParcela: Integer;
      function GetValorJuros: Currency;
      function GetAmortizacao: Currency;
      function GetPagamento: Currency;
      function GetSaldoDevedor: Currency;
      procedure AddObserver(const aObject: IFinanciamentoObserver);
      procedure RemoveObserver(const aObject: IFinanciamentoObserver);
  end;

implementation

{ TFinanciamentoPagamentoUnico }

function TFinanciamentoPagamentoUnico.Calculate(const aCapital: Currency; const aQuantidadeParcelas: Integer; const aTaxaJuros: Currency): IFinanciamentoBase;
var
  LParcela: Integer;
  LTotalDevedor: Currency;
  LFinanciamentoModel: TFinanciamentoModel;
  LParcelasModel: TFinanciamento;
begin
  FCapital       := aCapital;
  FUltimaParcela := aQuantidadeParcelas;
  FTaxaJuros     := aTaxaJuros;
  FSaldoDevedor  := aCapital;

  LFinanciamentoModel := TFinanciamentoModel.Create;
  try
    for LParcela := 1 to aQuantidadeParcelas do
    begin
      FParcela := LParcela;

      LParcelasModel := TFinanciamento.Create;
      LParcelasModel.Parcela := LParcela;
      LParcelasModel.SetValorJuros(GetValorJuros);
      LParcelasModel.SetAmortizacao(GetAmortizacao);
      LParcelasModel.SetPagamento(GetPagamento);
      LParcelasModel.SetSaldoDevedor(GetSaldoDevedor);

      FSaldoDevedor := FSaldoDevedor + GetValorJuros;

      LFinanciamentoModel.AddParcela(LParcelasModel);

      LTotalDevedor := GetSaldoDevedor;
      LFinanciamentoModel.Totais.SetTotalJuros(FSaldoDevedor);
      LFinanciamentoModel.Totais.SetTotalAmortizacao(FCapital);
      LFinanciamentoModel.Totais.SetTotalPagamento(FSaldoDevedor);
      LFinanciamentoModel.Totais.SetTotalSaldoDevedor(LTotalDevedor);
    end;
    FSubject.SetFinanciamento(LFinanciamentoModel);
  finally
    LFinanciamentoModel.Free;
  end;
end;

constructor TFinanciamentoPagamentoUnico.Create();
begin
  inherited;
  FSubject := TFinanciamentoModelSubject.Create;
  FTotalJuros := 0;
end;

destructor TFinanciamentoPagamentoUnico.Destroy;
begin
  FSubject.Free;
end;

function TFinanciamentoPagamentoUnico.GetAmortizacao: Currency;
begin
  Result := 0;
  if FUltimaParcela = FParcela then
    Result := FCapital;
end;

function TFinanciamentoPagamentoUnico.GetPagamento: Currency;
begin
  Result := 0;
  if FUltimaParcela = FParcela then
    Result := FSaldoDevedor + GetValorJuros;
end;

function TFinanciamentoPagamentoUnico.GetParcela: Integer;
begin
  Result := FParcela;
end;

function TFinanciamentoPagamentoUnico.GetSaldoDevedor: Currency;
begin
  Result := FSaldoDevedor + GetValorJuros;
  if FUltimaParcela = FParcela then
    Result := 0;
end;

function TFinanciamentoPagamentoUnico.GetValorJuros: Currency;
begin
  Result := ((FSaldoDevedor * FTaxaJuros) / 100);
  FTotalJuros := FTotalJuros + Result;
end;

procedure TFinanciamentoPagamentoUnico.AddObserver(const aObject: IFinanciamentoObserver);
begin
  FSubject.AdicionarObserver(aObject);
end;

procedure TFinanciamentoPagamentoUnico.RemoveObserver(const aObject: IFinanciamentoObserver);
begin
  FSubject.RemoverObserver(aObject);
end;

initialization
  GlobalContainer.RegisterType<IFinanciamentoPagamentoUnico, TFinanciamentoPagamentoUnico>;

end.
