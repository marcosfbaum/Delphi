object SimulacaoFinanciamento: TSimulacaoFinanciamento
  Left = 0
  Top = 0
  Caption = 'SimulacaoFinanciamento'
  ClientHeight = 385
  ClientWidth = 867
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 48
    Top = 333
    Width = 39
    Height = 16
    Caption = 'Totais'
    Color = clHotLight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHotLight
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object edCapital: TLabeledEdit
    Left = 48
    Top = 56
    Width = 121
    Height = 21
    EditLabel.Width = 33
    EditLabel.Height = 13
    EditLabel.Caption = 'Capital'
    TabOrder = 0
    TextHint = 'Informe o capital'
  end
  object edTaxaJuros: TLabeledEdit
    Left = 208
    Top = 56
    Width = 121
    Height = 21
    EditLabel.Width = 51
    EditLabel.Height = 13
    EditLabel.Caption = 'Taxa juros'
    TabOrder = 1
    TextHint = 'Taxa Juros'
  end
  object edParcelas: TLabeledEdit
    Left = 368
    Top = 56
    Width = 121
    Height = 21
    EditLabel.Width = 40
    EditLabel.Height = 13
    EditLabel.Caption = 'Parcelas'
    TabOrder = 2
    TextHint = 'Parcelas'
  end
  object btnCalcular: TButton
    Left = 414
    Top = 83
    Width = 75
    Height = 25
    Caption = 'Calcular'
    TabOrder = 3
    OnClick = btnCalcularClick
  end
  object StringGrid1: TStringGrid
    Tag = 5
    Left = 48
    Top = 114
    Width = 441
    Height = 215
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    TabOrder = 4
    ColWidths = (
      50
      90
      90
      90
      90)
    RowHeights = (
      24)
  end
  object NavigatorPrototypeBindSource1: TBindNavigator
    Left = 48
    Top = 83
    Width = 348
    Height = 25
    DataSource = PrototypeBindSource1
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
    Orientation = orHorizontal
    TabOrder = 5
  end
  object edTotJuros: TEdit
    Left = 104
    Top = 330
    Width = 88
    Height = 21
    TabStop = False
    TabOrder = 6
  end
  object edTotAmortizacao: TEdit
    Left = 194
    Top = 330
    Width = 88
    Height = 21
    TabStop = False
    TabOrder = 7
  end
  object edTotPagamento: TEdit
    Left = 284
    Top = 330
    Width = 88
    Height = 21
    TabStop = False
    TabOrder = 8
  end
  object edTotSaldoDevedor: TEdit
    Left = 374
    Top = 330
    Width = 88
    Height = 21
    TabStop = False
    TabOrder = 9
  end
  object PrototypeBindSource1: TPrototypeBindSource
    AutoActivate = False
    AutoPost = False
    FieldDefs = <
      item
        Name = 'Parcela'
        Generator = 'BitmapNames'
        ReadOnly = False
      end
      item
        Name = 'ValorJuros'
        Generator = 'BitmapNames'
        ReadOnly = False
      end
      item
        Name = 'Amortizacao'
        Generator = 'BitmapNames'
        ReadOnly = False
      end
      item
        Name = 'Pagamento'
        Generator = 'BitmapNames'
        ReadOnly = False
      end
      item
        Name = 'SaldoDevedor'
        Generator = 'BitmapNames'
        ReadOnly = False
      end>
    ScopeMappings = <>
    OnCreateAdapter = PrototypeBindSource1CreateAdapter
    Left = 568
    Top = 32
  end
  object BindingList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 660
    Top = 37
    object LinkGridToDataSourcePrototypeBindSource1: TLinkGridToDataSource
      Category = 'Quick Bindings'
      DataSource = PrototypeBindSource1
      GridControl = StringGrid1
      Columns = <
        item
          MemberName = 'Parcela'
          Width = 50
        end
        item
          MemberName = 'ValorJuros'
          Header = 'Juros'
          Width = 90
        end
        item
          MemberName = 'Amortizacao'
          Width = 90
        end
        item
          MemberName = 'Pagamento'
          Width = 90
        end
        item
          MemberName = 'SaldoDevedor'
          Width = 90
        end>
    end
    object LinkControlToField1: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = PrototypeBindSource2
      FieldName = 'TotalJuros'
      Control = edTotJuros
      Track = True
    end
    object LinkControlToField2: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = PrototypeBindSource2
      FieldName = 'TotalAmortizacao'
      Control = edTotAmortizacao
      Track = True
    end
    object LinkControlToField3: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = PrototypeBindSource2
      FieldName = 'TotalPagamento'
      Control = edTotPagamento
      Track = True
    end
    object LinkControlToField4: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = PrototypeBindSource2
      FieldName = 'TotalSaldoDevedor'
      Control = edTotSaldoDevedor
      Track = True
    end
  end
  object PrototypeBindSource2: TPrototypeBindSource
    AutoActivate = False
    AutoPost = False
    FieldDefs = <
      item
        Name = 'TotalJuros'
        Generator = 'BitmapNames'
        ReadOnly = False
      end
      item
        Name = 'TotalAmortizacao'
        Generator = 'BitmapNames'
        ReadOnly = False
      end
      item
        Name = 'TotalPagamento'
        Generator = 'BitmapNames'
        ReadOnly = False
      end
      item
        Name = 'TotalSaldoDevedor'
        Generator = 'BitmapNames'
        ReadOnly = False
      end>
    ScopeMappings = <>
    OnCreateAdapter = PrototypeBindSource2CreateAdapter
    Left = 648
    Top = 168
  end
end
