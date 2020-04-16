unit uStudentEntity;

interface

{$M+}

uses
  uEntity, uEntityAttributes;

ResourceString
  rsFilterSQL = 'SELECT * FROM TB_CAD_ALUNO WHERE INSTR(NOME_ALUNO, :NOME_ALUNO) ORDER BY NOME_ALUNO';

type
  [TableName('TB_CAD_ALUNO')]
  TStudentEntity = class(TGenericEntity)
  private
    FMatricula:string;
    FNomeAluno:string;
    FEndereco:string;
    FTelefone:string;
    FCPF:string;
    FID: Integer;
    procedure SetMatricula(value:string);
    procedure SetNomeAluno(value:string);
    procedure SetEndereco(value:string);
    procedure SetTelefone(value:string);
    procedure SetCPF(value:string);
    procedure SetID(const Value: Integer);
  public
    function ToString:string; override;
  published
    [KeyField('ID')]
    [FieldName('ID')]
    property ID: Integer read FID write SetID;
    [FieldName('MATRICULA')]
    property Matricula: string read FMatricula write SetMatricula;
    [FieldName('NOME_ALUNO')]
    property Nome:string read FNomeAluno write SetNomeAluno;
    [FieldName('ENDERECO')]
    property Endereco:string read FEndereco write SetEndereco;
    [FieldName('TELEFONE')]
    property Telefone:string read FTelefone write SetTelefone;
    [FieldName('CPF')]
    property CPF:string read FCPF write SetCPF;
end;

{$M-}

implementation

procedure TStudentEntity.SetMatricula(value:string);
begin
  FMatricula:= value;
end;

procedure TStudentEntity.SetNomeAluno(value:string);
begin
  FNomeAluno:= value;
end;

procedure TStudentEntity.SetEndereco(value:string);
begin
  FEndereco:= value;
end;

procedure TStudentEntity.SetTelefone(value:string);
begin
  FTelefone:= value;
end;

procedure TStudentEntity.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TStudentEntity.SetCPF(value:string);
begin
  FCPF:= value;
end;

function TStudentEntity.ToString;
begin
  Result := Concat('Matricula: ', Matricula, ' Nome: ', Nome,
  ' Endereco: ', Endereco, ' Fone: ', Telefone, ' CPF: ', CPF);
end;

end.
