unit uDAOConexao;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Phys.MySQL, System.SysUtils, IniFiles, Forms;

type
  TDAOConexao = class
      private
        FDriver: TFDPhysMySQLDriverLink;
        FConexao: TFDConnection;
      public
        function getConexao: TFDConnection;
        function getQuery: TFDQuery;
        constructor Create;
        destructor Destroy; override;
  end;

implementation

{ TDAOConexao }

constructor TDAOConexao.Create;
var
  iniFile: TIniFile;
begin
  inherited Create;

  iniFile := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Config.ini');

  FDriver := TFDPhysMySQLDriverLink.Create(nil);
  FDriver.DriverID := 'MySQL';
  FDriver.VendorLib := iniFile.ReadString('Banco', 'VendorLib', '');

  FConexao := TFDConnection.Create(nil);

  FConexao.Params.Values['DriverID'] := 'MySQL';
  FConexao.Params.Values['Server'] := iniFile.ReadString('Banco', 'Server', '');
  FConexao.Params.Values['Database'] := iniFile.ReadString('Banco','Database', '');
  FConexao.Params.Values['User_Name'] := iniFile.ReadString('Banco','Username', '');
  FConexao.Params.Values['Password'] := iniFile.ReadString('Banco','Password', '');
  FConexao.Params.Values['Port'] := iniFile.ReadString('Banco','Port', '');
  FConexao.LoginPrompt := False;
  FConexao.TxOptions.AutoCommit := False;

  iniFile.Free;
end;

destructor TDAOConexao.Destroy;
begin
  inherited;

  FreeAndNil(FConexao);
end;

function TDAOConexao.getConexao: TFDCOnnection;
begin
  result := FConexao;
end;

function TDAOConexao.getQuery: TFDQuery;
var
  qQuery: TFDQuery;
begin
  qQuery := TFDQuery.Create(nil);
  qQuery.Connection := FConexao;

  Result := qQuery;
end;


end.
