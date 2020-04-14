object FRegistrationTemplate: TFRegistrationTemplate
  Left = 0
  Top = 0
  Caption = 'Registration template'
  ClientHeight = 242
  ClientWidth = 527
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object pnAll: TPanel
    Left = 0
    Top = 0
    Width = 527
    Height = 242
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object pnFilter: TPanel
      Left = 0
      Top = 0
      Width = 527
      Height = 27
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object SearchBox1: TSearchBox
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 521
        Height = 21
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TextHint = 'Busque pela descri'#231#227'o'
        ExplicitHeight = 24
      end
    end
    object cxGrid1: TcxGrid
      Left = 0
      Top = 27
      Width = 527
      Height = 174
      Align = alClient
      TabOrder = 1
      object cxGrid1DBTableView1: TcxGridDBTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = cxGrid1DBTableView1
      end
    end
    object pnButtons: TPanel
      Left = 0
      Top = 201
      Width = 527
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      object btnCloseForm: TButton
        AlignWithMargins = True
        Left = 414
        Top = 3
        Width = 110
        Height = 35
        Align = alRight
        Caption = 'Esc - Sair'
        TabOrder = 0
        OnClick = btnCloseFormClick
      end
    end
  end
end
