unit uControllerPedido;

interface

uses uModelPedido, uModelPedidoItens, SysUtils, FireDAC.comp.Client, System.Generics.Collections;

type
  TControllerPedido = class
    private
      FModelPedido: TModelPedido;

    public
      property ModelPedido: TModelPedido read FModelPedido write FModelPedido;
      function salvar: boolean;
      function excluir(nroPedido: Integer): boolean;
      function consultar(nroPedido: Integer): TFDQuery;
      constructor Create;
      destructor Destroy; override;
  end;

implementation

constructor TControllerPedido.Create;
begin
  FModelPedido := TModelPedido.Create;
  inherited Create;
end;

destructor TControllerPedido.Destroy;
begin
  FreeAndNil(FModelPedido);
  inherited;
end;

function TControllerPedido.salvar: boolean;
begin
  Result := FModelPedido.salvar;
end;

function TControllerPedido.excluir(nroPedido: Integer): boolean;
begin
  Result := FModelPedido.excluir(nroPedido);
end;

function TControllerPedido.consultar(nroPedido: Integer): TFDQuery;
begin
  Result := FModelPedido.consultar(nroPedido);
end;

end.
