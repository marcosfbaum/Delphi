unit IFinanciamento.Subject;

interface

uses
  IFinanciamento.Observer;

type
  IFinanciamentoSubject = interface
    procedure AdicionarObserver(const aObserver: IFinanciamentoObserver);
    procedure RemoverObserver(const aObserver: IFinanciamentoObserver);
    procedure Notificar();
  end;

implementation

end.
