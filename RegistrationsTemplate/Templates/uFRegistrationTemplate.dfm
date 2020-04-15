object FRegistrationTemplate: TFRegistrationTemplate
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Registration template'
  ClientHeight = 332
  ClientWidth = 537
  Color = clGradientInactiveCaption
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnAll: TPanel
    Left = 0
    Top = 0
    Width = 537
    Height = 332
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object pnButtons: TPanel
      Left = 0
      Top = 291
      Width = 537
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      Color = clGradientInactiveCaption
      ParentBackground = False
      TabOrder = 0
      object btnCloseForm: TButton
        AlignWithMargins = True
        Left = 424
        Top = 3
        Width = 110
        Height = 35
        Align = alRight
        Caption = 'Esc - Sair'
        TabOrder = 0
        OnClick = btnCloseFormClick
      end
    end
    object pgcRegisters: TPageControl
      Left = 0
      Top = 0
      Width = 537
      Height = 291
      ActivePage = tsRegisters
      Align = alClient
      MultiLine = True
      TabOrder = 1
      object tsRegisters: TTabSheet
        Caption = 'Registros'
        object gRegisters: TcxGrid
          AlignWithMargins = True
          Left = 3
          Top = 60
          Width = 523
          Height = 200
          Align = alClient
          TabOrder = 1
          object gvRegisters: TcxGridTableView
            OnKeyDown = gvRegistersKeyDown
            Navigator.Buttons.CustomButtons = <>
            OnEditKeyPress = gvRegistersEditKeyPress
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.CellSelect = False
          end
          object gRegistersLevel1: TcxGridLevel
            GridView = gvRegisters
          end
        end
        object pnFilter: TPanel
          Left = 0
          Top = 0
          Width = 529
          Height = 57
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Align = alTop
          BevelOuter = bvNone
          Color = clGradientInactiveCaption
          ParentBackground = False
          TabOrder = 0
          object sbFilter: TSearchBox
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 523
            Height = 24
            Align = alTop
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            TextHint = 'Busque pela descri'#231#227'o'
            OnChange = sbFilterChange
            OnKeyDown = sbFilterKeyDown
          end
          object btnShowAll: TButton
            AlignWithMargins = True
            Left = 97
            Top = 28
            Width = 90
            Height = 28
            Caption = 'Exibir todos'
            TabOrder = 1
            OnClick = btnShowAllClick
          end
          object btnNewData: TButton
            AlignWithMargins = True
            Left = 2
            Top = 28
            Width = 90
            Height = 28
            Caption = 'Novo'
            TabOrder = 2
            OnClick = btnNewDataClick
          end
        end
      end
      object tsDetail: TTabSheet
        Caption = 'Detalhes'
        ImageIndex = 1
        object pnButtonsDetail: TPanel
          Left = 0
          Top = 229
          Width = 529
          Height = 34
          Align = alBottom
          BevelOuter = bvNone
          Color = clGradientInactiveCaption
          ParentBackground = False
          TabOrder = 1
          object btnCancel: TButton
            AlignWithMargins = True
            Left = 436
            Top = 3
            Width = 90
            Height = 28
            Align = alRight
            Caption = 'Cancelar'
            TabOrder = 1
            OnClick = btnCancelClick
          end
          object btnSave: TButton
            AlignWithMargins = True
            Left = 340
            Top = 3
            Width = 90
            Height = 28
            Align = alRight
            Caption = 'Gravar'
            TabOrder = 0
            OnClick = btnSaveClick
          end
        end
        object gbData: TGroupBox
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 523
          Height = 223
          Align = alClient
          Caption = '[ Dados ]'
          Color = clGradientInactiveCaption
          ParentBackground = False
          ParentColor = False
          TabOrder = 0
        end
      end
    end
  end
end
