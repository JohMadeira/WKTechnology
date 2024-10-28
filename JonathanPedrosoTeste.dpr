program JonathanPedrosoTeste;

uses
  Vcl.Forms,
  uViewVendas in 'View\uViewVendas.pas' {Form1},
  uControllerConexao in 'Controller\uControllerConexao.pas',
  uDAOConexao in 'DAO\uDAOConexao.pas',
  uModelVenda in 'Model\uModelVenda.pas',
  uDAOVenda in 'DAO\uDAOVenda.pas',
  uControllerVenda in 'Controller\uControllerVenda.pas',
  uModelCliente in 'Model\uModelCliente.pas',
  uDAOCliente in 'DAO\uDAOCliente.pas',
  uControllerCliente in 'Controller\uControllerCliente.pas',
  uControllerProduto in 'Controller\uControllerProduto.pas',
  uDAOProduto in 'DAO\uDAOProduto.pas',
  uModelProduto in 'Model\uModelProduto.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
