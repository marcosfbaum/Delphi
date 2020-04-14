unit uConexaoDatabase;

interface

uses
  System.SysUtils,
  System.UITypes,
  System.Strutils,
  uIConexaoDatabase,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Stan.Consts,
  FireDAC.Comp.Client, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.Moni.Custom,
  FireDAC.Moni.Base, FireDAC.Stan.Util,
  Data.DB,
  Vcl.Dialogs,
  uIniFile.Utils;

type
  TparametrosConexao = record
    PathSistema,
    UserName,
    Password,
    DataBase,
    DriverID,
    Server,
    Port: string;
end;

type
  TConexaoBD = class(TInterfacedObject, IConexao)
      FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    strict private
      FConnection: TFDConnection;
      FTransaction: TFDTransaction;
      FMoniCustom: TFDMoniCustomClientLink;
      FParamsConexao: TparametrosConexao;
      FFilialFisica: SmallInt;
      procedure CriaConnectionDB();
      function  GetObjQuery(const ASql: String; AParams: TParamsDB = nil): TFDQuery;
      procedure ConnAfterConnect(Sender: TObject);
      function  GetMyFilial(): SmallInt;
      const
        FSectionConnParams: string = 'CONN_MYSQL';
        FNameIniFile: string = 'ConnectionsParams.Ini';
    private
      function  CarregarParametrosConexao: Boolean;
    public
      function  DataBase(): String;
      function  ExecQuery(const ASql: String; AParams: TParamsDB = nil): TDataSet;
      function  ExecScript(const ASql: String; AParams: TParamsDB = nil): Integer; overload;
      function  ExecScript(const ASql: String): Integer; overload;
      procedure ExecProcedure(const AProcedureName: String; AParams: TParamsDB = nil);
      function  GetConnection(): TObject;
      procedure StartTransaction();
      function  InTransaction(): Boolean;
      procedure Commit();
      procedure Rollback();
      procedure Open();
      procedure Close();
      procedure AddParam(var AParams: TParamsDB; const AName: String; AValue: Variant; const AType: TFieldType; const AClear: Boolean = True);
      function  GetIdConnection(): Int64;
      function  GetDateTimeNow(): TDateTime;
      function  IsSchemaExists(const Schema: String): Boolean;
      function  IsTableExists(const Table: String; const Schema: String = ''): Boolean;
      function  IsColumnExists(const Table: String; Column: String; const Schema: String = ''): Boolean;
      procedure CamposObrigatorios(DataSet: TDataSet);
      constructor Create(const APathSistema: String; const AUserName: String = ''; const ADataBase: String = '');
      destructor Destroy(); override;
  end;

implementation

{ TConexaoBD }

constructor TConexaoBD.Create(const APathSistema: String; const AUserName: String = ''; const ADataBase: String = '');
begin
  inherited Create;
  CarregarParametrosConexao;
  FParamsConexao.PathSistema := IfThen(APathSistema <> EmptyStr, APathSistema, FParamsConexao.PathSistema);
  FParamsConexao.UserName    := IfThen(AUserName <> EmptyStr, AUserName, FParamsConexao.UserName);
  FParamsConexao.DataBase    := IfThen(ADataBase <> EmptyStr, ADataBase, FParamsConexao.DataBase);
  FDPhysMySQLDriverLink1     := TFDPhysMySQLDriverLink.Create(nil);
  CriaConnectionDB();

  FFilialFisica := GetMyFilial();
end;

procedure TConexaoBD.Close;
begin
  if (FConnection <> nil) then
    if (FConnection.Connected) then
      FConnection.Connected := False;
end;

procedure TConexaoBD.Commit;
begin
  if (InTransaction()) then
    FTransaction.Commit;
end;

procedure TConexaoBD.ConnAfterConnect(Sender: TObject);
begin
  (Sender as TFDConnection).ExecSQL('set session group_concat_max_len = 4294967295;');
end;

procedure TConexaoBD.CriaConnectionDB;
// Adiciona novo usuário no banco de dados...
  procedure AddNewUser(const AUser, APassword: String);
  begin
    // Adiciona usuário já liberando todos os privilegios
    ExecScript('grant all privileges on *.* to "'+ AUser +'"@"%" identified by "'+ APassword +'";', nil);
    // Atualiza as permissões
    ExecScript('flush privileges;', nil);
  end;
