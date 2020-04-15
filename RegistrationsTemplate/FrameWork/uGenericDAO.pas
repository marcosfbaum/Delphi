unit uGenericDAO;

interface

uses
  Data.DB, RTTI, TypInfo, System.SysUtils, uIConexaoDatabase, uEntityAttributes;


type
  TGEnericDAO = class
    private
      class function GetTableName<T: class>(const aObj: T): string;
      class function ExecSql(const aSql: string; const aConnDB: IConexao): TDataSet; static;
      class function ExecScript(const aSql: string; const aConnDB: IConexao): Integer; static;
      class function ContainsKeyFieldAttribute(const aAttributes: TArray<TCustomAttribute>): Boolean;
    public
      class function Filter(const aSql: string; const aConnDB: IConexao): TDataSet; overload;
      class function Filter<T: class>(const aObj: T; const aConnDB: IConexao;
        const aParams: array of string): TDataSet; overload;
      class function GetAll<T: class>(const aObj: T; const aConnDB: IConexao): TDataSet;
      class function Insert<T: class>(const aObj: T; const aConnDB: IConexao): Boolean;
  end;

implementation

{ TGEnericDAO }

class function TGEnericDAO.ExecSql(const aSql: string; const aConnDB: IConexao): TDataSet;
begin
  Result := aConnDB.ExecQuery(aSql);
end;

class function TGEnericDAO.ContainsKeyFieldAttribute(const aAttributes: TArray<TCustomAttribute>): Boolean;
var
  LAttribute: TCustomAttribute;
begin
  Result := False;
  for LAttribute in aAttributes do
    if LAttribute is KeyField then
      Exit(True);
end;

class function TGEnericDAO.ExecScript(const aSql: string; const aConnDB: IConexao): Integer;
begin
  Result := aConnDB.ExecScript(aSql);
end;

class function TGEnericDAO.Filter(const aSql: string; const aConnDB: IConexao): TDataSet;
begin
  try
    Result := ExecSql(aSql, aConnDB);
  except
    on E: Exception do
      raise E;
  end;
end;

class function TGEnericDAO.Filter<T>(const aObj: T; const aConnDB: IConexao; const aParams: array of string): TDataSet;
var
  LParam,
  LSql: string;
begin
  LSql := Format('SELECT T1.* FROM %s T1 ', [GetTableName(aObj)]);
  if (Length(aParams) > 0) then
    LSql := Concat(LSql, ' WHERE ');

  for LParam in aParams do
  begin
    LSql := Concat(LSql, 'INSTR( ', LParam, ', :', LParam, ') OR ');
  end;

  Delete(LSql, LSql.LastIndexOf('OR '), 3);
  Result := ExecSql(LSql, aConnDB);
end;

class function TGEnericDAO.GetAll<T>(const aObj: T; const aConnDB: IConexao): TDataSet;
begin
  try
    Result := ExecSql(Format('SELECT T1.* FROM %s T1 ', [GetTableName(aObj)]), aConnDB);
  except
    on E: Exception do
      raise E;
  end;
end;

class function TGEnericDAO.GetTableName<T>(const aObj: T): string;
var
  Contexto: TRttiContext;
  TypObj: TRttiType;
  Atributo: TCustomAttribute;
  strTable: String;
begin
  Contexto := TRttiContext.Create;
  TypObj := Contexto.GetType(TObject(aObj).ClassInfo);
  for Atributo in TypObj.GetAttributes do
  begin
    if Atributo is TableName then
      Exit(TableName(Atributo).Name);
  end;
end;

class function TGEnericDAO.Insert<T>(const aObj: T; const aConnDB: IConexao): Boolean;
var
  LRTTIContext: TRttiContext;
  TypObj: TRttiType;
  Prop: TRttiProperty;
  LStrInsert,
  LStrFields,
  LStrValues,
  LStrOnDuplicate,
  LValue: String;
  LAttribute: TCustomAttribute;
  LContainsKeyAttribute: Boolean;
begin
  LStrInsert      := EmptyStr;
  LStrFields      := EmptyStr;
  LStrValues      := EmptyStr;
  LStrOnDuplicate := EmptyStr;

  LStrInsert      := 'INSERT INTO ' + GetTableName(aObj);
  LStrOnDuplicate := ' ON DUPLICATE KEY UPDATE ';

  LRTTIContext := TRttiContext.Create;
  try
    TypObj := LRTTIContext.GetType(TObject(aObj).ClassInfo);

    for Prop in TypObj.GetProperties do
    begin
      LContainsKeyAttribute := ContainsKeyFieldAttribute(Prop.GetAttributes);

      for LAttribute in Prop.GetAttributes do
      begin
        if LAttribute is FieldName then
        begin
          LStrFields := Concat(LStrFields,  FieldName(LAttribute).Name, ',');

          if not LContainsKeyAttribute then
            LStrOnDuplicate := Concat(LStrOnDuplicate, FieldName(LAttribute).Name, ' = ');

          case Prop.GetValue(TObject(aObj)).Kind of

            tkWChar, tkLString, tkWString, tkString,
            tkChar, tkUString:
              LValue := QuotedStr(Prop.GetValue(TObject(aObj)).AsString);

            tkInteger, tkInt64:
              LValue := IntToStr(Prop.GetValue(TObject(aObj)).AsInteger);

            tkFloat:
              LValue := FloatToStr(Prop.GetValue(TObject(aObj)).AsExtended);
          else
            raise Exception.Create('Type not Supported.');
          end;

          LStrValues := Concat(LStrValues, LValue,  ',');
          if not LContainsKeyAttribute then
            LStrOnDuplicate := Concat(LStrOnDuplicate, LValue, ',');
        end;
      end;
    end;
    LStrFields      := Copy(LStrFields, 1, Length(LStrFields) - 1);
    LStrValues      := Copy(LStrValues, 1, Length(LStrValues) - 1);
    LStrOnDuplicate := Copy(LStrOnDuplicate, 1, Length(LStrOnDuplicate) - 1);

    LStrInsert := Concat(LStrInsert, ' ( ', LStrFields, ' ) ',
    ' VALUES ( ', LStrValues, ' ) ', LStrOnDuplicate);

    Result := (ExecScript(LStrInsert, aConnDB) > 0);
  finally
    LRTTIContext.Free;
  end;
end;

end.
