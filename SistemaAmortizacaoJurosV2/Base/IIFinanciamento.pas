unit IIFinanciamento;

interface

uses
  Spring.Container, IIFinanciamento.PagamentoUnico;

type
  IFinanciamento = interface(IInvokable)
  ['{B6732AC2-6668-437F-A4D1-C615C25E0C2C}']
    function Create(const aCapital: Currency; const aQuantidadeParcelas: Integer; const aTaxaJuros: Currency): IFinanciamentoBase;
    function Calculate(const aParcela: Integer; const aSaldoDevedor: Currency): Boolean;
  end;

implementation

initialization
  GlobalContainer.RegisterType<IFinanciamento>.AsFactory;

end.
