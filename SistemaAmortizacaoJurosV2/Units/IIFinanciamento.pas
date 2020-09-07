unit IIFinanciamento;

interface

type
  IFinanciamento = interface(IInterface)
  ['{B6732AC2-6668-437F-A4D1-C615C25E0C2C}']
    procedure Calculate(const aParcela: Integer; const aSaldoDevedor: Currency);
  end;

implementation

end.
