unit uIInstallment;

interface

uses
  System.Generics.Collections;

type

  IInstallment = Interface(IInterface)
  ['{EB53D011-5D8C-40B5-BC40-EF6A5256A2F1}']
    function Count(): Integer;
    function InRange(const aValue: Integer): Boolean;

    procedure CloneDefaultInstallments(const [ref] aSource: TList<Integer>);
  end;
implementation

end.
