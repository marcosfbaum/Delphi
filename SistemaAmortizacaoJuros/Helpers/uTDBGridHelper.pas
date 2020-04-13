unit uTDBGridHelper;

interface

uses
  System.Types, System.Classes,
  Vcl.Grids, Vcl.DbGrids, Vcl.Graphics,
  Firedac.Comp.Client,
  Data.DB;

type
  TDBGridHelper = class Helper for TDBGrid
  public
    procedure FormatCurrencyFields();
    procedure OnUserTitleClick(const Column: TColumn);
    procedure ZebrarDBGrid(const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
  end;

implementation

{ TDBGridHelper }

procedure TDBGridHelper.FormatCurrencyFields;
var
  I: Integer;
begin
  for i:= 0 to Self.FieldCount - 1 do
  begin
    if Self.Fields[I] is TCurrencyField then
      TCurrencyField(Self.Fields[i]).DisplayFormat := ',0.00';
  end;
end;

procedure TDBGridHelper.OnUserTitleClick(const Column: TColumn);
var
  I: Integer;
begin
  Assert((Self.DataSource.DataSet is TFDMemTable),
      'Atenção desenvolvedor, este método atualmente suporta apenas dataset TFDMemTable.');

  for I := 0 to Self.Columns.Count -1 do
    Self.Columns[I].Title.Font.Color := clBlack;

  if 'a' + Column.FieldName = TFDMemTable(Self.DataSource.DataSet).IndexName then
  begin
    TFDMemTable(Self.DataSource.DataSet).IndexName := 'd' + Column.FieldName;
    Column.Title.Font.Color := clGreen;
  end
  else
  begin
    TFDMemTable(Self.DataSource.DataSet).IndexName := 'a' + column.FieldName;
    Column.Title.Font.Color := clBlue;
  end;

  TFDMemTable(Self.DataSource.DataSet).First;
end;

procedure TDBGridHelper.ZebrarDBGrid(const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if Self.DataSource.DataSet.RecordCount = 0 then
    Exit;

//  Para Zebrar a Grid
  if Odd(Self.DataSource.DataSet.RecNo) then
    Self.Canvas.Brush.Color := $00F0F0F2
  else
  begin
    Self.Canvas.Brush.Color := clWebLightBlue;
    Self.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;

//  para que a linha selecionada fique destacada.
  if (gdSelected in State) then
  begin
    Self.Canvas.Brush.Color := clHotLight;
    Self.Canvas.Font.Color  := clWhite;
    Self.Canvas.FillRect(Rect);
    Self.DefaultDrawDataCell(Rect, Column.Field, State);
  end;
end;

end.
