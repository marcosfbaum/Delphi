unit uStudentEntity;

interface

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
    procedure setFMatricula(value:string);
    procedure setFNomeAluno(value:string);
    procedure setFEndereco(value:string);
    procedure setFTelefone(value:string);
    procedure setFCPF(value:string);
    procedure SetID(const Value: Integer);
  public
    function ToString:string; override;
  published

    [KeyField('ID')]
    [FieldName('ID')]
    property ID: Integer read FID write SetID;
    [FieldName('MATRICULA')]
    property Matricula: string read FMatricula write setFMatricula;
    [FieldName('NOME_ALUNO')]
    property Nome:string read FNomeAluno write setFNomeAluno;
    [FieldName('ENDERECO')]
    property Endereco:string read FEndereco write setFEndereco;
    [FieldName('TELEFONE')]
    property Telefone:string read FTelefone write setFTelefone;
    [FieldName('CPF')]
    property CPF:string read FCPF write setFCPF;
end;

implementation

procedure TStudentEntity.setFMatricula(value:string);
begin
  FMatricula:= value;
end;

procedure TStudentEntity.setFNomeAluno(value:string);
begin
  FNomeAluno:= value;
end;

procedure TStudentEntity.setFEndereco(value:string);
begin
  FEndereco:= value;
end;

procedure TStudentEntity.setFTelefone(value:string);
begin
  FTelefone:= value;
end;

procedure TStudentEntity.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TStudentEntity.setFCPF(value:string);
begin
  FCPF:= value;
end;

function TStudentEntity.toString;
begin
  result := Concat('Matricula: ', Matricula, ' Nome: ', Nome,
  ' Endereco: ', Endereco, ' Fone: ', Telefone, ' CPF: ', CPF);
end;

end.
