unit Financiamento.PagamentoUnico;

interface

uses IIFinanciamento;

type
  TFinanciamentoPagamentoUnico = class(TInterfacedObject, IFinanciamento)
    private
    var
      FUltimaParcela: Integer;
      FCapital: Currency;
      FTaxaJuros: Currency;
      FParcela: Integer;
      FSaldoDevedor: Currency;
    function GetAmortizacao: Currency;
    function GetPagamento: Currency;
    function GetSaldoDevedor: Currency;
    function GetValorJuros: Currency;
    public
      constructor Create(const aCapital: Currency; const aQuantidadeParcelas: Integer; const aTaxaJuros: Currency);
      procedure Calculate(const aParcela: Integer; const aSaldoDevedor: Currency);
    published
      property Parcela: Integer read FParcela write FParcela;
      property ValorJuros: Currency read GetValorJuros;
      property Amortizacao: Currency read GetAmortizacao;
      property Pagamento: Currency read GetPagamento;
      property SaldoDevedor: Currency read GetSaldoDevedor;
  end;

implementation

{ TFinanciamentoPagamentoUnico }

procedure TFinanciamentoPagamentoUnico.Calculate(const aParcela: Integer; const aSaldoDevedor: Currency);
begin
  FParcela      := aParcela;
  FSaldoDevedor := aSaldoDevedor;
end;

constructor TFinanciamentoPagamentoUnico.Create(const aCapital: Currency; const aQuantidadeParcelas: Integer; const aTaxaJuros: Currency);
begin
  FCapital       := aCapital;
  FUltimaParcela := aQuantidadeParcelas;
  FTaxaJuros     := aTaxaJuros;
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
    Result := FSaldoDevedor + ValorJuros;
end;

function TFinanciamentoPagamentoUnico.GetSaldoDevedor: Currency;
begin
  Result := FSaldoDevedor + ValorJuros;
  if FUltimaParcela = FParcela then
    Result := 0;
end;

function TFinanciamentoPagamentoUnico.GetValorJuros: Currency;
begin
  Result := ((FSaldoDevedor * FTaxaJuros) / 100);
end;

end.
