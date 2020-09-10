unit IIFinanciamento.Service;

interface

uses
  IIFinanciamento.PagamentoUnico, Financiamento.Types, IFinanciamento.Observer;

type
  IFinanciamentoService = interface(IInvokable)
    ['{7E76E524-3598-43F5-90DF-6D325EDD7F7E}']
    function Financiamento(const aTipo: TTipoFinanciamento; const aObserver: IFinanciamentoObserver): IFinanciamentoBase;
  end;

implementation

end.
