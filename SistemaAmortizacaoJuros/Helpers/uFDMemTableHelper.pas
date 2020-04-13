unit UFDMemTableHelper;

interface

uses
    FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Stan.Intf;

type
  TMemTableHelper = class Helper for TFdmemTable
    public
      procedure CreateIndices();

  end;

implementation

{ TFDMemTableHelper }

procedure TMemTableHelper.CreateIndices;
var
  I: Integer;
begin
  TFdMemTable(Self).Indexes.Clear;
  for I := 0 to Self.FieldCount - 1 do
  begin
    with TFdMemTable(Self).Indexes.Add do
    begin
      Name    := 'a' + Self.Fields[i].FieldName;
      Fields  := Self.Fields[i].FieldName;
      Options := [];
      Active  := True;
    end;
    with TFdMemTable(Self).Indexes.Add do
    begin
      Name    := 'd' + Self.Fields[i].FieldName;
      Fields  := Self.Fields[i].FieldName;
      Options := [soDescending];
      Active  := True;
    end;
  end;
end;

end.
