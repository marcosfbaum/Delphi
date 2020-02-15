unit UTroco;

interface

uses System.SysUtils, System.StrUtils;

type
  TCedula = (ceNota100, ceNota50, ceNota20, ceNota10, ceNota5, ceNota2,
    ceMoeda100, ceMoeda50, ceMoeda25, ceMoeda10, ceMoeda5, ceMoeda1);

type
  TCedulaHelper = Record helper for TCedula
  public
    function ToDouble: Double;
    function GetDescricao: string;
    function GetValorStr: string;
  end;

type
  TTroco = class
  private
    FTipo: TCedula;
    FQuantidade: Integer;
    function GetTroco: string;
  public
    constructor Create(const aTipo: TCedula; aQuantidade: Integer);

    property Tipo: TCedula read FTipo;
    property Quantidade: Integer read FQuantidade write FQuantidade;
    property Troco: string read GetTroco;
  end;

implementation

{ TTroco }

//Construtor que recebe o parâmetro do tipo de cédula e a quantidade da mesma
constructor TTroco.Create(const aTipo: TCedula; aQuantidade: Integer);
begin
  FTipo := aTipo;
  Quantidade := aQuantidade;
end;

//Função que formata o troco para impressão
function TTroco.GetTroco: string;
const
  sResultDescricaoNota:  string  = '%d nota(s) de %s';
  sResultDescricaoMoeda:  string = '%d moeda(s) de %s';
  sResultDescricaoTroco: string  = '- %s(%s, %s);';
begin
  if Tipo in [ceNota100 .. ceNota2 ] then
    Result := Format(sResultDescricaoNota, [ Quantidade, Tipo.GetValorStr, '']).PadRight(30, ('_'))
  else
    Result := Format(sResultDescricaoMoeda, [ Quantidade, Tipo.GetValorStr]).PadRight(30);

  Result := RightStr(StringOfChar(' ', 5) + result, 35);
  Result := Result + Format(sResultDescricaoTroco, [ 'TTroco', Tipo.GetDescricao, Quantidade.ToString()])
end;

{ TCedulaHelper }

// Função que retorna a descrição das cédulas disponíveis
function TCedulaHelper.GetDescricao: string;
begin
  case Self of
    ceNota100:  Result := 'ceNota100';
    ceNota50:   Result := 'ceNota50';
    ceNota20:   Result := 'ceNota20';
    ceNota10:   Result := 'ceNota10';
    ceNota5:    Result := 'ceNota5';
    ceNota2:    Result := 'ceNota2';
    ceMoeda100: Result := 'ceMoeda100';
    ceMoeda50:  Result := 'ceMoeda50';
    ceMoeda25:  Result := 'ceMoeda25';
    ceMoeda10:  Result := 'ceMoeda10';
    ceMoeda5:   Result := 'ceMoeda5';
    ceMoeda1:   Result := 'ceMoeda1';
  end;
end;

//Função para retornar o valor da cédula para o tipo string.
function TCedulaHelper.GetValorStr: string;
begin
  case Self of
    ceNota100:  Result := '100';
    ceNota50:   Result := '50';
    ceNota20:   Result := '20';
    ceNota10:   Result := '10';
    ceNota5:    Result := '5';
    ceNota2:    Result := '2';
    ceMoeda100: Result := '1';
    ceMoeda50:  Result := '0.50';
    ceMoeda25:  Result := '0.25';
    ceMoeda10:  Result := '0.10';
    ceMoeda5:   Result := '0.05';
    ceMoeda1:   Result := '0.01';
  end;
end;

// Função para retornar o valor da cédula para o tipo double.
function TCedulaHelper.ToDouble: Double;
begin
  case Self of
    ceNota100:  Result := 100;
    ceNota50:   Result := 50;
    ceNota20:   Result := 20;
    ceNota10:   Result := 10;
    ceNota5:    Result := 5;
    ceNota2:    Result := 2;
    ceMoeda100: Result := 1;
    ceMoeda50:  Result := 0.50;
    ceMoeda25:  Result := 0.25;
    ceMoeda10:  Result := 0.10;
    ceMoeda5:   Result := 0.05;
    ceMoeda1:   Result := 0.01;
  end;
end;

end.
