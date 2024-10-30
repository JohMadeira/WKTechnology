unit uViewProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Comp.Client;

type
  TfrmProduto = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtCodigoProduto: TEdit;
    edtQuantidade: TEdit;
    edtValorUnitario: TEdit;
    lblNomeProduto: TLabel;
    Confirmar: TButton;
    Cancelar: TButton;
    procedure CancelarClick(Sender: TObject);
    procedure edtCodigoProdutoExit(Sender: TObject);
    procedure ConfirmarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProduto: TfrmProduto;

implementation

{$R *.dfm}

uses uViewPedido, uControllerProduto;

procedure TfrmProduto.CancelarClick(Sender: TObject);
begin
  frmProduto.CloseModal;
end;

procedure TfrmProduto.ConfirmarClick(Sender: TObject);
begin
  frmPedidos.controllerProduto.ModelProduto.intCodigo := StrToInt(edtCodigoProduto.Text);
  frmPedidos.controllerProduto.ModelProduto.strDescricao := lblNomeProduto.Caption;
  frmPedidos.controllerProduto.ModelProduto.intQuantidade := StrToInt(edtQuantidade.Text);
  frmPedidos.controllerProduto.ModelProduto.curPreco := StrToCurr(edtValorUnitario.Text);
  edtCodigoProduto.Text := EmptyStr;
  edtQuantidade.Text := EmptyStr;
  edtValorUnitario.Text := EmptyStr;
  lblNomeProduto.Caption := 'Produto';
  ModalResult := mrOk;
end;

procedure TfrmProduto.edtCodigoProdutoExit(Sender: TObject);
var
  query: TFDQuery;
begin
  if edtCodigoProduto.Text <> EmptyStr then
    begin
      frmPedidos.controllerProduto := TControllerProduto.Create;
      try
        query := frmPedidos.controllerProduto.consultar(StrToInt(edtCodigoProduto.Text));
        if query <> nil then
          begin
            lblNomeProduto.Caption := query.Fields[1].AsString;
            edtValorUnitario.Text := CurrToStr(query.Fields[2].AsCurrency);
          end
        else
          MessageDlg('Produto não localizado', mtError, [mbOk], 0);
      finally
      end;
    end;
end;

end.
