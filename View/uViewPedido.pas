unit uViewPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uControllerConexao, Vcl.StdCtrls, Vcl.Mask,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Buttons, Vcl.DBGrids, uControllerProduto,
  System.ImageList, Vcl.ImgList;

type
  TfrmPedidos = class(TForm)
    Panel1: TPanel;
    btnSalvar: TButton;
    edtNroPedido: TEdit;
    edtCiente: TEdit;
    Panel2: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel3: TPanel;
    lblValorTotal: TLabel;
    Panel4: TPanel;
    x: TPanel;
    spdAdicionaItem: TSpeedButton;
    spdDeletaItem: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    dbgItens: TDBGrid;
    ImageList1: TImageList;
    btnConsultar: TButton;
    pnlConsulta: TPanel;
    Label4: TLabel;
    edtNroPedidoConsulta: TEdit;
    spbConsultaPedido: TSpeedButton;
    lblCliente: TLabel;
    btnCancelarPedido: TButton;
    edtData: TDateTimePicker;
    procedure FormShow(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure spdAdicionaItemClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgItensKeyPress(Sender: TObject; var Key: Char);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure spdDeletaItemClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure spbConsultaPedidoClick(Sender: TObject);
    procedure edtCienteExit(Sender: TObject);
    procedure edtNroPedidoExit(Sender: TObject);
    procedure btnCancelarPedidoClick(Sender: TObject);
  private
    { Private declarations }
    procedure LimparCampos;
    procedure TotalizaGrid;
    procedure CopiaDataSet(query: TFDQuery);
    procedure BuscaCliente;
    procedure ConsultaPedido;
    procedure ExcluiPedido;
  public
    { Public declarations }
    controllerProduto: TControllerProduto;
  end;

type
  TEnumerador = (enumInclusao, enumAlteracao, enumExclusao);

var
  frmPedidos: TfrmPedidos;
  memTableProdutos: TFDMemTable;
  dsDataSource: TDataSource;
  curValorTotal: Currency;
  operacao: TEnumerador;

implementation

{$R *.dfm}

uses uControllerPedido, uControllerPedidoItens, uModelPedidoItens, uViewProduto,
  uControllerCliente;

procedure TfrmPedidos.btnCancelarPedidoClick(Sender: TObject);
begin
  pnlConsulta.Visible := True;
  pnlConsulta.Top := 77;
  operacao := enumExclusao;
end;

procedure TfrmPedidos.btnConsultarClick(Sender: TObject);
begin
  pnlConsulta.Visible := True;
  pnlConsulta.Top := 46;
  operacao := enumAlteracao;
end;

procedure TfrmPedidos.btnSalvarClick(Sender: TObject);
var
  controllerPedido: TControllerPedido;
  modelPedidoItens: TModelPedidoItens;
begin
  controllerPedido := TControllerPedido.Create;
  try
    controllerPedido.ModelPedido.intNumeroPedido := StrToInt(edtNroPedido.Text);
    controllerPedido.ModelPedido.dtDataPedido := edtData.Date;
    controllerPedido.ModelPedido.intCliente := StrToInt(edtCiente.Text);
    controllerPedido.ModelPedido.curValorTotal := curValorTotal;

    memTableProdutos.First;

    with memTableProdutos do
      while not Eof do
        begin
          modelPedidoItens :=  TModelPedidoItens.Create;
          modelPedidoItens.intNumeroPedido := controllerPedido.ModelPedido.intNumeroPedido;
          modelPedidoItens.intCodigoProduto := Fields[0].AsInteger;
          modelPedidoItens.intQuantidade := Fields[2].AsInteger;
          modelPedidoItens.curValorUnitario := Fields[3].AsCurrency;
          modelPedidoItens.curValorTotal := Fields[4].AsCurrency;
          controllerPedido.ModelPedido.itens.Add(modelPedidoItens);
          Next;
        end;

    if controllerPedido.salvar() then
      MessageDlg('Pedido salvo com sucesso!', mtInformation, [mbOk], 0)
    else
      MessageDlg('Erro ao salvar pedido.', mtError, [mbOk], 0);

  finally
    FreeAndNil(controllerPedido);
  end;
  LimparCampos;
end;

procedure TfrmPedidos.dbgItensKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_DELETE then
    spdDeletaItem.Click;
end;

procedure TfrmPedidos.dbgItensKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    begin
      btnSalvar.ImageIndex := 1;
      dbgItens.DataSource.Edit;
      dbgItens.Fields[0].ReadOnly := True;
      dbgItens.Fields[1].ReadOnly := True;
      dbgItens.Fields[4].ReadOnly := True;
    end;
end;

procedure TfrmPedidos.edtCienteExit(Sender: TObject);
begin
  BuscaCliente;
end;

procedure TfrmPedidos.edtNroPedidoExit(Sender: TObject);
begin
  btnConsultar.Visible := edtNroPedido.Text = '';
  btnCancelarPedido.Visible := edtNroPedido.Text = '';
  pnlConsulta.Visible := False;
end;

procedure TfrmPedidos.FormCreate(Sender: TObject);
begin
  memTableProdutos := TFDMemTable.Create(nil);
  dsDataSource := TDataSource.Create(nil);
  memTableProdutos.FieldDefs.Add('Codigo', ftInteger);
  memTableProdutos.FieldDefs.Add('Descricao', ftString, 100);
  memTableProdutos.FieldDefs.Add('Quantidade', ftInteger);
  memTableProdutos.FieldDefs.Add('Valor Unitario', ftCurrency);
  memTableProdutos.FieldDefs.Add('Valor Total', ftCurrency);
  memTableProdutos.CreateDataSet;
  dsDataSource.dataset := memTableProdutos;
  dbgItens.DataSource := dsDataSource;
  operacao := enumInclusao;
end;

procedure TfrmPedidos.FormShow(Sender: TObject);
begin
  LimparCampos;
  TControllerConexao.getInstance().daoConexao.Create;
  TControllerConexao.getInstance().daoConexao.getConexao().Connected := True;
  if not TControllerConexao.getInstance().daoConexao.getConexao().Connected then
    MessageDlg('Erro com a conexxão com o BD. Verifique o ambiente', mtError, [mbOk], 0);
end;

procedure TfrmPedidos.LimparCampos;
begin
  edtNroPedido.Text := EmptyStr;
  edtData.DateTime := StrToDate('01/01/1980');
  edtCiente.Text := EmptyStr;
  lblValorTotal.Caption := 'Valor Total: R$ 0,00';
  memTableProdutos.EmptyDataSet;
  btnConsultar.Visible := True;
  btnCancelarPedido.Visible := True;
  lblCliente.Caption := EmptyStr;
  curValorTotal := 0;
end;

procedure TfrmPedidos.spbConsultaPedidoClick(Sender: TObject);
var
  controllerPedido: TControllerPedido;
  controllerPedidoItens: TControllerPedidoItens;
  queryAux: TFDQuery;
  aux: integer;
begin
  pnlConsulta.Visible := False;
  if edtNroPedidoConsulta.Text <> EmptyStr then
    begin
      case operacao of
        enumAlteracao: ConsultaPedido;
        enumExclusao: ExcluiPedido;
      end;
    end;
  edtNroPedidoConsulta.Text := EmptyStr;
end;

procedure TfrmPedidos.spdAdicionaItemClick(Sender: TObject);
begin
  if memTableProdutos.State = dsEdit then
    begin
      dbgItens.Fields[4].ReadOnly := False;
      curValorTotal := curValorTotal - memTableProdutos.Fields[4].AsCurrency;
      memTableProdutos.Fields[4].AsCurrency := memTableProdutos.Fields[2].AsInteger * memTableProdutos.Fields[3].AsCurrency;
      curValorTotal := curValorTotal + memTableProdutos.Fields[4].AsCurrency;
      memTableProdutos.Post;
    end
  else
  begin
    if frmProduto.ShowModal = mrOk then
      begin
        dbgItens.Fields[0].ReadOnly := False;
        dbgItens.Fields[1].ReadOnly := False;
        dbgItens.Fields[4].ReadOnly := False;
        memTableProdutos.Append;
        memTableProdutos.Fields[0].AsInteger := controllerProduto.ModelProduto.intCodigo;
        memTableProdutos.Fields[1].AsString := controllerProduto.ModelProduto.strDescricao;
        memTableProdutos.Fields[2].AsInteger := controllerProduto.ModelProduto.intQuantidade;
        memTableProdutos.Fields[3].AsCurrency := controllerProduto.ModelProduto.curPreco;
        memTableProdutos.Fields[4].AsCurrency := controllerProduto.ModelProduto.intQuantidade * controllerProduto.ModelProduto.curPreco;
        memTableProdutos.Post;
        curValorTotal := curValorTotal + memTableProdutos.Fields[4].AsCurrency;
      end;
    FreeAndNil(controllerProduto);
  end;
  TotalizaGrid;
end;

procedure TfrmPedidos.CopiaDataSet(query: TFDQuery);
var
  aux: Integer;
begin
  dbgItens.Fields[0].ReadOnly := False;
  dbgItens.Fields[1].ReadOnly := False;
  dbgItens.Fields[4].ReadOnly := False;
  memTableProdutos.EmptyDataSet;
  while not query.Eof do
  begin
    memTableProdutos.Append;
    for aux := 0 to query.FieldCount -1 do
      begin
        if query.Fields[aux].DataType = ftBCD then
          memTableProdutos.Fields[aux].AsCurrency := query.Fields[aux].AsCurrency
        else
          memTableProdutos.Fields[aux].Value := query.Fields[aux].Value;
      end;
    memTableProdutos.Post;
    query.Next;
  end;
end;

procedure TfrmPedidos.spdDeletaItemClick(Sender: TObject);
begin
  if MessageDlg('Deseja deletar este item?', mtConfirmation, [mbOk, mbCancel], 1) = mrOk then
    begin
      curValorTotal := curValorTotal - memTableProdutos.Fields[4].AsCurrency;
      memTableProdutos.Delete;
      TotalizaGrid;
    end;
end;

procedure TfrmPedidos.TotalizaGrid;
begin
  lblValorTotal.Caption := 'Valor Total: R$ ' + FormatFloat('0.00', curValorTotal);
end;

procedure TfrmPedidos.BuscaCliente;
var
  controllerCliente: TcontrollerCliente;
  query: TFDQuery;
begin
  if edtCiente.Text <> EmptyStr then
    begin
      controllerCliente := TcontrollerCliente.Create;
      try
        query := TFDQuery.Create(nil);
        query := controllerCliente.consultar(StrToInt(edtCiente.Text));
        if query <> nil then
          begin
            lblCliente.Caption := query.Fields[1].AsString;
          end
        else
          begin
            MessageDlg('Cliente não localizado', mtError, [mbOk], 0);
            lblCliente.Caption := EmptyStr;
            edtCiente.SetFocus;
          end;
      finally
        FreeAndNil(controllerCliente);
        FreeAndNil(query);
      end;
    end
  else
    lblCliente.Caption := EmptyStr;
end;

procedure TfrmPedidos.ConsultaPedido;
var
  controllerPedido: TControllerPedido;
  controllerPedidoItens: TControllerPedidoItens;
  queryAux: TFDQuery;
begin
  controllerPedido := TControllerPedido.Create;
  controllerPedidoItens := TControllerPedidoItens.Create;
  try
    queryAux := TFDQuery.Create(nil);
    queryAux := controllerPedido.consultar(StrToInt(edtNroPedidoConsulta.Text));
    if queryAux <> nil then
      begin
        edtNroPedido.Text := queryAux.Fields[0].AsString;
        edtData.Date := queryAux.Fields[1].AsDateTime;
        edtCiente.Text := queryAux.Fields[2].AsString;
        BuscaCliente;
        curValorTotal := queryAux.Fields[3].AsCurrency;
        TotalizaGrid;
        CopiaDataSet(controllerPedidoItens.consultar(StrToInt(edtNroPedidoConsulta.Text)));
      end
    else
      begin
        MessageDlg('Pedido não localizado', mtError, [mbOk], 0);
        LimparCampos;
      end;
  finally
    FreeAndNil(queryAux);
    FreeAndNil(controllerPedido);
    FreeAndNil(controllerPedidoItens);
  end;
end;

procedure TfrmPedidos.ExcluiPedido;
var
  controllerPedido: TControllerPedido;
  controllerPedidoItens: TControllerPedidoItens;
  queryAux: TFDQuery;
begin
  ConsultaPedido;
  if MessageDlg('Deseja cancelar este pedido?', mtConfirmation, [mbOk, mbCancel], 1) = mrOk then
    if edtNroPedido.Text <> EmptyStr then
      begin
        controllerPedido := TControllerPedido.Create;
        controllerPedidoItens := TControllerPedidoItens.Create;
        try
          queryAux := TFDQuery.Create(nil);
          if controllerPedido.excluir(StrToInt(edtNroPedidoConsulta.Text)) then
            begin
              MessageDlg('Pedido cancelado com sucesso', mtInformation, [mbOk], 0);
              LimparCampos;
            end
          else
            MessageDlg('Houve algum erro ao cancelar o pedido', mtError, [mbOk], 0);
        finally
          FreeAndNil(queryAux);
          FreeAndNil(controllerPedido);
          FreeAndNil(controllerPedidoItens);
        end;
      end;
end;

end.
