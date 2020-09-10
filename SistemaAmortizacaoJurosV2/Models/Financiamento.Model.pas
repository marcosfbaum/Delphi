unit Financiamento.Model;

interface

uses
  System.Generics.Collections,
  System.Classes,
  System.Sysutils;

type
  TFinanciamento = class(TPersistent)
  private
    FSaldoDevedor: String;
    FPagamento: String;
    FValorJuros: String;
    FAmortizacao: String;
    FParcela: Integer;
  public
    procedure SetValorJuros(const Value: Currency);
    procedure SetAmortizacao(const Value: Currency);
    procedure SetPagamento(const Value: Currency);
    procedure SetSaldoDevedor(const Value: Currency);
  published
    property Parcela: Integer read FParcela write FParcela;
    property ValorJuros: String read FValorJuros;
    property Amortizacao: String read FAmortizacao;
    property Pagamento: String read FPagamento;
    property SaldoDevedor: String read FSaldoDevedor;
  end;

type
    TFinanciamentoTotais = class(TPersistent)
  private
    FTotalAmortizacao: String;
    FTotalSaldoDevedor: String;
    FTotalJuros: String;
    FTotalPagamento: String;
  public
    procedure SetTotalAmortizacao(const Value: Currency);
    procedure SetTotalJuros(const Value: Currency);
    procedure SetTotalPagamento(const Value: Currency);
    procedure SetTotalSaldoDevedor(const Value: Currency);
    procedure Reset();
    procedure Clone(const aSource: TFinanciamentoTotais);
  published
    property TotalJuros: String read FTotalJuros write FTotalJuros;
    property TotalAmortizacao: String read FTotalAmortizacao write FTotalAmortizacao;
    property TotalPagamento: String read FTotalPagamento write FTotalPagamento;
    property TotalSaldoDevedor: String read FTotalSaldoDevedor write FTotalSaldoDevedor;
  end;

type
  TFinanciamentoModel = class(TPersistent)
  private
    FFinanciamentoParcelas: TObjectList<TFinanciamento>;
    FTotais: TFinanciamentoTotais;
    procedure SetFinanciamentoParcelas(const Value: TObjectList<TFinanciamento>);
    procedure SetTotais(const Value: TFinanciamentoTotais);
    public
      constructor Create();
      destructor Destroy(); override;
      procedure Reset();
      procedure AddParcela(const aParcela: TFinanciamento);
    published
      property FinanciamentoParcelas: TObjectList<TFinanciamento> read FFinanciamentoParcelas write SetFinanciamentoParcelas;
      property Totais: TFinanciamentoTotais read FTotais write SetTotais;
  end;

implementation

{ TFinanciamento }

procedure TFinanciamento.SetAmortizacao(const Value: Currency);
begin
  FAmortizacao := FormatCurr(',0.00', Value);
end;

procedure TFinanciamento.SetPagamento(const Value: Currency);
begin
  FPagamento := FormatCurr(',0.00', Value);
end;

procedure TFinanciamento.SetSaldoDevedor(const Value: Currency);
begin
  FSaldoDevedor := FormatCurr(',0.00', Value);
end;

procedure TFinanciamento.SetValorJuros(const Value: Currency);
begin
  FValorJuros := FormatCurr(',0.00', Value);
end;

{ TFinanciamentoTotais }

procedure TFinanciamentoTotais.Clone(const aSource: TFinanciamentoTotais);
begin
  Self.FTotalAmortizacao  := aSource.FTotalAmortizacao;
  Self.FTotalSaldoDevedor := aSource.FTotalSaldoDevedor;
  Self.FTotalJuros        := aSource.FTotalJuros;
  Self.FTotalPagamento    := aSource.FTotalPagamento;
end;

procedure TFinanciamentoTotais.Reset;
begin
  SetTotalAmortizacao(0);
  SetTotalJuros(0);
  SetTotalPagamento(0);
  SetTotalSaldoDevedor(0);
end;

procedure TFinanciamentoTotais.SetTotalAmortizacao(const Value: Currency);
begin
  FTotalAmortizacao := FormatCurr(',0.00', Value);
end;

procedure TFinanciamentoTotais.SetTotalJuros(const Value: Currency);
begin
  FTotalJuros := FormatCurr(',0.00', Value);
end;

procedure TFinanciamentoTotais.SetTotalPagamento(const Value: Currency);
begin
  FTotalPagamento := FormatCurr(',0.00', Value);
end;

procedure TFinanciamentoTotais.SetTotalSaldoDevedor(const Value: Currency);
begin
  FTotalSaldoDevedor := FormatCurr(',0.00', Value);
end;

{ TFinanciamentoModel }

procedure TFinanciamentoModel.AddParcela(const aParcela: TFinanciamento);
begin
  FinanciamentoParcelas.Add(aParcela);
end;

constructor TFinanciamentoModel.Create;
begin
  FFinanciamentoParcelas := TObjectList<TFinanciamento>.Create(True);
  FTotais := TFinanciamentoTotais.Create;
end;

destructor TFinanciamentoModel.Destroy;
begin
  FFinanciamentoParcelas.Clear;
  FFinanciamentoParcelas.Free;
  FTotais.Free;
  inherited;
end;

procedure TFinanciamentoModel.Reset();
begin
  FFinanciamentoParcelas.Clear;
  FTotais.Reset;
end;

procedure TFinanciamentoModel.SetFinanciamentoParcelas(const Value: TObjectList<TFinanciamento>);
begin
  FFinanciamentoParcelas := Value;
end;

procedure TFinanciamentoModel.SetTotais(const Value: TFinanciamentoTotais);
begin
  FTotais := Value;
end;

end.
