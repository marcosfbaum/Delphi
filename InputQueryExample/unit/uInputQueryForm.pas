unit uInputQueryForm;

interface

uses
  Winapi.Windows,
  System.StrUtils, System.SysUtils, System.Classes, System.Types, System.Math,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Graphics, frxDesgnCtrls;

{$M+}

type
  TInputQueryForm = class(TForm)
  strict private
    FBtnConfirmar,
    FbtnCancelar: TButton;
    FPanelButtons: TPanel;
  private
    var
      FMin,
      FMax: Integer;
    FTotalAdded: Integer;
    FScroolBoxAll: TfrxScrollBox;
    FHeight: Integer;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SetTotalAdded(const Value: Integer);
    procedure SetupDialog;
    procedure SetFormHeight(const aValue: Integer);
    procedure ValidateIntegerInput(Sender: TObject);
    procedure ScrollBoxMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
      var Handled: Boolean);
  public
    var
      FCloseQueryFunc: TFunc<Boolean>;
    function CloseQuery: Boolean; override;

    constructor Create(const aCaption: string);
    destructor Destroy; override;

    procedure AddInteger(const aPrompt: string; const aValue: Integer); overload;
    procedure AddInteger(const aPrompt: string; const aValue: Integer; const aValidaterangeInput: Boolean); overload;
    procedure AddIntegerWithRange(const aPrompt: string; const aValue: Integer; const aMin, aMax: Integer);
    procedure GetIntegerValue(out aValue: Integer);
    procedure GetIntegerValues(out aValues: array of Integer);
  published
    property TotalAdded: Integer read FTotalAdded write SetTotalAdded;
  end;

{$M-}

implementation

{ TInputQueryForm }

function TInputQueryForm.CloseQuery: Boolean;
begin
  Result := (ModalResult in [mrCancel, mrClose]) or (not Assigned(FCloseQueryFunc)) or FCloseQueryFunc();
end;

constructor TInputQueryForm.Create(const aCaption: string);
begin
  inherited CreateNew(Application);
  Caption := aCaption;
  Height  := 76;

  TotalAdded  := 0;
  SetupDialog;
end;

destructor TInputQueryForm.Destroy;
begin
  inherited Destroy;
end;

procedure TInputQueryForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: FbtnCancelar.Click;
    VK_F9    :
      begin
        if FBtnConfirmar.Enabled then
          FBtnConfirmar.Click;
      end;
  end;
end;

procedure TInputQueryForm.GetIntegerValue(out aValue: Integer);
var
  I: Integer;
begin
  for I := 0 to Self.ComponentCount -1 do
  begin
    if Self.Components[I] is TEdit then
    begin
      if not TryStrToInt(Trim(TEdit(Self.Components[I]).Text), aValue) then
      begin
        TEdit(Self.Components[I]).SetFocus;
        raise EArgumentException.Create('Informe um valor inteiro válido.');
      end;
      Break;
    end;
  end;
end;

procedure TInputQueryForm.GetIntegerValues(out aValues: array of Integer);
var
  I,
  Index: Integer;
begin
  Index := 0;
  for I := 0 to Self.ComponentCount -1 do
  begin
    if Self.Components[I] is TEdit then
    begin
      if not TryStrToInt(Trim(TEdit(Self.Components[I]).Text), aValues[Index]) then
      begin
        TEdit(Self.Components[I]).SetFocus;
        raise EArgumentException.Create('Informe um valor inteiro válido.');
      end;
      Inc(Index);
    end;
  end;
end;

procedure TInputQueryForm.AddInteger(const aPrompt: string; const aValue: Integer);
begin
  AddInteger(aPrompt, aValue, False);
end;

procedure TInputQueryForm.AddInteger(const aPrompt: string; const aValue: Integer; const aValidateRangeInput: Boolean);
var
  LPanel: TPanel;
  LLabel: TLabel;
  LEdit: TEdit;
