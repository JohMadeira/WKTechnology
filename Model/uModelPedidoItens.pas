unit uModelPedidoItens;

interface

uses FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, uControllerConexao,
  SysUtils;

type
  TModelPedidoItens = class
    private
      FNumeroPedido: integer;
      FCodigoProduto: Integer;
      FQuantidade: Integer;
      FValorUnitario: Currency;
      FValorTotal: Currency;

    public
      property intNumeroPedido: Integer read FNumeroPedido write FNumeroPedido;
      property intCodigoProduto: Integer read FCodigoProduto write FCodigoProduto;
      property intQuantidade: Integer read FQuantidade write FQuantidade;
      property curValorUnitario: Currency read FValorUnitario write FValorUnitario;
      property curValorTotal: Currency read FValorTotal write FValorTotal;

      function salvar: boolean;
      function excluir(nroPedido: integer): boolean;
      function consultar(nroPedido: integer): TFDQuery;
  end;

implementation

{ TModelPedidoItens }

uses uDAOPedidoItens;


function TModelPedidoItens.salvar: Boolean;
var
  daoPedidoItens : TDAOPedidoItens;
begin
  daoPedidoItens := TDAOPedidoItens.Create;
  try
    Result := daoPedidoItens.salvar(self);
  finally
    FreeAndNil(daoPedidoItens);
  end;
end;

function TModelPedidoItens.excluir(nroPedido: integer): Boolean;
var
  daoPedidoItens : TDAOPedidoItens;
begin
  daoPedidoItens := TDAOPedidoItens.Create;
  try
    Result := daoPedidoItens.excluir(nroPedido);
  finally
    FreeAndNil(daoPedidoItens);
  end;
end;

function TModelPedidoItens.consultar(nroPedido: integer): TFDQuery;
var
  daoPedidoItens : TDAOPedidoItens;
begin
  daoPedidoItens := TDAOPedidoItens.Create;
  try
    Result := daoPedidoItens.consultar(nroPedido);
  finally
    FreeAndNil(daoPedidoItens);
  end;
end;

end.
