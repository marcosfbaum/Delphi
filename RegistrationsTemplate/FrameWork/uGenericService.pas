unit uGenericService;

interface

uses
  System.Generics.Collections,
  uIConexaoDatabase, uConexaoDatabase,
  Data.DB, uGenericDAO;

type
  TGenericService = class
    private
      FConnDB: IConexao;
    public
      constructor Create(const aPathSistema: string);
      destructor Destroy; override;

      procedure AddParamsDB(const aFieldName, aParamValue: string; const aFieldType: TFieldType; const aClearParams: Boolean = True);
      function Filter(const aSql: string): TDataSet; overload;
      function Filter<T: class>(const aObj: T; const aParams: array of string): TDataSet; overload;
      function GetAll<T: class>(const aObj: T): TDataSet; overload;
      function Save<T: class>(const aObj: T): Boolean;
      procedure Commit;
      function InTransaction: Boolean;
      procedure Rollback;
      procedure StartTransaction;
    { Public declarations }
  end;

implementation

{ TGenericService }

procedure TGenericService.Commit;
begin
  FConnDB.Commit;
end;

constructor TGenericService.Create(const aPathSistema: string);
begin
  FConnDB := TConexaoBD.Create(aPathSistema);
end;

destructor TGenericService.Destroy;
begin
  FConnDB.Close;
  FConnDB._Release;
  inherited Destroy;
end;

procedure TGenericService.AddParamsDB(const aFieldName, aParamValue: string;
  const aFieldType: TFieldType; const aClearParams: Boolean);
begin
  FConnDB.AddParam(aFieldName, aParamValue, aFieldType, aClearParams);
end;

function TGenericService.Filter(const aSql: string): TDataSet;
begin
  Result := TGEnericDAO.Filter(aSql, FConnDB);
end;

function TGenericService.Filter<T>(const aObj: T; const aParams: array of string): TDataSet;
begin
  Result := TGEnericDAO.Filter(aObj, FConnDB, aParams);
end;

function TGenericService.GetAll<T>(const aObj: T): TDataSet;
begin
  Result := TGEnericDAO.GetAll(aObj, FConnDB);
end;

function TGenericService.InTransaction: Boolean;
begin
  Result := FConnDB.InTransaction;
end;

procedure TGenericService.Rollback;
begin
  if FConnDB.InTransaction then
    FConnDB.Rollback;
end;

function TGenericService.Save<T>(const aObj: T): Boolean;
begin
  Result := TGEnericDAO.Insert(aObj, FConnDB);
end;

procedure TGenericService.StartTransaction;
begin
  if FConnDB.InTransaction then
    FConnDB.Rollback;

  FConnDB.StartTransaction;
end;

end.
