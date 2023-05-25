unit Controllers.Pedido.Itens;

interface

procedure registrarRotas;

implementation

uses Horse,system.JSON,Service.PedidoItens,Dataset.Serialize;

procedure ListarItensPedidos(req :THorseRequest; res : THorseResponse; next : TProc);
begin
  var retorno := TJsonObject.Create;
  var service := TServicePedidoItens.Create;
  try
    retorno.AddPair('data',service.ListAllByPedido(req.Query.Dictionary,req.Params['id_pedido']).ToJSONArray());
    retorno.AddPair('records', service.GetRecordCount);
    res.Send(retorno);
  finally
    service.Free;
  end;
end;

procedure ObterItemPedido(req :THorseRequest; res : THorseResponse; next : TProc);
begin
  var service := TServicePedidoItens.Create;
  try
    if Service.GetByPedido(Req.Params['id_pedido'],Req.Params['id_item']).IsEmpty then
      raise EHorseException.Create().Error('Item não cadastrado');
    Res.Send(service.queryCadastro.ToJSONObject());
  finally
    service.Free;
  end;
end;

procedure CadastrarItemPedido(req :THorseRequest; res : THorseResponse; next : TProc);
begin
  var service := TServicePedidoItens.Create;
  try
    var LItem := Req.Body<TJSONObject>;
    var LIdPedido := Req.Params.Items['id_pedido'];
    LItem.AddPair('id_pedido', TJSONNumber.Create(LIdPedido));
    if service.Append(LItem) then
      Res.Send(service.queryCadastro.ToJSONObject()).Status(THTTPStatus.Created);
  finally
    service.Free;
  end;
end;

procedure AlterarItemPedido(req :THorseRequest; res : THorseResponse; next : TProc);
begin
  var service := TServicePedidoItens.Create;
  try
    var requestJson := Req.Body<TJsonObject>;
    if service.GetByPedido(req.Params['id_pedido'],req.Params['id_item']).IsEmpty then
      raise EHorseException.Create().Error('Item não existe');
    requestJson.RemovePair('id_pedido').Free;
    if Service.Update(requestJson) then
      Res.Send('').Status(204);
  finally
    service.Free;
  end;
end;

procedure DeletarItemPedido(req :THorseRequest; res : THorseResponse; next : TProc);
begin
  var service := TServicePedidoItens.Create;
  try
    if service.GetByPedido(req.Params.Items['id_pedido'],req.Params.Items['id_item']).IsEmpty then
      raise EHorseException.Create().Error('Não existe o item no pedido');
    if service.Delete then
      res.Send('').Status(204);
  finally
    service.Free;
  end;
end;

procedure registrarRotas;
begin
  THorse.Get('/pedidos/:id_pedido/itens',ListarItensPedidos);
  THORSE.Get('/pedidos/:id_pedido/itens/:id_item',ObterItemPedido);
  THorse.Post('/pedidos/:id_pedido/itens',CadastrarItemPedido);
  THorse.Put('/pedidos/:id_pedido/itens/:id_item',AlterarItemPedido);
  THorse.Delete('/pedidos/:id_pedido/itens/:id_item',DeletarItemPedido);
end;

end.
