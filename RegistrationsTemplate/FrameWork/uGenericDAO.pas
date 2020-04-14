unit uGenericDAO;

interface

uses
  Data.DB, RTTI, TypInfo, System.SysUtils, uIConexaoDatabase, uEntityAttributes;


type
  TGEnericDAO = class
    private
      class function GetTableName<T: class>(const aObj: T): string;
    public
      class function Insert<T: class>(const aObj: T; const aConnDB: IConexao): Boolean;
      class function GetAll<T: class>(const aObj: T; const aConnDB: IConexao): TDataSet;
  end;

implementation

{ TGEnericDAO }

class function TGEnericDAO.GetAll<T>(const aObj: T; const aConnDB: IConexao): TDataSet;
begin

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
  LStrInsert, LStrFields, LStrValues: String;
  LAttribute: TCustomAttribute;
begin
  LStrInsert := EmptyStr;
  LStrFields := EmptyStr;
  LStrValues := EmptyStr;

  LStrInsert := 'INSERT INTO' + GetTableName(aObj);

  LRTTIContext := TRttiContext.Create;
  try
    TypObj := LRTTIContext.GetType(TObject(aObj).ClassInfo);

    for Prop in TypObj.GetProperties do begin
      for LAttribute in Prop.GetAttributes do begin
          if LAttribute is FieldName then begin
             LStrFields := Concat(LStrFields,  FieldName(LAttribute).Name, ',');
             case Prop.GetValue(TObject(aObj)).Kind of

               tkWChar, tkLString, tkWString, tkString,
               tkChar, tkUString:
                 LStrValues := Concat(LStrValues,
                 QuotedStr(Prop.GetValue(TObject(aObj)).AsString), ',');

               tkInteger, tkInt64:
                 LStrValues := Concat(LStrValues +
                 IntToStr(Prop.GetValue(TObject(aObj)).AsInteger), ',');

               tkFloat:
                 LStrValues := Concat(LStrValues +
                 FloatToStr(Prop.GetValue(TObject(aObj)).AsExtended), ',');
             else
              raise Exception.Create('Type not Supported.');
             end;
         end;
       end;
    end;
    LStrFields := Copy(LStrFields, 1, Length(LStrFields) - 1);
    LStrValues := Copy(LStrValues, 1, Length(LStrValues) - 1);
    LStrInsert := LStrInsert + ' ( ' + LStrFields + ' ) '+
    ' VALUES ( ' + LStrValues + ' )';

    Result := (aConnDB.ExecScript(LStrInsert, nil) > 0);
  finally
    LRTTIContext.Free;
  end;
end;

end.
