object FMain: TFMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'M'#225'quina de dinheiro'
  ClientHeight = 346
  ClientWidth = 423
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
    Left = 16
    Top = 37
    Width = 49
    Height = 16
    Caption = 'Valor R$'
  end
  object Label2: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 417
    Height = 24
    Align = alTop
    Alignment = taCenter
    Caption = 'M'#225'quina de dinheiro'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 181
  end
  object edValor: TEdit
    Left = 16
    Top = 56
    Width = 389
    Height = 24
    TabOrder = 0
    TextHint = 'Informe o valor para processar o troco'
  end
  object btnProcessarTroco: TButton
    Left = 295
    Top = 86
    Width = 110
    Height = 25
    Caption = 'Processar troco'
    TabOrder = 1
    OnClick = btnProcessarTrocoClick
  end
  object gbResultado: TGroupBox
    Left = 0
    Top = 114
    Width = 423
    Height = 232
    Align = alBottom
    Caption = '[ Restultado/troco ]'
    TabOrder = 2
    object reTroco: TRichEdit
      AlignWithMargins = True
      Left = 5
      Top = 21
      Width = 413
      Height = 206
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      PlainText = True
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
      Zoom = 100
    end
  end
end
