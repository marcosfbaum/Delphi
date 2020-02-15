unit UIMaquina;

interface

uses System.Classes;

type
  Imaquina = interface
  ['{36B144C9-E81A-45C4-A9B9-3776D39C1AFB}']

    function MontarTroco(const aTroco: Double): TList;
    function ImprimirCabecalhoTroco(const aValor: string): string;
    function MontarImpressao(const aListTroco: TList; const aValorTotalTroco: Double): TStringList;
  end;

implementation

end.
