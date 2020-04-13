unit uTEditHelper;

interface

uses
  System.SysUtils,
  Vcl.StdCtrls;

type
  TEditHelper = class Helper for TEdit
  public
    function IsNumber(var Key: Char): Boolean;
    function IsNumberOrComma(var Key: Char): Boolean;
  end;

implementation

{ TEditHelper }

function TEditHelper.IsNumber(var Key: Char): Boolean;
begin
  Result := CharInSet(Key, ['0'..'9']);
end;

function TEditHelper.IsNumberOrComma(var Key: Char): Boolean;
begin
  Result := CharInSet(Key, [',', '0'..'9']);
end;

end.
