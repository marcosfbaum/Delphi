unit uInstallment;

interface

uses
  System.Classes, System.generics.Collections, System.Math,
  uIInstallment;

type
  TInstallment = class(TInterfacedObject, IInstallment)
  private
    FListAvailableInstallments: TList<Integer>;
    FMaxInstallment: Integer;
    FMinInstallment: Integer;
    FInstallmentNumber: Integer;
    FAmountInterest: Currency;
    FOutstandingBalance: Currency;
    FPayment: Currency;
    procedure InitializeInstallments();
    procedure SetInstallmentNumber(const Value: Integer);
    procedure SetAmountInterest(const Value: Currency);
    procedure SetPayment(const Value: Currency);
    procedure SetOutstandingBalance(const Value: Currency);
  public
    procedure CloneDefaultInstallments(const [ref] aSource: TList<Integer>);
    function Count(): Integer;
    function InRange(const aValue: Integer): Boolean;
    constructor Create;
    destructor Destroy; override;
  published
    property InstallmentNumber: Integer read FInstallmentNumber write SetInstallmentNumber; //Parcela numero
    property AmountInterest: Currency read FAmountInterest write SetAmountInterest; //valor Juro
    property Payment: Currency read FPayment write SetPayment;
    property OutstandingBalance: Currency read FOutstandingBalance write SetOutstandingBalance; //Saldo devedor
  end;

implementation

{ TInstallments }

function TInstallment.Count: Integer;
begin
  Result := FListAvailableInstallments.Count;
end;

constructor TInstallment.Create;
begin
  FMinInstallment := 1;
  FMaxInstallment := 100;
  FListAvailableInstallments := TList<Integer>.Create;
  InitializeInstallments();
end;

destructor TInstallment.Destroy;
begin
  if Assigned(FListAvailableInstallments) then
    FListAvailableInstallments.Free;

  inherited;
end;

procedure TInstallment.CloneDefaultInstallments(const [ref] aSource: TList<Integer>);
begin
  if (aSource.Count > 0) then
    aSource.Clear;

  aSource.AddRange(FListAvailableInstallments);
end;

procedure TInstallment.InitializeInstallments;
var
  I: Integer;
begin
  if (FListAvailableInstallments.Count > 0) then
    FListAvailableInstallments.Clear;

  for I := FMinInstallment to FMaxInstallment do
    FListAvailableInstallments.Add(I);
end;

function TInstallment.InRange(const aValue: Integer): Boolean;
begin
  Result := ((aValue >= FMinInstallment) and (aValue <= FMaxInstallment));
end;

procedure TInstallment.SetAmountInterest(const Value: Currency);
begin
  FAmountInterest := Value;
end;

procedure TInstallment.SetInstallmentNumber(const Value: Integer);
begin
  FInstallmentNumber := Value;
end;

procedure TInstallment.SetOutstandingBalance(const Value: Currency);
begin
  FOutstandingBalance := Value;
end;

procedure TInstallment.SetPayment(const Value: Currency);
begin
  FPayment := Value;
end;

end.
