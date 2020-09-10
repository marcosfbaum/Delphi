unit IFinanciamento.Observer;

interface

uses Financiamento.Model;

type
  IFinanciamentoObserver = interface
    procedure Atualizar(const aFinanciamentoModel: TFinanciamentoModel); overload;
  end;

implementation

end.
