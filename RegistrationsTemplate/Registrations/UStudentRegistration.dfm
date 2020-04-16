inherited FStudentRegistration: TFStudentRegistration
  Caption = 'Cadastro de alunos'
  ClientHeight = 256
  ClientWidth = 556
  ExplicitWidth = 562
  ExplicitHeight = 285
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnAll: TPanel
    Width = 556
    Height = 256
    ExplicitWidth = 556
    ExplicitHeight = 256
    inherited pnButtons: TPanel
      Top = 215
      Width = 556
      ExplicitTop = 215
      ExplicitWidth = 556
      inherited btnCloseForm: TButton
        Left = 443
        ExplicitLeft = 443
      end
    end
    inherited pgcRegisters: TPageControl
      Width = 556
      Height = 215
      ExplicitWidth = 556
      ExplicitHeight = 215
      inherited tsRegisters: TTabSheet
        ExplicitWidth = 548
        ExplicitHeight = 187
        inherited gRegisters: TcxGrid
          Width = 542
          Height = 124
          ExplicitWidth = 542
          ExplicitHeight = 124
          inherited gvRegisters: TcxGridTableView
            OnEditKeyPress = nil
            object gvRegisters_ID: TcxGridColumn
              Caption = 'C'#243'digo'
              Width = 45
            end
            object gvRegisters_MATRICULA: TcxGridColumn
              Caption = 'Matricula'
              Width = 60
            end
            object gvRegisters_NOME_ALUNO: TcxGridColumn
              Caption = 'Nome'
              Width = 150
            end
            object gvRegisters_TELEFONE: TcxGridColumn
              Caption = 'Telefone'
              Width = 70
            end
            object gvRegisters_CPF: TcxGridColumn
              Caption = 'CPF'
              Width = 70
            end
            object gvRegisters_ENDERECO: TcxGridColumn
              Caption = 'Endere'#231'o'
              Width = 300
            end
          end
        end
        inherited pnFilter: TPanel
          Width = 548
          ExplicitWidth = 548
          inherited btnShowAll: TButton
            TabOrder = 2
          end
          inherited btnNewData: TButton
            TabOrder = 1
          end
          inherited seFilter: TStylizedEdit
            Width = 542
          end
        end
      end
      inherited tsDetail: TTabSheet
        ExplicitWidth = 548
        ExplicitHeight = 187
        inherited pnButtonsDetail: TPanel
          Top = 153
          Width = 548
          ExplicitTop = 153
          ExplicitWidth = 548
          inherited btnCancel: TButton
            Left = 455
            ExplicitLeft = 455
          end
          inherited btnSave: TButton
            Left = 359
            ExplicitLeft = 359
          end
        end
        inherited gbData: TGroupBox
          Width = 542
          Height = 147
          ExplicitWidth = 542
          ExplicitHeight = 147
          object Label1: TLabel
            Left = 16
            Top = 63
            Width = 43
            Height = 13
            Caption = 'Matr'#237'cula'
          end
          object Label2: TLabel
            Left = 16
            Top = 103
            Width = 27
            Height = 13
            Caption = 'Nome'
          end
          object Label3: TLabel
            Left = 280
            Top = 22
            Width = 45
            Height = 13
            Caption = 'Endere'#231'o'
          end
          object Label5: TLabel
            Left = 280
            Top = 103
            Width = 19
            Height = 13
            Caption = 'CPF'
          end
          object Label4: TLabel
            Left = 280
            Top = 63
            Width = 42
            Height = 13
            Caption = 'Telefone'
          end
          object Label6: TLabel
            Left = 16
            Top = 22
            Width = 33
            Height = 13
            Caption = 'C'#243'digo'
          end
          object edID: TStylizedEdit
            Left = 16
            Top = 36
            Width = 89
            Height = 21
            TabStop = False
            BorderStyle = bsNone
            Ctl3D = True
            Enabled = False
            MaxLength = 20
            NumbersOnly = True
            ParentColor = True
            ParentCtl3D = False
            TabOrder = 0
            TextHint = '0'
            Apperance = sekStylizedEdit
            Required = False
          end
          object edMatricula: TStylizedEdit
            Left = 16
            Top = 77
            Width = 250
            Height = 19
            Ctl3D = False
            MaxLength = 20
            ParentColor = True
            ParentCtl3D = False
            TabOrder = 1
            TextHint = 'Informe a matr'#237'cula'
            Apperance = sekStandardEdit
            Required = True
          end
          object edNome: TStylizedEdit
            Left = 16
            Top = 117
            Width = 250
            Height = 21
            BorderStyle = bsNone
            Ctl3D = False
            MaxLength = 100
            ParentColor = True
            ParentCtl3D = False
            TabOrder = 2
            TextHint = 'Informe o nome'
            Apperance = sekStylizedEdit
            Required = True
          end
          object edEndereco: TStylizedEdit
            Left = 280
            Top = 36
            Width = 250
            Height = 21
            BorderStyle = bsNone
            Ctl3D = True
            MaxLength = 200
            ParentColor = True
            ParentCtl3D = False
            TabOrder = 3
            TextHint = 'Informe o endere'#231'o'
            Apperance = sekStylizedEdit
            Required = False
          end
          object edCPF: TStylizedEdit
            Left = 280
            Top = 117
            Width = 121
            Height = 21
            BorderStyle = bsNone
            Ctl3D = False
            MaxLength = 11
            NumbersOnly = True
            ParentColor = True
            ParentCtl3D = False
            TabOrder = 5
            TextHint = 'Informe o CPF'
            Apperance = sekStylizedEdit
            Required = True
          end
          object edFone: TStylizedEdit
            Left = 280
            Top = 77
            Width = 121
            Height = 21
            BorderStyle = bsNone
            Ctl3D = True
            MaxLength = 20
            ParentColor = True
            ParentCtl3D = False
            TabOrder = 4
            TextHint = 'Informe o telefone'
            Apperance = sekStylizedEdit
            Required = False
          end
        end
      end
    end
  end
end
