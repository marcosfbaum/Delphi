unit FinanciamentoModel.Subject;

interface

uses
  System.Generics.Collections,
  IFinanciamento.Subject, IFinanciamento.Observer, Financiamento.Model;

type
  TFinanciamentoModelSubject = class(TInterfacedObject, IFinanciamentoSubject)
  private
    FObservers: Tlist<IFinanciamentoObserver>;
    FFinanciamentoModel: TFinanciamentoModel;
  public
    constructor Create();
    destructor Destroy(); override;
    procedure AdicionarObserver(const aObserver: IFinanciamentoObserver);
    procedure RemoverObserver(const aObserver: IFinanciamentoObserver);
    procedure Notificar;
    procedure SetFinanciamento(const aFinanciamentoModel: TFinanciamentoModel);
  end;

implementation

{ TFinanciamentoModelObservable }

constructor TFinanciamentoModelSubject.Create;
begin
  inherited;
  FObservers := Tlist<IFinanciamentoObserver>.Create;
end;

destructor TFinanciamentoModelSubject.Destroy;
begin
  FObservers.Free;
end;

procedure TFinanciamentoModelSubject.AdicionarObserver(const aObserver: IFinanciamentoObserver);
begin
  FObservers.Add(aObserver);
end;

procedure TFinanciamentoModelSubject.Notificar;
var
  LObserver: IFinanciamentoObserver;
begin
  for LObserver in FObservers do
    LObserver.Atualizar(FFinanciamentoModel);
end;

procedure TFinanciamentoModelSubject.RemoverObserver(const aObserver: IFinanciamentoObserver);
begin
  FObservers.Delete(FObservers.IndexOf(aObserver));
end;

procedure TFinanciamentoModelSubject.SetFinanciamento(const aFinanciamentoModel: TFinanciamentoModel);
begin
  FFinanciamentoModel := aFinanciamentoModel;
  Notificar;
end;


end.
