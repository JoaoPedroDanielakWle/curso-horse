unit Service.PedidoItens;

interface

uses
  System.SysUtils, System.Classes, Providers.Cadastro, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.ConsoleUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, system.JSON, system.Generics.Collections,
  FireDAC.VCLUI.Wait;

type
  TServicePedidoItens = class(TProvidersCadastro)
    queryPesquisaid: TLargeintField;
    queryPesquisaid_produto: TLargeintField;
    queryPesquisaid_pedido: TLargeintField;
    queryPesquisavalor: TFMTBCDField;
    queryPesquisaquantidade: TFMTBCDField;
    queryPesquisanome_produto: TWideStringField;
    queryCadastroid: TLargeintField;
    queryCadastroid_produto: TLargeintField;
    queryCadastroid_pedido: TLargeintField;
    queryCadastrovalor: TFMTBCDField;
    queryCadastroquantidade: TFMTBCDField;
    queryCadastronome_produto: TWideStringField;
  private
    { Private declarations }
  public
    { Public declarations }
    function Append(const AJson: TJsonObject): Boolean ; override;
    function Update(const AJson: TJsonObject): Boolean ; override;
    function ListAllByPedido(const AParams : TDictionary<string,string>; const idPedido :string): TFDQuery;
    function GetByPedido(idPedido, idItem : string) : TFDQuery;
  end;

var
  ServicePedidoItens: TServicePedidoItens;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TProvidersCadastro1 }

function TServicePedidoItens.Append(const AJson: TJsonObject): Boolean;
begin
  Result := inherited Append(AJson);
  queryCadastroid_pedido.Visible := false;
end;

function TServicePedidoItens.GetByPedido(idPedido, idItem: string): TFDQuery;
begin
  queryCadastro.SQL.Add('where i.id = :id');
  queryCadastro.SQL.Add('and i.id_pedido = :id_pedido');
  queryCadastro.ParamByName('id').AsLargeInt := idItem.ToInt64;
  queryCadastro.ParamByName('id_pedido').AsLargeInt := idPedido.ToInt64;
  queryCadastro.Open;
  Result := queryCadastro;
end;

function TServicePedidoItens.ListAllByPedido(const AParams: TDictionary<string, string>;
  const idPedido : string): TFDQuery;
begin
  queryPesquisa.ParamByName('id_pedido').AsLargeInt := idPedido.ToInt64;
  queryRecordCount.ParamByName('id_pedido').AsLargeInt := idPedido.ToInt64;
  Result := inherited ListAll(AParams);
end;

function TServicePedidoItens.Update(const AJson: TJsonObject): Boolean;
begin
  Result := inherited Update(AJson);
  queryCadastroid_pedido.Visible := false;
end;

end.
