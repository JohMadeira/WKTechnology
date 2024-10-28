unit uControllerVenda;

interface

uses uModelVenda, SysUtils, FireDAC.comp.Client;

type
  TControllerVenda = class
    private
      FModelVenda: TModelVenda;

    public
      property ModelVenda: TModelVenda read FModelVenda write FModelVenda;
      function salvar: boolean;
      function excluir: boolean;
      function consultar: TFDQuery;
      constructor Create;
      destructor Destroy; override;
  end;

implementation

constructor TControllerVenda.Create;
begin
  FModelVenda := TModelVenda.Create;
  inherited Create;
end;

destructor TControllerVenda.Destroy;
begin
  FreeAndNil(FModelVenda);
  inherited;
end;

function TControllerVenda.salvar: boolean;
begin
  Result := FModelVenda.salvar;
end;

function TControllerVenda.excluir: boolean;
begin
  Result := FModelVenda.excluir;
end;

function TControllerVenda.consultar: TFDQuery;
begin
  Result := FModelVenda.consultar;
end;

end.
