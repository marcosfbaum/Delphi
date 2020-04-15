unit uException.Validation;

interface

uses
  System.SysUtils, Vcl.Controls;

type
  EValidation = class(Exception)
    constructor Create(const aMessage: string; const aComponentFocus: TWinControl = nil);overload;
  end;

implementation

{ EValidation }

constructor EValidation.Create(const aMessage: string; const aComponentFocus: TWinControl);
begin
  if Assigned(aComponentFocus) and (aComponentFocus.CanFocus) then
    aComponentFocus.SetFocus;

  inherited Create(aMessage);
end;

end.
