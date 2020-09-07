unit IIFinanciamento.Service;

interface

uses
  System.Generics.Collections,
  Financiamento.Model;

type
  IFinanciamentoService = interface(IInvokable)
    ['{7E76E524-3598-43F5-90DF-6D325EDD7F7E}']
    procedure CalculateFinanciamentoPagamentoUnico(const aList: TObjectList<TFinanciamentoModel>; const aTotais: TFinanciamentoTotais);
  end;

implementation

end.
