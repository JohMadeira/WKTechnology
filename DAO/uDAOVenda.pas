unit uDAOVenda;

interface

uses FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.DApt,
  uControllerConexao, uModelVenda, SysUtils;

type
  TDAOVenda = class
    private
    public
      function consultar(iNumeroPedido: integer): TFDQuery;
      function salvar(ModelVenda: TModelVenda): boolean;
      function excluir(ModelVenda: TModelVenda): boolean;
  end;

implementation

function TDAOVenda.consultar(iNumeroPedido: integer): TFDQuery;
var
  qQuery: TFDQuery;
begin
  qQuery := TControllerConexao.getInstance().daoConexao.getQuery;
  try
    qQuery.Open('select * from vendas where numero_pedido = :codigo', [iNumeroPedido]);
  finally
    Result := qQuery;
  end;
  if qQuery.RecordCount = 0 then
    Result := nil;
end;

function TDAOVenda.salvar(ModelVenda: TModelVenda): Boolean;
var
  qQuery: TFDQuery;
begin
  try
    qQuery := TControllerConexao.getInstance().daoConexao.getQuery;
    qQuery.ExecSQL('insert into Vendas values (:numeropedido, :datapedido, :cliente, :valortotal)', [ModelVenda.intNumeroPedido, ModelVenda.dtDataPedido, ModelVenda.intCliente, ModelVenda.curValorTotal]);
    qQuery.Connection.Commit;
    Result := True;
  except
    Result := False;
    qQuery.Connection.Rollback;
  end;
end;

function TDAOVenda.excluir(ModelVenda: TModelVenda): boolean;
var
  qQuery: TFDQuery;
begin
  try
    qQuery := TControllerConexao.getInstance().daoConexao.getQuery;
    qQuery.ExecSQL('delete from Vendas_produtos where numeropedido = :numeropedido', [ModelVenda.intNumeroPedido]);
    qQuery.ExecSQL('delete from Vendas where numeropedido = :numeropedido', [ModelVenda.intNumeroPedido]);
    qQuery.Connection.Commit;
    Result := True;
  except
    Result := False;
    qQuery.Connection.Rollback;
  end;
  FreeAndNil(qQuery);
end;

end.

