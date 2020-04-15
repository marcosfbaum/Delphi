unit uIConexaoDatabase;

interface

  uses
    System.Classes,
    System.StrUtils,
    System.SysUtils,
    FireDAC.Comp.Client,
    Firedac.Stan.Def,
    Data.DB, FireDAC.Stan.Param;

type
  TParamsDB = class(TFDParams)

end;
type
  IConexao = Interface(IInterface)
    ['{DD9452FC-7E28-41ED-A448-65C8848DB9AD}']

    function  CarregarParametrosConexao: Boolean;
    function  DataBase(): String;
    function  ExecQuery(const ASql: String): TDataSet;
    function  ExecScript(const ASql: String): Integer; overload;
    procedure ExecProcedure(const AProcedureName: String);
    function  GetConnection(): TObject; overload;
    procedure StartTransaction();
    function  InTransaction(): Boolean;
    procedure Commit();
    procedure Rollback();
    procedure Open();
    procedure Close();
    procedure AddParam(const AName: String; AValue: Variant; const AType: TFieldType; const AClear: Boolean = True);
    function  GetIdConnection(): Int64;
    function  GetDateTimeNow(): TDateTime;
    function  IsSchemaExists(const Schema: String): Boolean;
    function  IsTableExists(const Table: String; const Schema: String = ''): Boolean;
    function  IsColumnExists(const Table: String; Column: String; const Schema: String = ''): Boolean;
    procedure CamposObrigatorios(DataSet: TDataSet);
end;
  implementation
end.
