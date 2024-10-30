unit uControllerCliente;

interface

uses uModelCliente, SysUtils, FireDAC.comp.Client;

type
  TControllerCliente = class
    private
      FModelCliente: TModelCliente;

    public
      property ModelCliente: TModelCliente read FModelCliente write FModelCliente;
      function consultar(codCliente: Integer): TFDQuery;
      constructor Create;
      destructor Destroy; override;
  end;

implementation

constructor TControllerCliente.Create;
begin
  FModelCliente := TModelCliente.Create;
  inherited Create;
end;

destructor TControllerCliente.Destroy;
begin
  FreeAndNil(FModelCliente);
  inherited;
end;

function TControllerCliente.consultar(codCliente: Integer): TFDQuery;
begin
  Result := FModelCliente.consultar(codCliente);
end;

end.
