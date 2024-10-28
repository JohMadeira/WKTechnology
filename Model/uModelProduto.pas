unit uModelProduto;

interface

uses FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, uControllerConexao,
  SysUtils;

type
  TModelProduto = class
    private
      FCodigo: integer;
      FDescricao: string;
      FPreco: currency;

    public
      property intCodigo: Integer read FCodigo write FCodigo;
      property strDescricao: String read FDescricao write FDescricao;
      property curPreco: currency read FPreco write FPreco;

      function consultar: TFDQuery;
  end;

implementation

{ TModelProduto }

uses uDAOProduto;

function TModelProduto.consultar: TFDQuery;
var
  daoProduto : TDAOProduto;
begin
  daoProduto := TDAOProduto.Create;
  try
    Result := daoProduto.consultar(1);
  finally
    FreeAndNil(daoProduto);
  end;
end;

end.
