inherited FStudentRegistration: TFStudentRegistration
  Caption = 'Cadastro de alunos'
  ClientWidth = 556
  ExplicitWidth = 562
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnAll: TPanel
    Width = 556
    ExplicitWidth = 556
    inherited pnButtons: TPanel
      Width = 556
      ExplicitWidth = 556
      inherited btnCloseForm: TButton
        Left = 443
        ExplicitLeft = 443
      end
    end
    inherited pgcRegisters: TPageControl
      Width = 556
      ActivePage = tsDetail
      ExplicitWidth = 556
      inherited tsRegisters: TTabSheet
        ExplicitWidth = 548
        inherited gRegisters: TcxGrid
          Width = 542
          ExplicitWidth = 542
          inherited gvRegisters: TcxGridTableView
            OnEditKeyPress = nil
            object gvRegistersID: TcxGridColumn
            end
            object gvRegistersMATRICULA: TcxGridColumn
              Caption = 'Matricula'
              Width = 55
            end
            object gvRegistersNOME_ALUNO: TcxGridColumn
              Caption = 'Nome'
              Width = 100
            end
            object gvRegistersENDERECO: TcxGridColumn
              Caption = 'Endere'#231'o'
              Width = 120
            end
            object gvRegistersTELEFONE: TcxGridColumn
              Caption = 'Telefone'
              Width = 70
            end
            object gvRegistersCPF: TcxGridColumn
              Caption = 'CPF'
              Width = 70
            end
          end
        end
        inherited pnFilter: TPanel
          Width = 548
          ExplicitWidth = 548
          inherited sbFilter: TSearchBox
            Width = 542
            ExplicitWidth = 542
          end
          inherited btnShowAll: TButton
            TabOrder = 2
          end
          inherited btnNewData: TButton
            TabOrder = 1
            OnClick = btnNewDataClick
          end
        end
      end
      inherited tsDetail: TTabSheet
        ExplicitWidth = 548
        inherited pnButtonsDetail: TPanel
          Width = 548
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
          ExplicitWidth = 542
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
          object edMatricula: TEdit
            Left = 16
            Top = 77
            Width = 250
            Height = 21
            MaxLength = 20
            TabOrder = 1
            TextHint = 'Informe a matr'#237'cula'
          end
          object edNome: TEdit
            Left = 16
            Top = 117
            Width = 250
            Height = 21
            MaxLength = 100
            TabOrder = 2
            TextHint = 'Informe o nome'
          end
          object edEndereco: TEdit
            Left = 280
            Top = 36
            Width = 250
            Height = 21
            MaxLength = 200
            TabOrder = 3
            TextHint = 'Informe o endere'#231'o'
          end
          object edCPF: TEdit
            Left = 280
            Top = 117
            Width = 121
            Height = 21
            MaxLength = 11
            NumbersOnly = True
            TabOrder = 5
            TextHint = 'Informe o CPF'
          end
          object edFone: TEdit
            Left = 280
            Top = 77
            Width = 121
            Height = 21
            MaxLength = 20
            TabOrder = 4
            TextHint = 'Informe o telefone'
          end
          object edID: TEdit
            Left = 16
            Top = 36
            Width = 89
            Height = 21
            TabStop = False
            Enabled = False
            MaxLength = 20
            NumbersOnly = True
            TabOrder = 0
            TextHint = '0'
          end
        end
      end
    end
  end
end
