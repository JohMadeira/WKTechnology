program JonathanPedrosoTeste;

uses
  Vcl.Forms,
  uViewPedido in 'View\uViewPedido.pas' {frmPedidos},
  uViewProduto in 'View\uViewProduto.pas' {frmProduto},
  uControllerConexao in 'Controller\uControllerConexao.pas',
  uControllerCliente in 'Controller\uControllerCliente.pas',
  uControllerPedido in 'Controller\uControllerPedido.pas',
  uControllerProduto in 'Controller\uControllerProduto.pas',
  uControllerPedidoItens in 'Controller\uControllerPedidoItens.pas',
  uModelCliente in 'Model\uModelCliente.pas',
  uModelPedido in 'Model\uModelPedido.pas',
  uModelProduto in 'Model\uModelProduto.pas',
  uModelPedidoItens in 'Model\uModelPedidoItens.pas',
  uDAOConexao in 'DAO\uDAOConexao.pas',
  uDAOCliente in 'DAO\uDAOCliente.pas',
  uDAOPedido in 'DAO\uDAOPedido.pas',
  uDAOPedidoItens in 'DAO\uDAOPedidoItens.pas',
  uDAOProduto in 'DAO\uDAOProduto.pas',
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Iceberg Classico');
  Application.CreateForm(TfrmPedidos, frmPedidos);
  Application.CreateForm(TfrmProduto, frmProduto);
  Application.Run;
end.
