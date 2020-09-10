unit Financiamento.Factory;

interface

uses
  Spring.Container,
  Spring.DesignPatterns,
  System.SysUtils,
  System.Generics.Collections,
  Financiamento.Types, IIFinanciamento,
  IIFinanciamento.PagamentoUnico, IIFinanciamento.Service, IFinanciamento.Observer;

type
  TFinanciamentoFactory = class(TInterfacedObject, IFinanciamentoService)
  private
  public
  var
    constructor Create(); overload;
    destructor Destroy; override;
    function Financiamento(const aTipo: TTipoFinanciamento; const aObserver: IFinanciamentoObserver): IFinanciamentoBase;
  end;

implementation

{ TParcelas }

constructor TFinanciamentoFactory.Create();
var
  LFinanciamento: TFactoryMethod<IFinanciamentoService>;
begin
  GlobalContainer.Build;
  LFinanciamento := function: IFinanciamentoService
                      begin
                        Result := GlobalContainer.Resolve<IFinanciamentoService>;
                      end;
end;

destructor TFinanciamentoFactory.Destroy;
begin
  inherited;
end;

function TFinanciamentoFactory.Financiamento(const aTipo: TTipoFinanciamento; const aObserver: IFinanciamentoObserver): IFinanciamentoBase;
begin
  case aTipo of
    tfPagamentoUnico:
    begin
      Result := GlobalContainer.Resolve<IFinanciamentoPagamentoUnico>;
      Result.AddObserver(aObserver);
    end;
  end;
end;

initialization
  GlobalContainer.RegisterType<IFinanciamentoService, TFinanciamentoFactory>;

end.
