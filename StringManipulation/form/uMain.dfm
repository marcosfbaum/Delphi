object FMain: TFMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Manipulando strings'
  ClientHeight = 181
  ClientWidth = 395
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 12
    Top = 6
    Width = 32
    Height = 16
    Caption = 'Frase'
  end
  object Label2: TLabel
    Left = 12
    Top = 48
    Width = 32
    Height = 16
    Caption = 'Velha'
  end
  object Label3: TLabel
    Left = 12
    Top = 91
    Width = 28
    Height = 16
    Caption = 'Nova'
  end
  object edFrase: TEdit
    Left = 12
    Top = 23
    Width = 369
    Height = 24
    TabOrder = 0
    TextHint = 'Informe uma frase'
  end
  object edVelha: TEdit
    Left = 12
    Top = 66
    Width = 369
    Height = 24
    TabOrder = 1
    TextHint = 'Informe a parte do texto que ser'#225' removida'
  end
  object edNova: TEdit
    Left = 12
    Top = 109
    Width = 369
    Height = 24
    TabOrder = 2
    TextHint = 'Informe a parte do texto que ser'#225' adicionada'
  end
  object btnProcess: TButton
    Left = 306
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Processar'
    TabOrder = 3
    OnClick = btnProcessClick
  end
end