const
  CLibMySQL = 'LIBMYSQL';
begin
  FDPhysMySQLDriverLink1.VendorLib := 'libmysql.dll';// Concat(FParamsConexao.PathSistema, );
  FDPhysMySQLDriverLink1.DriverID := 'MySQL';
  FConnection := TFDConnection.Create(nil);
  with FConnection do
  begin
    Params.Clear;
    Params.Add('DriverID=MySQL');
    Params.Add('Server='    + FParamsConexao.Server);
    Params.Add('Port='      + FParamsConexao.Port);
    Params.Add('Database='  + FParamsConexao.DataBase);
    Params.Add('User_Name=' + FParamsConexao.UserName);
    Params.Add('Password='  + FParamsConexao.Password);
    Params.Add('MonitorBy=Custom');
    Params.Add('TinyIntFormat=Integer');
    Params.Add('WriteTimeout=30');
    ResourceOptions.AssignedValues := [rvAutoConnect, rvAutoReconnect];
    ResourceOptions.AutoReconnect := True;
    TxOptions.DisconnectAction    := xdRollback;
    FetchOptions.Mode             := fmAll;
    AfterConnect                  := ConnAfterConnect;
    try
      Connected := True;
    except
      on Efd: EFDException do
      begin
        case Efd.FDCode of
//          er_FD_AccCantLoadLibrary,
//          er_FD_AccCantGetLibraryEntry:
//            begin
//              if (not FindFileResource(CLibMySQL)) then
//                raise;
//              SaveFileResource(CLibMySQL, _PathSistema + 'libmySQL.dll');
//            end;
          er_FD_MySQLGeneral:
            begin
              MessageDlg('Ocorreu um erro ao conectar ao banco de dados.' + sLineBreak + 'Detalhes: ' + Efd.Message, mtError, [mbOK], 0);
              Params.Values['User_Name'] := FParamsConexao.UserName;
              Connected := True;
              AddNewUser(FParamsConexao.UserName, FParamsConexao.Password);
              Connected := False;
              Params.Values['User_Name'] := FParamsConexao.UserName;
            end;
        else
//          if (not FindFileResource(CLibMySQL)) then
//            raise;
//          SaveFileResource(CLibMySQL, FParamsConexao.PathSistema + 'libmySQL.dll');
        end;

        //Tenta conectar novamente para ver se corrigiu
        if (not Connected) then
          Connected := True;

      end;
      on Ex: Exception do
        raise;
    end;
  end;
end;

procedure TConexaoBD.AddParam(var AParams: TParamsDB; const AName: String; AValue: Variant; const AType: TFieldType; const AClear: Boolean);
var
  parm: TFDParam;
begin
  if (AParams = nil) then
  begin
    AParams := TParamsDB.Create;
    AParams.BindMode := pbByName;
  end;

  parm := AParams.Add(AName, AType, -1, ptInput);
  case AType of
    ftInteger,
    ftWord,
    ftFloat,
    ftCurrency,
    ftDate,
    ftTime,
    ftDateTime,
    ftTimeStamp,
    ftLargeint,
    ftLongWord,
    ftShortint,
    ftExtended,
    ftFMTBcd:
      begin
        if (AClear) and (AValue = 0) then
          parm.Clear
        else
          parm.Value := AValue;
      end;
    ftSmallint,
    ftByte,
    ftSingle:
      begin
        parm.Value := AValue;
      end;
    ftString,
    ftWideString,
    ftWideMemo,
    ftFixedChar,
    ftFixedWideChar:
      begin
        if (AClear) and (AValue = '') then
          parm.Clear
        else
          parm.Value := AValue;
      end;
    ftBlob:
      begin
        if (AValue <> '') then
          parm.LoadFromFile(AValue, ftBlob)
        else
          parm.Clear;
      end;
  else
    parm.Value := AValue;
  end;
end;

procedure TConexaoBD.CamposObrigatorios(DataSet: TDataSet);
var
   I: Integer;
