unit uAlunoEntity;

interface

uses
  uEntity, uEntityAttributes;

type
  [TableName('TB_CAD_ALUNO')]
  TAlunoEntity = class(TGenericEntity)
  private
    FMatricula:string;
    FNomeAluno:string;
    FEndereco:string;
    FTelefone:string;
    FCPF:string;
    procedure setFMatricula(value:string);
    procedure setFNomeAluno(value:string);
    procedure setFEndereco(value:string);
    procedure setFTelefone(value:string);
    procedure setFCPF(value:string);
  public
    function ToString:string; override;
  published
    [KeyField('MATRICULA')]
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

procedure TAlunoEntity.setFMatricula(value:string);
begin
  FMatricula:= value;
end;

procedure TAlunoEntity.setFNomeAluno(value:string);
begin
  FNomeAluno:= value;
end;

procedure TAlunoEntity.setFEndereco(value:string);
begin
  FEndereco:= value;
end;

procedure TAlunoEntity.setFTelefone(value:string);
begin
  FTelefone:= value;
end;

procedure TAlunoEntity.setFCPF(value:string);
begin
  FCPF:= value;
end;


function TAlunoEntity.toString;
begin
  result := Concat('Matricula: ', Matricula, ' Nome: ', Nome,
  ' Endereco: ', Endereco, ' Fone: ', Telefone, ' CPF: ', CPF);
end;

end.
