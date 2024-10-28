unit uDAOProduto;

interface

uses FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, uControllerConexao,
  uModelProduto, SysUtils;

type
  TDAOProduto = class
    private
    public
      function consultar(iCodigoProduto: integer): TFDQuery;
  end;

implementation

function TDAOProduto.consultar(iCodigoProduto: integer): TFDQuery;
var
  qQuery: TFDQuery;
begin
  qQuery := TControllerConexao.getInstance().daoConexao.getQuery;
  try
    qQuery.Open('select * from produto where codigo = :codigo', [iCodigoProduto]);
  finally
    Result := qQuery;
  end;
  if qQuery.RecordCount = 0 then
    Result := nil;
end;

end.

