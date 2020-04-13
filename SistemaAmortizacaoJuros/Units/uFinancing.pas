unit uFinancing;

interface

uses
  System.Generics.Collections, System.Math,
  uIFinancing, uInstallment;

type
  TFinancing = class(TInterfacedObject, IFinancing)
  private
  FCapital: Currency;
    FInstallment: TInstallment;
    FQuantityInstallments: Integer;
    FInterestRate: Currency;
    FListInstallments: TList<TInstallment>;
    procedure SetCapital(const Value: Currency);
    procedure SetQuantityinstallments(const Value: Integer);
    procedure SetInterestRate(const Value: Currency);
    function GetLastInstallmentNumber: Integer;
    function GetTotalOutstandingBalance: Currency;
    function GetTotalInterest: Currency;
  public
  const
    MAX_VALUE_CAPITAL = 999999999999;
    constructor Create;
    destructor Destroy; override;
    procedure Clone(const [ref] aSource: TList<TInstallment>);
    procedure Calculate();
  published
    property Capital: Currency read FCapital write SetCapital;
    property QuantityInstallments: Integer read FQuantityinstallments write SetQuantityinstallments;
    property InterestRate: Currency read FInterestRate write SetInterestRate;
    property Installment: TInstallment read FInstallment;
    property Installments: TList<TInstallment> read FListInstallments;
    property LastInstallmentNumber: Integer read GetLastInstallmentNumber;
    property TotalOutstandingBalance: Currency read GetTotalOutstandingBalance;
    property TotalInterest: Currency read GetTotalInterest;
  end;

implementation

{ TFinancing }

procedure TFinancing.Calculate;
var
  I: Integer;
  LInstallment: TInstallment;
  LCapital: Currency;
begin
  LCapital := FCapital;
  for I := 1 to FQuantityInstallments do
  begin
    LInstallment := TInstallment.Create;

    LInstallment.InstallmentNumber  := I;
    LInstallment.AmountInterest     := ((LCapital * FInterestRate) / 100);
    LCapital := LCapital + LInstallment.AmountInterest;
    LInstallment.OutstandingBalance := LCapital;

    FListInstallments.Add(LInstallment);
  end;
end;

procedure TFinancing.Clone(const [ref] aSource: TList<TInstallment>);
begin
  if (aSource.Count > 0) then
    asource.Clear;

  aSource.AddRange(FListInstallments);
end;

constructor TFinancing.Create;
begin
  FInstallment := TInstallment.Create;
  FListInstallments := TList<TInstallment>.Create;
end;

destructor TFinancing.Destroy;
var
  I: Integer;
begin
  if Assigned(FListInstallments) then
  begin
    for I := 0 to FListInstallments.Count -1 do
      FListInstallments[I].Free;

    FListInstallments.Free;
  end;

  if Assigned(FInstallment) then
    FInstallment.Free;

  inherited Destroy;
end;

function TFinancing.GetLastInstallmentNumber: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Installments.Count -1 do
    Result := Max(Result, Installments[I].InstallmentNumber);
end;

function TFinancing.GetTotalInterest: Currency;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Installments.Count -1 do
    Result := Result + Installments[I].AmountInterest;
end;

function TFinancing.GetTotalOutstandingBalance: Currency;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Installments.Count -1 do
    Result := Max(Result, Installments[I].OutstandingBalance);
end;

procedure TFinancing.SetCapital(const Value: Currency);
begin
  FCapital := Value;
end;

procedure TFinancing.SetQuantityinstallments(const Value: Integer);
begin
  FQuantityinstallments := Value;
end;

procedure TFinancing.SetInterestRate(const Value: Currency);
begin
  FInterestRate := Value;
end;

end.