begin
  for I := 0 to Pred(DataSet.FieldCount) do
  begin
    with DataSet.Fields.Fields[I] do
    begin
      if (Required) then
      begin
        if (not SameText(Origin,  'key')) then
          if (AsString.Trim.IsEmpty) then
          begin
            FocusControl;
            raise Exception.CreateFmt('O Campo "%s" deve ser Informado!', [DisplayLabel]);
          end;
      end
      else begin
        if (AsString.Trim.IsEmpty) then
          Clear;
      end;
    end;
  end;
end;

function TConexaoBD.CarregarParametrosConexao: Boolean;
begin
  //Carrega os parametros para conexão
  Result := False;
  try
    FParamsConexao.PathSistema := TIniFileUtils.Read(FNameIniFile, FSectionConnParams, 'PATH_SISTEMA', '');
    FparamsConexao.Server      := TIniFileUtils.Read(FNameIniFile, FSectionConnParams, 'SERVER', '');
    FparamsConexao.Port        := TIniFileUtils.Read(FNameIniFile, FSectionConnParams, 'PORT', '3306');

    if (DebugHook <> 0) then
    begin
      FparamsConexao.UserName := 'root';
      FparamsConexao.Password := 'root';
    end
    else
    begin
      FparamsConexao.UserName := 'seq_user';//'backup';
      FparamsConexao.Password := 'seq_password';//'19100116##';
    end;

    FparamsConexao.DataBase := TIniFileUtils.Read(FNameIniFile, FSectionConnParams, 'DATABASE', 'softpharma');
    FparamsConexao.DriverID := 'MYSQL';
    Result := True;
  except
    on E: Exception do
    begin
      MessageDlg('Ocorreu um erro ao carregar os dados para conexão com o banco de dados.' + sLineBreak
        + 'Verifique suas configurações de conexão.', mtError, [mbOK], 0);
      Abort;
    end;
  end;
end;

function TConexaoBD.DataBase: String;
begin
  Result := FParamsConexao.DataBase;
end;

destructor TConexaoBD.Destroy;
begin
  if (FDPhysMySQLDriverLink1 <> nil) then
    FreeAndNil(FDPhysMySQLDriverLink1);
  Close();
  if (FConnection <> nil) then
    FreeAndNil(FConnection);
  if (FTransaction <> nil) then
    FreeAndNil(FTransaction);
  if (FMoniCustom <> nil) then
    FreeAndNil(FMoniCustom);
  inherited;
end;

procedure TConexaoBD.ExecProcedure(const AProcedureName: String; AParams: TParamsDB);
var
  FDStoredProc: TFDStoredProc;
begin
  FDStoredProc := TFDStoredProc.Create(nil);
  try
    with FDStoredProc do
    begin
      Connection     := FConnection;
      CatalogName    := FParamsConexao.DataBase;
      StoredProcName := AProcedureName;
      if (AParams <> nil) then
      begin
        AParams.BindMode := pbByName;
        Params := AParams;
      end;
      Prepare();
      ExecProc();
    end;
  finally
    if (AParams <> nil) then
      FreeAndNil(AParams);
    FreeAndNil(FDStoredProc);
  end;
end;

function TConexaoBD.ExecQuery(const ASql: String; AParams: TParamsDB): TDataSet;
var
  oQry: TFDQuery;
begin
  Result := nil;
  try
    oQry := GetObjQuery(ASql, AParams);
    try
      oQry.Prepare;
      oQry.Open;
    finally
      if (oQry.RecordCount > 0) then
        Result := oQry
      else begin
        oQry.Close;
        FreeAndNil(oQry);
      end;
    end;
  finally
    if (AParams <> nil) then
      FreeAndNil(AParams);
  end;
end;

function TConexaoBD.ExecScript(const ASql: String; AParams: TParamsDB): Integer;
begin
  Result := ExecScript(ASql, nil);
end;

function TConexaoBD.ExecScript(const ASql: String): Integer;
begin
   Result := ExecScript(ASql, nil);
end;

function TConexaoBD.GetConnection: TObject;
begin
  Result := FConnection;
end;

function TConexaoBD.GetDateTimeNow: TDateTime;
var
  dtSet: TDataSet;
