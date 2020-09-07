unit IIFinanciamento.Factory;

interface

uses
  Spring.Container,
  Financiamento.Types, IIFinanciamento.Service;

type
  IFinanciamentoFactory = interface(IInvokable)
    ['{B6732AC2-6668-437F-A4D1-C615C25E0C2C}']
    function Create(): IFinanciamentoService; overload;
    function Create(const aTipoFinanciamento: TTipoFinanciamento; const aCapital: Currency; const aQuantidadeParcelas: Integer; const aTaxaJuros: Currency): IFinanciamentoService; overload;
  end;


implementation

initialization
  GlobalContainer.RegisterType<IFinanciamentoFactory>.AsFactory;

end.
