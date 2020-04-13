object FSimulacaoFinanciamento: TFSimulacaoFinanciamento
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 
    'Simula'#231#227'o de financiamento pagamento '#250'nico - Calcular juros e am' +
    'ortiza'#231#227'o'
  ClientHeight = 346
  ClientWidth = 584
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnAll: TPanel
    Left = 0
    Top = 0
    Width = 584
    Height = 346
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 576
    ExplicitHeight = 326
    object pnBottom: TPanel
      Left = 0
      Top = 301
      Width = 584
      Height = 45
      Align = alBottom
      TabOrder = 3
      ExplicitTop = 281
      ExplicitWidth = 576
      object btnClose: TButton
        AlignWithMargins = True
        Left = 470
        Top = 4
        Width = 110
        Height = 37
        Align = alRight
        Caption = 'Esc - Sair'
        ImageIndex = 1
        Images = FResourcesUtils.Il32
        TabOrder = 1
        OnClick = btnCloseClick
        ExplicitLeft = 462
      end
      object btnCancel: TButton
        AlignWithMargins = True
        Left = 354
        Top = 4
        Width = 110
        Height = 37
        Align = alRight
        Caption = 'Cancelar'
        ImageIndex = 3
        Images = FResourcesUtils.Il32
        TabOrder = 0
        OnClick = btnCancelClick
        ExplicitLeft = 346
      end
    end
    object gbEntradaDados: TGroupBox
      Left = 0
      Top = 0
      Width = 584
      Height = 58
      Align = alTop
      Caption = '[ Dados do financiamento ]'
      TabOrder = 0
      ExplicitWidth = 576
      object Label1: TLabel
        Left = 291
        Top = 28
        Width = 33
        Height = 13
        Caption = 'Capital'
      end
      object Label5: TLabel
        Left = 178
        Top = 28
        Width = 40
        Height = 13
        Caption = 'Parcelas'
      end
      object Label6: TLabel
        Left = 10
        Top = 28
        Width = 88
        Height = 13
        Caption = 'Taxa de juros (%)'
      end
      object btnCalculate: TButton
        AlignWithMargins = True
        Left = 469
        Top = 18
        Width = 110
        Height = 35
        Align = alRight
        Caption = 'Calcular'
        ImageIndex = 5
        Images = FResourcesUtils.Il32
        TabOrder = 3
        OnClick = btnCalculateClick
        ExplicitLeft = 461
      end
      object edCapital: TEdit
        Left = 328
        Top = 25
        Width = 130
        Height = 21
        Alignment = taRightJustify
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        Text = '0,00'
        OnEnter = edCapitalEnter
        OnExit = edCapitalExit
        OnKeyPress = edCapitalKeyPress
      end
      object cbInstallment: TComboBox
        Left = 223
        Top = 25
        Width = 61
        Height = 21
        Style = csDropDownList
        TabOrder = 1
      end
      object edInterestRate: TEdit
        Left = 101
        Top = 25
        Width = 65
        Height = 21
        Alignment = taRightJustify
        MaxLength = 5
        TabOrder = 0
        Text = '0,00'
        OnKeyPress = edInterestRateKeyPress
      end
    end
    object dbgAmortizacao: TDBGrid
      Left = 0
      Top = 58
      Width = 584
      Height = 167
      Align = alTop
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDrawColumnCell = dbgAmortizacaoDrawColumnCell
      OnTitleClick = dbgAmortizacaoTitleClick
      Columns = <
        item
          Expanded = False
          FieldName = 'PARCELA'
          Title.Alignment = taRightJustify
          Title.Caption = 'Parcela'
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'JUROS'
          Title.Alignment = taRightJustify
          Title.Caption = 'Juros'
          Width = 235
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'SALDO DEVEDOR'
          Title.Alignment = taRightJustify
          Title.Caption = 'Saldo devedor'
          Width = 235
          Visible = True
        end>
    end
    object gbTotais: TGroupBox
      Left = 0
      Top = 225
      Width = 584
      Height = 76
      Align = alClient
      Caption = '[ Totais ]'
      TabOrder = 2
      ExplicitWidth = 576
      ExplicitHeight = 56
      object Label2: TLabel
        Left = 12
        Top = 27
        Width = 67
        Height = 13
        Caption = #218'ltima parcela'
      end
      object Label3: TLabel
        Left = 20
        Top = 49
        Width = 59
        Height = 13
        Caption = 'Amortiza'#231#227'o'
      end
      object Label4: TLabel
        Left = 306
        Top = 49
        Width = 64
        Height = 13
        Caption = 'Total a pagar'
      end
      object Label7: TLabel
        Left = 304
        Top = 28
        Width = 66
        Height = 13
        Caption = 'Total de juros'
      end
      object edLastInstallment: TEdit
        Left = 84
        Top = 24
        Width = 46
        Height = 21
        TabStop = False
        Alignment = taRightJustify
        Enabled = False
        TabOrder = 0
        Text = '0'
      end
      object edAmortization: TEdit
        Left = 84
        Top = 46
        Width = 175
        Height = 21
        TabStop = False
        Alignment = taRightJustify
        Enabled = False
        TabOrder = 1
        Text = '0'
      end
      object edTotalPay: TEdit
        Left = 373
        Top = 46
        Width = 175
        Height = 21
        TabStop = False
        Alignment = taRightJustify
        Enabled = False
        TabOrder = 2
        Text = '0'
      end
      object edTotalInterest: TEdit
        Left = 373
        Top = 24
        Width = 175
        Height = 21
        TabStop = False
        Alignment = taRightJustify
        Enabled = False
        TabOrder = 3
        Text = '0'
      end
    end
  end
end
