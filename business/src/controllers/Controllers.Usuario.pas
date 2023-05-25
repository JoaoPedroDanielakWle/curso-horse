unit Controllers.Usuario;

interface

procedure RegistrarRotas;

implementation

uses Horse,Service.Usuario,System.JSON, Dataset.Serialize, Data.DB, System.SysUtils, System.Classes;

procedure ListarUsuarios(Req : THorseRequest; Res : THorseResponse; Next : TProc);
begin
  var LService := TServiceUsuario.Create;
  try
    var LRetorno := TJSONObject.Create;
    LRetorno.AddPair('data',LService.ListAll(req.Params.Dictionary).toJsonArray);
    LRetorno.AddPair('count', TJSONNumber.Create(LService.GetRecordCount));
    Res.Send<TJSONObject>(LRetorno).Status(201);
  finally
    LService.Free;
  end;
end;

procedure ObterUsuario(Req : THorseRequest; Res : THorseResponse; Next : TProc);
begin
  var service := TServiceUsuario.Create;
  var response := service.GetById(req.Params['id']);
  try
    if (not response.IsEmpty) then
      res.Send<TJSONObject>(response.ToJSONObject()).Status(200)
    else
      raise EHorseException.Create.Status(THTTPStatus.NotFound);
  finally
    service.Free;
  end;
end;

procedure CadastrarUsuario(Req : THorseRequest; Res : THorseResponse; Next : TProc);
begin
  var service := TServiceUsuario.Create;
  try
    if (service.Append(Req.Body<TJSONObject>)) then
      res.Send(service.queryCadastro.ToJSONObject()).Status(200)
    else
    begin
      raise Exception.Create('Nao pode criar dois users com o mesmo login');
    end;
  finally
    service.Free;
  end;
end; // aqui tem que criptografar....

procedure AlterarUsuario(Req : THorseRequest; Res : THorseResponse; Next : TProc);
begin
  var service := TServiceUsuario.Create;
  try
    if (not service.GetById(Req.Params['id']).IsEmpty) and (service.Update(Req.Body<TJSONObject>)) then
      Res.Send('').Status(204)
    else
        raise EHorseException.Create.Status(THTTPStatus.BadRequest);
  finally
    service.Free;
  end;
end;

procedure DeletarUsuario(Req : THorseRequest; Res : THorseResponse; Next : TProc);
begin
  var service := TServiceUsuario.Create;
  try
    if (not service.GetById(req.Params['id']).IsEmpty) and (service.Delete) then
      res.Send('').Status(204)
    else
        raise EHorseException.Create.Status(THTTPStatus.BadRequest);
  finally
    service.Free;
  end;
end;

procedure CadastrarFotoUsuario(Req : THorseRequest; Res : THorseResponse; Next : TProc);
begin
  var service := TServiceUsuario.Create;
  var LFoto := Req.Body<TMemoryStream>; // aqui na requisi��o ele usa binary, o tipo da body...
  try
    if (not service.GetById(req.Params['id']).IsEmpty) then
    begin
      if not Assigned(LFoto) then
        raise EHorseException.Create().Status(THTTPStatus.BadRequest).Error('Foto inv�lida');
      if service.SalvarFotoUsuario(LFoto) then
        Res.Status(THTTPStatus.NoContent);
    end
    else
        raise EHorseException.Create.Status(THTTPStatus.BadRequest).Error('Usuario nao cadastrado.');
  finally
    service.Free;
  end;
end;

procedure ObterFotoUsuario(Req : THorseRequest; Res : THorseResponse; Next : TProc);
begin
  var service := TServiceUsuario.Create;
  try
    if (not service.GetById(req.Params['id']).IsEmpty) then
    begin
      var Foto := service.ObterFotoUsuario;
      if not Assigned(Foto) then
        raise EHorseException.Create().Status(THTTPStatus.NotFound).Error('N�o existe foto');
      Res.Send(Foto);
    end
    else
        raise EHorseException.Create.Status(THTTPStatus.BadRequest).Error('Usuario nao cadastrado.');
  finally
    service.Free;
  end;
end;

procedure RegistrarRotas;
begin
    THorse.Get('/usuarios',ListarUsuarios);
    THorse.Get('/usuarios/:id',ObterUsuario);
    THorse.Post('/usuarios',CadastrarUsuario);
    THorse.Put('/usuarios/:id',AlterarUsuario);
    THorse.Delete('/usuarios/:id',DeletarUsuario);
    THorse.Post('/usuarios/:id/foto',CadastrarFotoUsuario);
    THorse.Get('/usuarios/:id/foto',ObterFotoUsuario);
end;

end.
