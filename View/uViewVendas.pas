unit uViewVendas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uControllerConexao, Vcl.StdCtrls, Vcl.Mask,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Buttons;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    btnSalvar: TButton;
    edtNroPedido: TEdit;
    mskDataPedido: TMaskEdit;
    edtCiente: TEdit;
    Panel2: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel3: TPanel;
    lblValorTotal: TLabel;
    Panel4: TPanel;
    StringGrid1: TStringGrid;
    x: TPanel;
    spdAdicionaItem: TSpeedButton;
    SpeedButton1: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses uControllerVenda;

procedure TForm1.btnSalvarClick(Sender: TObject);
var
  controllerVenda: TControllerVenda;
begin
  controllerVenda := TControllerVenda.Create;
  try
    controllerVenda.ModelVenda.intNumeroPedido := StrToInt(edtNroPedido.Text);
    controllerVenda.ModelVenda.dtDataPedido := StrToDate(mskDataPedido.Text);
    controllerVenda.ModelVenda.intCliente := StrToInt(edtCiente.Text);
    controllerVenda.ModelVenda.curValorTotal := StrToFloat(lblValorTotal.Caption);

    if controllerVenda.salvar then
      MessageDlg('Sucesso', mtInformation, [mbOk], 0)
    else
      MessageDlg('Erro', mtError, [mbOk], 0);

  finally
    FreeAndNil(controllerVenda);
  end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  TControllerConexao.getInstance().daoConexao.Create;
  TControllerConexao.getInstance().daoConexao.getConexao().Connected := True;
  if not TControllerConexao.getInstance().daoConexao.getConexao().Connected then
    MessageDlg('Erro com a conexxão com o BD. Verifique o ambiente', mtError, [mbOk], 0);
end;

end.
