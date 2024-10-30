unit uDAOPedidoItens;

interface

uses FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.DApt,
  uControllerConexao, uModelPedidoItens, SysUtils;

type
  TDAOPedidoItens = class
    private
    public
      function consultar(iNumeroPedido: integer): TFDQuery;
      function salvar(ModelPedidoItens: TModelPedidoItens): boolean;
      function excluir(nroPedido: Integer): boolean;
  end;

implementation

function TDAOPedidoItens.consultar(iNumeroPedido: integer): TFDQuery;
var
  qQuery: TFDQuery;
begin
  qQuery := TControllerConexao.getInstance().daoConexao.getQuery;
  try
    qQuery.Open('select vp.codigo_produto Codigo, p.descricao Descricao, vp.quantidade Quantidade, vp.valor_unitario "Valor Unitario", vp.valor_total "Valor Total"' +
                ' from Pedidos_produtos vp ' +
                ' join produtos p on vp.CODIGO_PRODUTO = p.CODIGO ' +
                ' where numero_pedido = :codigo', [iNumeroPedido]);
  finally
    Result := qQuery;
  end;
  if qQuery.RecordCount = 0 then
    Result := nil;
end;

function TDAOPedidoItens.salvar(ModelPedidoItens: TModelPedidoItens): Boolean;
var
  qQuery: TFDQuery;
begin
  try
    qQuery := TControllerConexao.getInstance().daoConexao.getQuery;
    qQuery.ExecSQL('insert into Pedidos_produtos (numero_pedido, codigo_produto, quantidade, valor_unitario, valor_total) ' +
                   ' values (:pedido, :produto, :quantidade, :vlrUnitario, :vlrTotal)',
                   [ModelPedidoItens.intNumeroPedido, ModelPedidoItens.intCodigoProduto, ModelPedidoItens.intQuantidade,
                    ModelPedidoItens.curValorUnitario, ModelPedidoItens.curValorTotal]);
    Result := True;
  except
    Result := False;
  end;
end;

function TDAOPedidoItens.excluir(nroPedido: Integer): boolean;
var
  qQuery: TFDQuery;
begin
  try
    qQuery := TControllerConexao.getInstance().daoConexao.getQuery;
    qQuery.ExecSQL('delete from Pedidos_produtos where numero_pedido = :numeropedido', [nroPedido]);
    TControllerConexao.getInstance().daoConexao.getConexao.Commit;
    Result := True;
  except
    Result := False;
    TControllerConexao.getInstance().daoConexao.getConexao.Rollback;
  end;
  FreeAndNil(qQuery);
end;

end.

