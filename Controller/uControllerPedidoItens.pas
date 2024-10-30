unit uControllerPedidoItens;

interface

uses uModelPedidoItens, SysUtils, FireDAC.comp.Client;

type
  TControllerPedidoItens = class
    private
      FModelPedidoItens: TModelPedidoItens;

    public
      property ModelPedidoItens: TModelPedidoItens read FModelPedidoItens write FModelPedidoItens;
      function salvar: boolean;
      function excluir(nroPedido: integer): boolean;
      function consultar(nroPedido: integer): TFDQuery;
      constructor Create;
      destructor Destroy; override;
  end;

implementation

constructor TControllerPedidoItens.Create;
begin
  FModelPedidoItens := TModelPedidoItens.Create;
  inherited Create;
end;

destructor TControllerPedidoItens.Destroy;
begin
  FreeAndNil(FModelPedidoItens);
  inherited;
end;

function TControllerPedidoItens.salvar: boolean;
begin
  Result := FModelPedidoItens.salvar;
end;

function TControllerPedidoItens.excluir(nroPedido: integer): boolean;
begin
  Result := FModelPedidoItens.excluir(nroPedido);
end;

function TControllerPedidoItens.consultar(nroPedido: integer): TFDQuery;
begin
  Result := FModelPedidoItens.consultar(nroPedido);
end;

end.
