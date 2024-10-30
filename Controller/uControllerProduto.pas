unit uControllerProduto;

interface

uses uModelProduto, SysUtils, FireDAC.comp.Client;

type
  TControllerProduto = class
    private
      FModelProduto: TModelProduto;

    public
      property ModelProduto: TModelProduto read FModelProduto write FModelProduto;
      function consultar(produto: integer): TFDQuery;
      constructor Create;
      destructor Destroy; override;
  end;

implementation

constructor TControllerProduto.Create;
begin
  FModelProduto := TModelProduto.Create;
  inherited Create;
end;

destructor TControllerProduto.Destroy;
begin
  FreeAndNil(FModelProduto);
  inherited;
end;

function TControllerProduto.consultar(produto: integer): TFDQuery;
begin
  Result := FModelProduto.consultar(produto);
end;

end.
