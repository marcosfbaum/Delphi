object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 438
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnAddInteger: TButton
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 618
    Height = 40
    Align = alTop
    Caption = 'Add Integer'
    TabOrder = 0
    OnClick = btnAddIntegerClick
  end
  object AddIntegerArray: TButton
    AlignWithMargins = True
    Left = 3
    Top = 95
    Width = 618
    Height = 40
    Align = alTop
    Caption = 'Add integer array'
    TabOrder = 1
    OnClick = AddIntegerArrayClick
  end
  object btnAddIntegerWithRangeValidation: TButton
    AlignWithMargins = True
    Left = 3
    Top = 49
    Width = 618
    Height = 40
    Align = alTop
    Caption = ' Add integer with range validation'
    TabOrder = 2
    OnClick = btnAddIntegerWithRangeValidationClick
  end
  object AddIntegerArrayWithRangeValidation: TButton
    AlignWithMargins = True
    Left = 3
    Top = 141
    Width = 618
    Height = 40
    Align = alTop
    Caption = 'Add integer array with range validation'
    TabOrder = 3
    OnClick = AddIntegerArrayWithRangeValidationClick
  end
  object mResults: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 233
    Width = 618
    Height = 202
    Align = alClient
    ScrollBars = ssBoth
    TabOrder = 4
  end
  object btnResetResult: TButton
    AlignWithMargins = True
    Left = 3
    Top = 187
    Width = 618
    Height = 40
    Align = alTop
    Caption = 'Reset results'
    TabOrder = 5
    OnClick = btnResetResultClick
  end
end
