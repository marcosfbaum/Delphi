unit uSystemUtils;

interface

uses
  System.SysUtils;

type
  TSystemUtils = class
    public
      class function NumbersOnly(const aValues: string): string;
  end;

implementation

{ TSystemUtils }

class function TSystemUtils.NumbersOnly(const aValues: string): string;
var
  LValue: char;
begin
  Result := '';
  for LValue in aValues do
  begin
    if CharInSet(LValue, ['0'..'9', #8]) then
      Result := Concat(Result, LValue);
  end;
end;

end.
