unit UExeptionExtension;

interface
  uses System.SysUtils, Vcl.Controls;

type
  EValidation = class(Exception)
    constructor Create(const aMessage: string; const aComponentFocus: TWinControl = nil);overload;
  end;
implementation

{ EValidation }

// Cria uma excessão podendo ser informado ou não um componente para receber o foco.
constructor EValidation.Create(const aMessage: string; const aComponentFocus: TWinControl = nil);
begin
  if Assigned(aComponentFocus) then
    aComponentFocus.SetFocus;
  inherited Create(aMessage);
end;

end.
