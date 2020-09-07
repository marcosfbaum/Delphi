unit uFinance.Controller;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections,
  uInstallment, uException.Validation, uFinancing, uIFinancing;

type
  TFinanceController = class
  private
    procedure ValidateBeforeCalculateFunding(const [ref] aFinancing: TFinancing);
  public
    procedure CalculateFinancing(const [ref] aFinancing: TFinancing);
    procedure GetDefaultInstallments(const [ref] aOutInstallments: TList<Integer>);

    constructor Create; overload;
    destructor Destroy; override;
  end;

implementation

{ TFinanceController }

constructor TFinanceController.Create;
begin
end;

destructor TFinanceController.Destroy;
begin
  inherited Destroy;
end;

// Retorna as parcelas disponíveis para financiamento.
// Utiliza Instancia local de TFinancing por não utilizar em outros lugares..
// mas pode ser movida para escopo privado de classe caso necessário
procedure TFinanceController.GetDefaultInstallments(const [ref] aOutInstallments: TList<Integer>);
var
  LFinancing: TFinancing;
begin
  LFinancing := TFinancing.Create;
  try
    LFinancing.Installment.CloneDefaultInstallments(aOutInstallments);
    if (aOutInstallments.Count = 0) then
      raise EValidation.Create('Não foi possível carregar as parcelas disponíveis.');
  finally
    LFinancing.Free;
  end;
end;

//Método para realizar a validação das entradas do usuário
procedure TFinanceController.ValidateBeforeCalculateFunding(const [ref] aFinancing: TFinancing);
begin
  if (aFinancing.InterestRate <= 0) or (aFinancing.InterestRate > 100) then
    raise EValidation.Create(Concat('Taxa de juros informada é inválida.', sLineBreak, 'Verifique!'));

  if (not aFinancing.Installment.InRange(aFinancing.QuantityInstallments)) then
    raise EValidation.Create(Concat('Quantidade de parcelas informadas é inválida.', sLineBreak, 'Verifique!'));

  if (aFinancing.Capital <= 0) then
    raise EValidation.Create(Concat('Capital informado é inválido.', sLineBreak, 'Verifique'));

  if (aFinancing.Capital > aFinancing.MAX_VALUE_CAPITAL) then
    raise EValidation.Create(Format(Concat('O capital informado é maior do que o disponível para empréstimo.', sLineBreak,
      '%s é o valor máximo para empréstimo.'), ['9.999.999.999,99']));
end;

//Metodo para calcular o financiamento. Precisa de uma instância de TFinancing para
// que possa listar os dados na view.
procedure TFinanceController.CalculateFinancing(const [ref] aFinancing: TFinancing);
begin
  ValidateBeforeCalculateFunding(aFinancing);
  aFinancing.Calculate();
end;

end.
