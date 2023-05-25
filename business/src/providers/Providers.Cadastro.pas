unit Providers.Cadastro;

interface

uses
  System.SysUtils, System.Classes, Data.DB, DBAccess, Uni, MemDS, System.JSON, System.Generics.Collections,
  DataSet.Serialize, UniProvider, PostgreSQLUniProvider, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.ConsoleUI.Wait,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TProvidersCadastro = class(TDataModule)
    FDConnection1: TFDConnection;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    queryPesquisa: TFDQuery;
    queryRecordCount: TFDQuery;
    queryCadastro: TFDQuery;
    queryRecordCountCOUNT: TLargeintField;
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create; reintroduce; // -> Reintroduce, basicamente overload
    function Append(const AJson: TJsonObject): Boolean ; virtual;
    function Update(const AJson: TJsonObject): Boolean ; virtual;
    function Delete: Boolean ; virtual;
    function ListAll(const AParams : TDictionary<string,string>): TFDQuery; virtual;
    function GetById(const AId : string) : TFDQuery; virtual;
    function GetRecordCount : Int64; virtual;
  end;

var
  ProvidersCadastro: TProvidersCadastro;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TDataModule2 }

function TProvidersCadastro.Append(const AJson: TJsonObject): Boolean;
begin
  queryCadastro.sql.Add('WHERE 1<>1');
  queryCadastro.open();
  queryCadastro.LoadFromJson(AJson, False); // parametro false nao destroi o json
  Result := queryCadastro.ApplyUpdates(0) = 0;
end;

constructor TProvidersCadastro.Create;
begin
  inherited Create(nil);
end;

function TProvidersCadastro.Delete: Boolean;
begin
  queryCadastro.Delete;
  Result := queryCadastro.ApplyUpdates(0) = 0;
end;

function TProvidersCadastro.GetById(const AId: string): TFDQuery;
begin
  queryCadastro.SQL.Add('WHERE ID = :ID');
  queryCadastro.ParamByName('id').AsLargeInt := AId.ToInt64;
  queryCadastro.Open;
  Result := queryCadastro;
end;

function TProvidersCadastro.GetRecordCount: Int64;
begin
  queryRecordCount.Open;
  Result := queryRecordCountCOUNT.AsLargeInt;
end;

function TProvidersCadastro.ListAll(
  const AParams: TDictionary<string, string>): TFDQuery;
var
JsonArray : TJsonObject;
JsonObject : TJsonObject;
begin
  if AParams.ContainsKey('limit') then
  begin
    queryPesquisa.FetchOptions.RecsMax := StrToIntDef(AParams.Items['limit'], 50);
    queryPesquisa.FetchOptions.RowsetSize := StrToIntDef(AParams.Items['limit'], 50);
  end;
  if AParams.ContainsKey('offset') then
    queryPesquisa.FetchOptions.RecsSkip := StrToIntDef(AParams.Items['offset'], 0);
  queryPesquisa.Open();
  Result := queryPesquisa;
end;

function TProvidersCadastro.Update(const AJson: TJsonObject): Boolean;
begin
  queryCadastro.MergeFromJsonObject(AJson,False);
  Result := queryCadastro.ApplyUpdates(0) = 0;
end;

end.
