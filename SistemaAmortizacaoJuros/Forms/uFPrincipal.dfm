object FPrincipal: TFPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Sistema de amoriza'#231#227'o de juros'
  ClientHeight = 659
  ClientWidth = 1260
  Color = clBtnFace
  UseDockManager = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  KeyPreview = True
  OldCreateOrder = False
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object pnAll: TPanel
    Left = 0
    Top = 0
    Width = 1260
    Height = 659
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object pnBottom: TPanel
      Left = 0
      Top = 613
      Width = 1260
      Height = 46
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      object btnCloseApp: TButton
        AlignWithMargins = True
        Left = 1147
        Top = 3
        Width = 110
        Height = 40
        Align = alRight
        Caption = 'Esc - Sair'
        ImageIndex = 1
        Images = FResourcesUtils.Il32
        TabOrder = 0
        OnClick = btnCloseAppClick
      end
    end
    object SplitView1: TSplitView
      Left = 0
      Top = 0
      Width = 250
      Height = 613
      OpenedWidth = 250
      Placement = svpLeft
      TabOrder = 1
      object CategoryButtons: TCategoryButtons
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 244
        Height = 30
        Cursor = crHandPoint
        Align = alTop
        BackgroundGradientColor = clHotLight
        BevelKind = bkTile
        BorderStyle = bsNone
        ButtonFlow = cbfVertical
        ButtonHeight = 40
        ButtonWidth = 30
        ButtonOptions = [boFullSize, boShowCaptions, boCaptionOnlyBorder]
        Categories = <
          item
            Caption = '  Menu'
            Color = clSkyBlue
            Collapsed = True
            GradientColor = cl3DLight
            Items = <
              item
                Action = acSimuladorFinanciamento
              end>
            TextColor = cl3DLight
          end>
        Color = clCream
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        HotButtonColor = clGradientActiveCaption
        RegularButtonColor = clSkyBlue
        SelectedButtonColor = clActiveCaption
        ShowHint = True
        TabOrder = 0
        OnCategoryCollapase = CategoryButtonsCategoryCollapase
      end
    end
  end
  object ActionList1: TActionList
    Left = 224
    Top = 8
    object acSimuladorFinanciamento: TAction
      Caption = 'Simulador de financiamento'
      OnExecute = acSimuladorFinanciamentoExecute
    end
  end
end
