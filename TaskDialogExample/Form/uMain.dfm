object FTaskDialogExample: TFTaskDialogExample
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Task dialog example'
  ClientHeight = 182
  ClientWidth = 333
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object btnIncrementProc: TButton
    AlignWithMargins = True
    Left = 5
    Top = 5
    Width = 323
    Height = 25
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alTop
    Caption = 'Incrementando conforme o processo'
    TabOrder = 0
    OnClick = btnIncrementProcClick
  end
  object btnUndeterminedProgress: TButton
    AlignWithMargins = True
    Left = 5
    Top = 40
    Width = 323
    Height = 25
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alTop
    Caption = 'Progresso indeterminado'
    TabOrder = 1
    OnClick = btnUndeterminedProgressClick
  end
  object btnUserCanAbort: TButton
    AlignWithMargins = True
    Left = 5
    Top = 75
    Width = 323
    Height = 25
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alTop
    Caption = 'Usu'#225'rio pode abortar o processo'
    TabOrder = 2
    OnClick = btnUserCanAbortClick
  end
  object BtnWithException: TButton
    AlignWithMargins = True
    Left = 5
    Top = 110
    Width = 323
    Height = 25
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alTop
    Caption = 'Com exce'#231#227'o no procedimento'
    TabOrder = 3
    OnClick = BtnWithExceptionClick
  end
  object btnProcessoLento: TButton
    AlignWithMargins = True
    Left = 5
    Top = 145
    Width = 323
    Height = 25
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alTop
    Caption = 'Processo lento'
    TabOrder = 4
    OnClick = btnProcessoLentoClick
  end
end
