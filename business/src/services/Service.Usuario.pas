unit Service.Usuario;

interface

uses
  System.SysUtils, System.Classes, Providers.Cadastro, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.ConsoleUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.Json, system.Generics.Collections,
  FireDAC.VCLUI.Wait;

type
  TServiceUsuario = class(TProvidersCadastro)
    queryCadastroid: TLargeintField;
    queryCadastronome: TWideStringField;
    queryCadastrologin: TWideStringField;
    queryCadastrosenha: TWideStringField;
    queryCadastrostatus: TSmallintField;
    queryCadastrotelefone: TWideStringField;
    queryCadastrosexo: TSmallintField;
    queryCadastrofoto: TBlobField;
    procedure queryCadastroBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    function GetById(const AId : string) : TFDQuery; override;
    function Append(const AJson: TJsonObject): Boolean ; override;
    function Update(const AJson: TJsonObject): Boolean ; override;
    function ListAll(const AParams : TDictionary<string,string>): TFDQuery; override;
    function SalvarFotoUsuario(const AFoto : TStream) : Boolean;
    function ObterFotoUsuario: TStream;
  end;

var
  ServiceUsuario: TServiceUsuario;

implementation

uses
  BCrypt;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TServiceUsuario }

function TServiceUsuario.Append(const AJson: TJsonObject): Boolean;
begin
  Result := inherited Append(AJson);
  queryCadastrosenha.Visible := false;
end;

function TServiceUsuario.GetById(const AId: string): TFDQuery;
begin
  Result := inherited GetById(AId);
  queryCadastrosenha.Visible := False;
end;

function TServiceUsuario.ListAll(
  const AParams: TDictionary<string, string>): TFDQuery;
begin
  queryCadastrosenha.Visible := false;
  Result := inherited ListAll(AParams);
end;

procedure TServiceUsuario.queryCadastroBeforePost(DataSet: TDataSet);
begin
  inherited;
  if (queryCadastrosenha.NewValue <> queryCadastrosenha.OldValue) and (not queryCadastrosenha.AsString.Trim.IsEmpty) then
    queryCadastrosenha.AsString := TBCrypt.GenerateHash(queryCadastrosenha.AsString);
end;

function TServiceUsuario.SalvarFotoUsuario(const AFoto: TStream): Boolean;
begin
  //ja ta aberta a query por causa do queryById
  queryCadastro.Edit;
  queryCadastrofoto.LoadFromStream(AFoto);
  queryCadastro.Post;
  Result := queryCadastro.ApplyUpdates(0) = 0;
  //quando testar, passar no headers o application/octet-stream
end;

function TServiceUsuario.Update(const AJson: TJsonObject): Boolean;
begin
  queryCadastrosenha.Visible := True;
  Result := inherited Update(AJson);
end;

function TServiceUsuario.ObterFotoUsuario() : TStream;
begin
  Result := nil;
  if queryCadastrofoto.IsNull then
    Exit;
  Result := TMemoryStream.Create;
  queryCadastrofoto.SaveToStream(Result);
end;

end.
