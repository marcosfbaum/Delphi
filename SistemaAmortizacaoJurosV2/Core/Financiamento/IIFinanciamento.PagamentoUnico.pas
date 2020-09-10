unit IIFinanciamento.PagamentoUnico;

interface

uses IFinanciamento.Observer;

type
  IFinanciamentoBase = interface(IINvokable)
    ['{478EF1ED-2EAE-40F0-B20B-5CFD27C9430F}']
    function Calculate(const aCapital: Currency; const aQuantidadeParcelas: Integer; const aTaxaJuros: Currency): IFinanciamentoBase;
    function GetParcela: Integer;
    function GetValorJuros: Currency;
    function GetAmortizacao: Currency;
    function GetPagamento: Currency;
    function GetSaldoDevedor: Currency;
    procedure AddObserver(const aObject: IFinanciamentoObserver);
    procedure RemoveObserver(const aObject: IFinanciamentoObserver);
  end;

type
  IFinanciamentoPagamentoUnico = interface(IFinanciamentoBase)
    ['{6C8F0368-8E40-4768-AE47-678A12F8C84C}']
  end;

implementation

end.
