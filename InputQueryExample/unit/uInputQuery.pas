unit uInputQuery;

interface

uses
  System.SysUtils, System.Classes, System.Types, System.Math,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Graphics, uInputQueryForm;

resourcestring
  SValidatePromptArray      = 'La longitud de la matriz de valores debe ser> = longitud de la matriz de solicitud.';
  SValidatePromptArrayEmpty = 'La matriz de avisos no debe estar vacía.';
  SValidateMinMax           = 'El valor mínimo debe ser menor que el valor máximo.';

type
  TInputIntegerArrayCloseQueryFunc = reference to function (const Values: array of Integer): Boolean;
  TInputIntegerCloseQueryFunc = reference to function (const Values: Integer): Boolean;

type
  TInputQuery = class
  strict private
    class var
      FPromptCount: Integer;
  private
    class procedure ValidateInputIntegerCloseQueryFunc(const aFrm: TInputQueryForm; const aInputCloseQueryFunc: TInputIntegerCloseQueryFunc); static;
    class procedure ValidateInputIntegerArrayCloseQueryFunc(const aFrm: TInputQueryForm;
      const aInputCloseQueryFunc: TInputIntegerArrayCloseQueryFunc); static;
  public
    class function AddInteger(const aCaption: string; const aPrompt: string; var aValue: Integer; const aInputCloseQueryFunc: TInputIntegerCloseQueryFunc = nil): Boolean; overload;
    class function AddInteger(const aCaption: string; const aPrompts: array of string; var aValues: array of Integer; const aInputCloseQueryFunc: TInputIntegerArrayCloseQueryFunc = nil): Boolean; overload;
    class function AddIntegerInRange(const aCaption, aPrompt: string; const aMin, aMax: Integer; var aValue: Integer): Boolean; overload;
    class function AddIntegerInRange(const aCaption: string; const aPrompts: array of string; const aMin, aMax: Integer; var aValues: array of Integer): Boolean; overload;
  end;

implementation

{ TInputQuery }

class procedure TInputQuery.ValidateInputIntegerCloseQueryFunc(const aFrm: TInputQueryForm; const aInputCloseQueryFunc: TInputIntegerCloseQueryFunc);
begin
  aFrm.FCloseQueryFunc := function: Boolean
    var
      LValue: Integer;
    begin
      Result := True;
      if Assigned(aInputCloseQueryFunc) then
      begin
        aFrm.GetIntegerValue(LValue);
        Result := aInputCloseQueryFunc(LValue);
      end;
    end;
end;

class procedure TInputQuery.ValidateInputIntegerArrayCloseQueryFunc(const aFrm: TInputQueryForm; const aInputCloseQueryFunc: TInputIntegerArrayCloseQueryFunc);
begin
  aFrm.FCloseQueryFunc := function: Boolean
    var
      LValues: array of Integer;
    begin
      Result := True;
      if Assigned(aInputCloseQueryFunc) then
      begin
        SetLength(Lvalues, FPromptCount);
        aFrm.GetIntegerValues(LValues);
        Result := aInputCloseQueryFunc(LValues);
      end;
    end;
end;

class function TInputQuery.AddInteger(const aCaption, aPrompt: string; var aValue: Integer; const aInputCloseQueryFunc: TInputIntegerCloseQueryFunc = nil): Boolean;
var
  LFrm: TInputQueryForm;
begin
  LFrm := TInputQueryForm.Create(aCaption);
  try
    LFrm.AddInteger(aPrompt, aValue, False);

    ValidateInputIntegerCloseQueryFunc(LFrm, aInputCloseQueryFunc);

    Result := LFrm.ShowModal = mrOK;
    if Result then
      LFrm.GetIntegerValue(aValue);
  finally
    Lfrm.Free;
  end;
end;

class function TInputQuery.AddInteger(const aCaption: string; const aPrompts: array of string;
  var aValues: array of Integer; const aInputCloseQueryFunc: TInputIntegerArrayCloseQueryFunc = nil): Boolean;
var
  LFrm: TInputQueryForm;
  I,
  Index: Integer;
begin
  if Length(aValues) < Length(APrompts) then
    raise EInvalidOperation.Create(SValidatePromptArray);

  FPromptCount := Length(APrompts);
  if FPromptCount < 1 then
    raise EInvalidOperation.Create(SValidatePromptArrayEmpty);

  LFrm := TInputQueryForm.Create(aCaption);
  try
    for I := 0 to FPromptCount - 1 do
      LFrm.AddInteger(aPrompts[I], aValues[I], False);

    ValidateInputIntegerArrayCloseQueryFunc(lfrm, aInputCloseQueryFunc);

    Result := LFrm.ShowModal = mrOK;
    if Result then
      LFrm.GetIntegerValues(aValues);
  finally
    Lfrm.Free;
  end;
end;

class function TInputQuery.AddIntegerInRange(const aCaption, aPrompt: string; const aMin, aMax: Integer; var aValue: Integer): Boolean;
var
  LFrm: TInputQueryForm;
begin
  if aMin >= aMax then
    raise EInvalidOperation.Create(SValidateMinMax);

  LFrm := TInputQueryForm.Create(aCaption);
  try
    LFrm.AddIntegerWithRange(aPrompt, aValue, aMin, aMax);
    Result := LFrm.ShowModal = mrOK;
    if Result then
      LFrm.GetIntegerValue(aValue);
  finally
    Lfrm.Free;
  end;
end;

class function TInputQuery.AddIntegerInRange(const aCaption: string; const aPrompts: array of string; const aMin,
  aMax: Integer; var aValues: array of Integer): Boolean;
var
  LFrm: TInputQueryForm;
  I,
  Index: Integer;
begin
  FPromptCount := Length(APrompts);

  if (Length(aValues) < FPromptCount) then
    raise EInvalidOperation.Create(SValidatePromptArray);

  if (FPromptCount < 1) then
    raise EInvalidOperation.Create(SValidatePromptArrayEmpty);

  if (aMin >= aMax) then
    raise EInvalidOperation.Create(SValidateMinMax);

  LFrm := TInputQueryForm.Create(aCaption);
  try
    for I := 0 to FPromptCount -1 do
      LFrm.AddIntegerWithRange(aPrompts[I], aValues[I], amin, amax);

    Result := LFrm.ShowModal = mrOK;
    if Result then
      LFrm.GetIntegerValues(aValues);
  finally
    Lfrm.Free;
  end;
end;

end.
