object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnShow = FormShow
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 65
    Align = alTop
    TabOrder = 0
    object btnSalvar: TButton
      Left = 405
      Top = 25
      Width = 75
      Height = 25
      Caption = 'Salvar Venda'
      TabOrder = 0
      OnClick = btnSalvarClick
    end
    object edtNroPedido: TEdit
      Left = 16
      Top = 26
      Width = 119
      Height = 23
      NumbersOnly = True
      TabOrder = 1
      Text = '3'
    end
    object mskDataPedido: TMaskEdit
      Left = 141
      Top = 26
      Width = 119
      Height = 23
      EditMask = '!99/99/0000;1;_'
      MaxLength = 10
      TabOrder = 2
      Text = '01/04/2024'
    end
    object edtCiente: TEdit
      Left = 266
      Top = 26
      Width = 121
      Height = 23
      NumbersOnly = True
      TabOrder = 3
      Text = '7'
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 65
    Width = 624
    Height = 376
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    ExplicitTop = 143
    ExplicitHeight = 304
    object PageControl1: TPageControl
      Left = 1
      Top = 1
      Width = 622
      Height = 374
      ActivePage = TabSheet1
      Align = alClient
      TabOrder = 0
      ExplicitHeight = 302
      object TabSheet1: TTabSheet
        Caption = 'Itens'
        object Panel3: TPanel
          Left = 0
          Top = 312
          Width = 614
          Height = 32
          Align = alBottom
          TabOrder = 0
          ExplicitTop = 240
          object lblValorTotal: TLabel
            Left = 487
            Top = 6
            Width = 123
            Height = 20
            Alignment = taRightJustify
            Caption = 'Valor Total: 00,00'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -15
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
        object Panel4: TPanel
          Left = 0
          Top = 0
          Width = 584
          Height = 312
          Align = alClient
          Caption = 'Panel4'
          TabOrder = 1
          ExplicitLeft = 136
          ExplicitTop = 104
          ExplicitWidth = 185
          ExplicitHeight = 41
          object StringGrid1: TStringGrid
            Left = 1
            Top = 1
            Width = 582
            Height = 310
            Align = alClient
            FixedCols = 0
            TabOrder = 0
            ExplicitTop = 2
            ColWidths = (
              64
              64
              64
              64
              64)
          end
        end
        object x: TPanel
          Left = 584
          Top = 0
          Width = 30
          Height = 312
          Align = alRight
          TabOrder = 2
          ExplicitLeft = 589
          ExplicitHeight = 240
          object spdAdicionaItem: TSpeedButton
            Left = 5
            Top = 40
            Width = 23
            Height = 22
            Caption = 'S'
            StyleName = 'Windows'
          end
          object SpeedButton1: TSpeedButton
            Left = 5
            Top = 68
            Width = 23
            Height = 22
            Caption = 'D'
            StyleName = 'Windows'
          end
        end
      end
    end
  end
end
