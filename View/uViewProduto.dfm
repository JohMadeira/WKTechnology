object frmProduto: TfrmProduto
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Produto'
  ClientHeight = 152
  ClientWidth = 469
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  TextHeight = 15
  object Label1: TLabel
    Left = 24
    Top = 24
    Width = 85
    Height = 15
    Caption = 'C'#243'digo Produto'
  end
  object Label2: TLabel
    Left = 176
    Top = 24
    Width = 62
    Height = 15
    Caption = 'Quantidade'
  end
  object Label3: TLabel
    Left = 328
    Top = 24
    Width = 71
    Height = 15
    Caption = 'Valor Unit'#225'rio'
  end
  object lblNomeProduto: TLabel
    Left = 24
    Top = 74
    Width = 45
    Height = 15
    Caption = 'Produto'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edtCodigoProduto: TEdit
    Left = 24
    Top = 45
    Width = 121
    Height = 23
    TabOrder = 0
    OnExit = edtCodigoProdutoExit
  end
  object edtQuantidade: TEdit
    Left = 176
    Top = 45
    Width = 121
    Height = 23
    NumbersOnly = True
    TabOrder = 1
  end
  object edtValorUnitario: TEdit
    Left = 328
    Top = 45
    Width = 121
    Height = 23
    NumbersOnly = True
    TabOrder = 2
  end
  object Confirmar: TButton
    Left = 293
    Top = 107
    Width = 75
    Height = 25
    Caption = 'Confirmar'
    ModalResult = 1
    TabOrder = 3
    OnClick = ConfirmarClick
  end
  object Cancelar: TButton
    Left = 374
    Top = 107
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    ModalResult = 2
    TabOrder = 4
    OnClick = CancelarClick
  end
end
