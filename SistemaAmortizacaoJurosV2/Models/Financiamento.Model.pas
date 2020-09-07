unit Financiamento.Model;

interface

uses
  System.Generics.Collections,
  System.Classes;

type
  TFinanciamentoModel = class(TObject)
  private
    FSaldoDevedor: String;
    FPagamento: String;
    FValorJuros: String;
    FAmortizacao: String;
    FParcela: Integer;
  published
    property Parcela: Integer read FParcela write FParcela;
    property ValorJuros: String read FValorJuros write FValorJuros;
    property Amortizacao: String read FAmortizacao write FAmortizacao;
    property Pagamento: String read FPagamento write FPagamento;
    property SaldoDevedor: String read FSaldoDevedor write FSaldoDevedor;
  end;

type
  TFinanciamentoTotais = class(TObject)
  private
    FTotalAmortizacao: String;
    FTotalSaldoDevedor: String;
    FTotalJuros: String;
    FTotalPagamento: String;
  published
    property TotalJuros: String read FTotalJuros write FTotalJuros;
    property TotalAmortizacao: String read FTotalAmortizacao write FTotalAmortizacao;
    property TotalPagamento: String read FTotalPagamento write FTotalPagamento;
    property TotalSaldoDevedor: String read FTotalSaldoDevedor write FTotalSaldoDevedor;

  end;

implementation

{ TParcelasModel }

end.
