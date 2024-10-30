unit uModelPedido;

interface

uses FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, uControllerConexao,
  SysUtils, System.Generics.Collections, uModelPedidoItens;

type
  TModelPedido = class
    private
      FNumeroPedido: integer;
      FDataPedido: TDateTime;
      FCliente: integer;
      FValorTotal: Currency;
      FPedidoItens: TObjectList<TModelPedidoItens>;

    public
      property intNumeroPedido: Integer read FNumeroPedido write FNumeroPedido;
      property dtDataPedido: TDateTime read FDataPedido write FDataPedido;
      property intCliente: Integer read FCliente write FCliente;
      property curValorTotal: Currency read FValorTotal write FValorTotal;
      property itens: TObjectList<TModelPedidoItens> read FPedidoItens write FPedidoItens;

      constructor Create;
      destructor Destroy; override;

      function salvar: boolean;
      function excluir(nroPedido: Integer): boolean;
      function consultar(nroPedido: Integer): TFDQuery;
  end;

implementation

{ TModelPedido }

uses uDAOPedido;

constructor TModelPedido.Create;
begin
  inherited;
  itens := TObjectList<TModelPedidoItens>.Create;
end;

destructor TModelPedido.Destroy;
begin
  inherited;
  FreeAndNil(itens);
end;

function TModelPedido.salvar: Boolean;
var
  daoPedido : TDAOPedido;
begin
  daoPedido := TDAOPedido.Create;
  try
    Result := daoPedido.salvar(self);
  finally
    FreeAndNil(daoPedido);
  end;
end;

function TModelPedido.excluir(nroPedido: Integer): Boolean;
var
  daoPedido : TDAOPedido;
begin
  daoPedido := TDAOPedido.Create;
  try
    Result := daoPedido.excluir(nroPedido);
  finally
    FreeAndNil(daoPedido);
  end;
end;

function TModelPedido.consultar(nroPedido: Integer): TFDQuery;
var
  daoPedido : TDAOPedido;
begin
  daoPedido := TDAOPedido.Create;
  try
    Result := daoPedido.consultar(nroPedido);
  finally
    FreeAndNil(daoPedido);
  end;
end;

end.
