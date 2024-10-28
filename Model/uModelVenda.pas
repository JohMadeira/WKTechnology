unit uModelVenda;

interface

uses FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, uControllerConexao,
  SysUtils;

type
  TModelVenda = class
    private
      FNumeroPedido: integer;
      FDataPedido: TDateTime;
      FCliente: integer;
      FValorTotal: Currency;

    public
      property intNumeroPedido: Integer read FNumeroPedido write FNumeroPedido;
      property dtDataPedido: TDateTime read FDataPedido write FDataPedido;
      property intCliente: Integer read FCliente write FCliente;
      property curValorTotal: Currency read FValorTotal write FValorTotal;

      function salvar: boolean;
      function excluir: boolean;
      function consultar: TFDQuery;
  end;

implementation

{ TModelVenda }

uses uDAOVenda;


function TModelVenda.salvar: Boolean;
var
  daoVenda : TDAOVenda;
begin
  daoVenda := TDAOVenda.Create;
  try
    Result := daoVenda.salvar(self);
  finally
    FreeAndNil(daoVenda);
  end;
end;

function TModelVenda.excluir: Boolean;
var
  daoVenda : TDAOVenda;
begin
  daoVenda := TDAOVenda.Create;
  try
    Result := daoVenda.excluir(self);
  finally
    FreeAndNil(daoVenda);
  end;
end;

function TModelVenda.consultar: TFDQuery;
var
  daoVenda : TDAOVenda;
begin
  daoVenda := TDAOVenda.Create;
  try
    Result := daoVenda.consultar(1);
  finally
    FreeAndNil(daoVenda);
  end;
end;

end.
