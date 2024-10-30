unit uDAOPedido;

interface

uses FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.DApt,
  uControllerConexao, uModelPedido, uModelPedidoItens, SysUtils,
  System.Generics.Collections;

type
  TDAOPedido = class
    private
    public
      function consultar(iNumeroPedido: integer): TFDQuery;
      function salvar(ModelPedido: TModelPedido): boolean;
      function excluir(nroPedido: Integer): boolean;
  end;

implementation

uses uDAOPedidoItens;

function TDAOPedido.consultar(iNumeroPedido: integer): TFDQuery;
var
  qQuery: TFDQuery;
begin
  qQuery := TControllerConexao.getInstance().daoConexao.getQuery;
  try
    qQuery.Open('select * from Pedidos where numero_pedido = :codigo', [iNumeroPedido]);
  finally
    Result := qQuery;
  end;
  if qQuery.RecordCount = 0 then
    Result := nil;
end;

function TDAOPedido.salvar(ModelPedido: TModelPedido): Boolean;
var
  qQuery: TFDQuery;
  aux: integer;
  daoPedidoItens: TDAOPedidoItens;
begin
  try
    qQuery := TControllerConexao.getInstance().daoConexao.getQuery;
    qQuery.ExecSQL('insert into Pedidos values (:numeropedido, :datapedido, :cliente, :valortotal)', [ModelPedido.intNumeroPedido, ModelPedido.dtDataPedido, ModelPedido.intCliente, ModelPedido.curValorTotal]);

    for aux := 0 to ModelPedido.itens.Count -1 do
      if not daoPedidoItens.salvar(ModelPedido.itens.Items[aux] as TModelPedidoItens) then
        begin
          Result := False;
          TControllerConexao.getInstance().daoConexao.getConexao.Rollback;
          Exit;
        end;

    TControllerConexao.getInstance().daoConexao.getConexao.Commit;
    Result := True;
  except
    Result := False;
    TControllerConexao.getInstance().daoConexao.getConexao.Rollback;
  end;
end;

function TDAOPedido.excluir(nroPedido: Integer): boolean;
var
  qQuery: TFDQuery;
begin
  try
    qQuery := TControllerConexao.getInstance().daoConexao.getQuery;
    qQuery.ExecSQL('delete from Pedidos_produtos where numero_pedido = :numeropedido', [nroPedido]);
    qQuery.ExecSQL('delete from Pedidos where numero_pedido = :numeropedido', [nroPedido]);
    TControllerConexao.getInstance().daoConexao.getConexao.Commit;
    Result := True;
  except
    Result := False;
    TControllerConexao.getInstance().daoConexao.getConexao.Rollback;
  end;
  FreeAndNil(qQuery);
end;

end.

