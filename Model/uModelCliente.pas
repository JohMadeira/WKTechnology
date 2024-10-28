unit uModelCliente;

interface

uses FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, uControllerConexao,
  SysUtils;

type
  TModelCliente = class
    private
      FCodigo: integer;
      FNome: string;
      FCidade: string;
      FUF: string;

    public
      property intCodigo: Integer read FCodigo write FCodigo;
      property strNome: String read FNome write FNome;
      property strCidade: string read FCidade write FCidade;
      property strUF: string read FUF write FUF;

      function consultar: TFDQuery;
  end;

implementation

{ TModelCliente }

uses uDAOCliente;

function TModelCliente.consultar: TFDQuery;
var
  daoCliente : TDAOCliente;
begin
  daoCliente := TDAOCliente.Create;
  try
    Result := daoCliente.consultar(1);
  finally
    FreeAndNil(daoCliente);
  end;
end;

end.
