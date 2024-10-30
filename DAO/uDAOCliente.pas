unit uDAOCliente;

interface

uses FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, uControllerConexao,
  uModelCliente, SysUtils;

type
  TDAOCliente = class
    private
    public
      function consultar(iCodigoCliente: integer): TFDQuery;
  end;

implementation

function TDAOCliente.consultar(iCodigoCliente: integer): TFDQuery;
var
  qQuery: TFDQuery;
begin
  qQuery := TControllerConexao.getInstance().daoConexao.getQuery;
  try
    qQuery.Open('select * from Clientes where codigo = :codigo', [iCodigoCliente]);
  finally
    Result := qQuery;
  end;
  if qQuery.RecordCount = 0 then
    Result := nil;
end;

end.

