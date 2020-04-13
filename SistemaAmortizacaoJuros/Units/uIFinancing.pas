unit uIFinancing;

interface

uses
  System.Generics.Collections,
  uInstallment;

type
  IFinancing = interface(IInterface)
  ['{A735822B-EA3C-472A-BE5F-07BDD804A86E}']

    procedure Clone(const [ref] aSource: TList<TInstallment>);
    procedure Calculate();
  end;

implementation

end.
