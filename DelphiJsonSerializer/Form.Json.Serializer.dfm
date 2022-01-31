object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 420
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object mmoJson: TMemo
    Left = 0
    Top = 0
    Width = 635
    Height = 185
    Align = alTop
    Lines.Strings = (
      'mmoJson')
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object gbPeople: TGroupBox
    Left = 0
    Top = 185
    Width = 635
    Height = 136
    Align = alTop
    Caption = 'People'
    TabOrder = 1
    object edName: TLabeledEdit
      Left = 16
      Top = 28
      Width = 225
      Height = 21
      EditLabel.Width = 27
      EditLabel.Height = 13
      EditLabel.Caption = 'Name'
      TabOrder = 0
    end
    object edAge: TLabeledEdit
      Left = 16
      Top = 71
      Width = 121
      Height = 21
      EditLabel.Width = 19
      EditLabel.Height = 13
      EditLabel.Caption = 'Age'
      NumbersOnly = True
      TabOrder = 1
    end
    object gpAddress: TGroupBox
      AlignWithMargins = True
      Left = 345
      Top = 18
      Width = 285
      Height = 113
      Align = alRight
      Caption = '[ Address ]'
      TabOrder = 2
      ExplicitLeft = 316
      ExplicitTop = 14
      ExplicitHeight = 105
      object edStreet: TLabeledEdit
        Left = 24
        Top = 31
        Width = 225
        Height = 21
        EditLabel.Width = 30
        EditLabel.Height = 13
        EditLabel.Caption = 'Street'
        TabOrder = 0
      end
      object edNumber: TLabeledEdit
        Left = 24
        Top = 74
        Width = 225
        Height = 21
        EditLabel.Width = 37
        EditLabel.Height = 13
        EditLabel.Caption = 'Number'
        TabOrder = 1
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 374
    Width = 635
    Height = 46
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitTop = 422
    object btnSerializeJson: TButton
      AlignWithMargins = True
      Left = 284
      Top = 3
      Width = 112
      Height = 40
      Align = alRight
      Caption = 'Serialize Json'
      TabOrder = 0
      OnClick = btnSerializeJsonClick
      ExplicitLeft = 263
      ExplicitTop = 9
      ExplicitHeight = 43
    end
    object btnDeserializeJson: TButton
      AlignWithMargins = True
      Left = 402
      Top = 3
      Width = 112
      Height = 40
      Align = alRight
      Caption = 'Deserialize Json'
      TabOrder = 1
      OnClick = btnDeserializeJsonClick
      ExplicitLeft = 381
      ExplicitTop = 9
      ExplicitHeight = 43
    end
    object btnClear: TButton
      AlignWithMargins = True
      Left = 520
      Top = 3
      Width = 112
      Height = 40
      Align = alRight
      Caption = 'Clear'
      TabOrder = 2
      OnClick = btnClearClick
      ExplicitLeft = 499
      ExplicitTop = 9
      ExplicitHeight = 43
    end
  end
end