begin
  Result := 0;
  dtSet := ExecQuery('select now()');
  if (dtSet <> nil) then
    Result := dtSet.Fields[0].AsDateTime;
  FreeAndNil(dtSet);
end;

function TConexaoBD.GetIdConnection: Int64;
var
  dtSet: TDataSet;
begin
  Result := 0;
  dtSet := ExecQuery('select connection_id()');
  if (dtSet <> nil) then
    Result := dtSet.Fields[0].AsLargeInt;
  FreeAndNil(dtSet);
end;

function TConexaoBD.GetMyFilial: SmallInt;
var
  dtSet: TDataSet;
begin
  Result := 0;
  dtSet := ExecQuery('select idmyfg from myfilial limit 1');
  if (Assigned(dtSet)) then
  begin
    Result := dtSet.Fields[0].AsInteger;
    FreeAndNil(dtSet);
  end;
end;

function TConexaoBD.GetObjQuery(const ASql: String; AParams: TParamsDB): TFDQuery;
begin
  if (not FConnection.Connected) then
    FConnection.Connected := True;

  Result := TFDQuery.Create(nil);
  Result.FetchOptions.RecordCountMode := cmTotal;
  Result.Connection := FConnection;
  Result.SQL.Text := ASql;
  if (AParams <> nil) then
  begin
    AParams.BindMode := pbByName;
    Result.Params := AParams;
  end;
end;

function TConexaoBD.InTransaction: Boolean;
begin
  Result := FTransaction.Active;
end;

function TConexaoBD.IsColumnExists(const Table: String; Column: String; const Schema: String): Boolean;
var
  sql: String;
  params: TParamsDB;
  dataSet: TDataSet;
begin
  Result := False;
  sql :=
    'select count(1) '+
    'from information_schema.columns '+
    'where table_schema = coalesce(:table_schema, database()) '+
      'and table_name = :table_name '+
      'and column_name = :column_name';
  params := nil;
  AddParam(params, 'table_schema', Schema, ftString, True);
  AddParam(params, 'table_name', Table, ftString);
  AddParam(params, 'column_name', Column, ftString);
  dataSet := ExecQuery(sql, params);
  Result := (dataSet.Fields[0].AsInteger > 0);
  FreeAndNil(dataSet);
end;

function TConexaoBD.IsSchemaExists(const Schema: String): Boolean;
var
  sql: String;
  params: TParamsDB;
  dataSet: TDataSet;
begin
  Result := False;
  sql :=
    'select count(1) '+
    'from information_schema.schemata '+
    'where schema_name = :schema_name';
  params := nil;
  AddParam(params, 'schema_name', Schema, ftString);
  dataSet := ExecQuery(sql, params);
  Result := (dataSet.Fields[0].AsInteger > 0);
  FreeAndNil(dataSet);
end;

function TConexaoBD.IsTableExists(const Table, Schema: String): Boolean;
var
  sql: String;
  params: TParamsDB;
  dataSet: TDataSet;
begin
  Result := False;
  sql :=
    'select count(1) '+
    'from information_schema.tables '+
    'where table_schema = coalesce(:table_schema, database()) '+
      'and table_name = :table_name';
  params := nil;
  AddParam(params, 'table_schema', Schema, ftString, True);
  AddParam(params, 'table_name', Table, ftString);
  dataSet := ExecQuery(sql, params);
  Result := (dataSet.Fields[0].AsInteger > 0);
  FreeAndNil(dataSet);
end;

procedure TConexaoBD.Open;
begin
  try
    if (FConnection <> nil) then
      if (not FConnection.Connected) then
        FConnection.Connected := True;
  except
    on E: Exception do
    begin
      MessageDlg('Ocorreu um erro ao conectar no banco de dados.' + sLineBreak
        + 'Detalhes.' + E.Message, mtError, [mbOK], 0);

        FConnection.Connected := False;
      Abort;
    end;
  end;
end;

procedure TConexaoBD.Rollback;
begin
if (InTransaction()) then
    FTransaction.Rollback;
end;

procedure TConexaoBD.StartTransaction;
begin
  FTransaction.StartTransaction;
end;

end.
