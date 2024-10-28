unit uControllerConexao;

interface

uses SysUtils, uDAOConexao;

type
  TControllerConexao = class
    private
      FConexao: TDAOConexao;
      constructor Create;
      destructor Destroy; override;
    public
      property daoConexao : TDAOConexao read FConexao write FConexao;
      class function getInstance : TControllerConexao;

   end;

implementation

var
  Conexao: TControllerConexao;

{ TControllerConexao }

constructor TControllerConexao.Create;
begin
  inherited Create;
  FConexao := TDAOConexao.Create;
end;

destructor TControllerConexao.Destroy;
begin
  inherited;
  FreeAndNil(FConexao);
end;

class function TControllerConexao.getInstance: TControllerConexao;
begin
  if Conexao = nil then
    Conexao := TControllerConexao.Create;

  Result := Conexao;
end;

initialization
  Conexao := nil;

finalization
  if Conexao <> nil then
    Conexao.Free;

end.