begin
  LPanel := TPanel.Create(Self);
  LPanel.Parent := FScroolBoxAll;
  with LPanel do
  begin
    Align      := alTop;
    Caption    := EmptyStr;
    Height     := 48;
    TabOrder   := FTotalAdded;
    BevelOuter := bvSpace;

    LLabel := TLabel.Create(Self);
    LLabel.Parent           := LPanel;
    LLabel.Caption          := IfThen(aValidaterangeInput, Concat(aPrompt, ' - Range: ', FMin.ToString, ' - ', FMax.ToString), aPrompt);
    LLabel.AlignWithMargins := True;
    LLabel.Align            := alTop;
    with LLabel.Margins do
    begin
      Top    := 3;
      Bottom := 0;
      Left   := 8;
      Right  := 3;
    end;
    LEdit := TEdit.Create(Self);
    LEdit.Parent           := LPanel;
    LEdit.Align            := alTop;
    LEdit.AlignWithMargins := True;
    with LEdit.Margins do
    begin
      Top    := 3;
      Bottom := 3;
      Left   := 8;
      Right  := 3;
    end;

    LEdit.NumbersOnly := True;
    LEdit.Text        := aValue.ToString();
    LEdit.TabOrder    := FTotalAdded;
    if aValidaterangeInput then
      LEdit.OnChange := ValidateIntegerInput;
  end;
  TotalAdded := FTotalAdded + 1;
  SetFormHeight(LPanel.Height);

  if aValidaterangeInput and FBtnConfirmar.Enabled then
    ValidateIntegerInput(LEdit);
end;

procedure TInputQueryForm.AddIntegerWithRange(const aPrompt: string; const aValue, aMin, aMax: Integer);
begin
  FMin := aMin;
  FMax := aMax;
  AddInteger(aPrompt, aValue, True);
end;

procedure TInputQueryForm.SetFormHeight(const aValue: Integer);
begin
  case FTotalAdded of
    1..3: Height := Height + aValue;
  end;
end;

procedure TInputQueryForm.SetTotalAdded(const Value: Integer);
begin
  FTotalAdded := Value;
end;

procedure TInputQueryForm.ScrollBoxMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
var
  ScrollBox: TScrollBox;
  NewPos: Integer;
begin
// So that when there is a scroll bar, the mouse can be used to scroll between the components

  ScrollBox := TScrollBox(Sender);

  NewPos:= ScrollBox.VertScrollBar.Position - WheelDelta div 10; //Sensitivity
  NewPos:= Max(NewPos, 0);
  NewPos:= Min(NewPos, ScrollBox.VertScrollBar.Range);
  ScrollBox.VertScrollBar.Position := NewPos;
  Handled := True;
end;

procedure TInputQueryForm.SetupDialog;
begin
  BorderIcons := [ biSystemMenu ];
  BorderStyle := bsSingle;
  KeyPreview  := True;
  Position    := poMainFormCenter;
  OnKeyDown   := FormKeyDown;

  FScroolBoxAll := TfrxScrollBox.Create(Self);
  FScroolBoxAll.OnMouseWheel := ScrollBoxMouseWheel;
  with FScroolBoxAll do
  begin
    Parent           := Self;
    Align            := alClient;
    AlignWithMargins := True;
    BorderStyle      := bsNone;
    TabOrder         := 0;

  end;

  FPanelButtons := TPanel.Create(Self);
  with FPanelButtons do
  begin
    Parent     := Self;
    Height     := 32;
    Align      := alBottom;
    BevelOuter := bvNone;
    TabOrder   := 1;

    FBtnConfirmar := TButton.Create(FPanelButtons);
    with FBtnConfirmar do
    begin
      Parent := FPanelButtons;
      AlignWithMargins := True;
      Align            := alRight;
      Caption          := 'F9 - Confirmar';
      Height           := 26;
      ModalResult      := mrOk;
      TabOrder         := 0;
      Width            := 90;
    end;

    FbtnCancelar := tbutton.Create(FPanelButtons);
    with FbtnCancelar do
    begin
      Parent := FPanelButtons;
      AlignWithMargins := True;
      Align            := alRight;
      Caption          := 'Esc - Cancelar';
      Height           := 26;
      ModalResult      := mrClose;
      TabOrder         := 1;
      Width            := 90;
    end;
  end;
end;

procedure TInputQueryForm.ValidateIntegerInput(Sender: TObject);
var
  I,
  LValue: Integer;
  LEnabled: Boolean;
begin
  LEnabled := True;
  for I := 0 to Self.ComponentCount -1 do
  begin
    if Self.Components[I] is TEdit then
    begin
      LEnabled := TryStrToInt(TEdit(Self.Components[I]).Text, LValue) and InRange(LValue, FMin, FMax);
      if (not LEnabled) then
        Break;
    end;
  end;
  FBtnConfirmar.Enabled := LEnabled;
end;

end.

