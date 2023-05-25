unit Service.Cliente;

interface

uses
  System.SysUtils, System.Classes, Providers.Cadastro, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.ConsoleUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, system.Generics.Collections;

type
  TServiceCliente = class(TProvidersCadastro)
    queryCadastroid: TLargeintField;
    queryCadastronome: TWideStringField;
    queryCadastrostatus: TSmallintField;
    queryPesquisaid: TLargeintField;
    queryPesquisanome: TWideStringField;
    queryPesquisastatus: TSmallintField;
  private
    { Private declarations }
  public
    function ListAll(const AParams : TDictionary<string,string>): TFDQuery; override;
  end;

var
  ServiceCliente: TServiceCliente;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TServiceCliente }

{ TServiceCliente }

function TServiceCliente.ListAll(
  const AParams: TDictionary<string, string>): TFDQuery;
begin
  if AParams.ContainsKey('id') then
  begin
    queryPesquisa.SQL.Add('AND id = :ID');
    queryPesquisa.ParamByName('id').AsInteger := AParams.Items['id'].ToInt64;
    queryRecordCount.Sql.Add('AND id = :ID');
    queryRecordCount.ParamByName('id').AsInteger := AParams.Items['id'].ToInt64;
  end;
  if AParams.ContainsKey('nome') then
  begin
    queryPesquisa.SQL.Add('AND lower(nome) like :nome');
    queryPesquisa.ParamByName('nome').AsString := '%'+AParams.Items['nome'].ToLower+'%';
    queryRecordCount.Sql.Add('AND lower(nome) like :nome');
    queryRecordCount.ParamByName('nome').AsString := '%'+AParams.Items['nome'].ToLower+'%';
  end;
  if AParams.ContainsKey('status') then
  begin
    queryPesquisa.SQL.Add('AND status = :status');
    queryPesquisa.ParamByName('status').AsInteger := AParams.Items['status'].ToInt64;
    queryRecordCount.Sql.Add('AND status = :status');
    queryRecordCount.ParamByName('status').AsInteger := AParams.Items['status'].ToInt64;
  end;
  queryPesquisa.SQL.Add('order by Id');
  Result := inherited ListAll(AParams);
end;

end.
