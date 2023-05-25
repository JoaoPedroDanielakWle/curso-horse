inherited ServicePedidoItens: TServicePedidoItens
  inherited queryPesquisa: TFDQuery
    SQL.Strings = (
      'SELECT I.ID,'
      'I.ID_PRODUTO,'
      'I.ID_PEDIDO,'
      'I.VALOR,'
      'I.QUANTIDADE,'
      'P.NOME AS nome_produto'
      'FROM'
      'PEDIDO_ITEM I'
      'INNER JOIN PRODUTO P'
      'ON P.ID = I.ID_PRODUTO'
      ''
      'WHERE I.ID_PEDIDO = :id_pedido')
    ParamData = <
      item
        Name = 'ID_PEDIDO'
        ParamType = ptInput
      end>
    object queryPesquisaid: TLargeintField
      AutoGenerateValue = arAutoInc
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
    end
    object queryPesquisaid_produto: TLargeintField
      FieldName = 'id_produto'
      Origin = 'id_produto'
    end
    object queryPesquisaid_pedido: TLargeintField
      FieldName = 'id_pedido'
      Origin = 'id_pedido'
    end
    object queryPesquisavalor: TFMTBCDField
      FieldName = 'valor'
      Origin = 'valor'
      Precision = 20
      Size = 4
    end
    object queryPesquisaquantidade: TFMTBCDField
      FieldName = 'quantidade'
      Origin = 'quantidade'
      Precision = 20
      Size = 4
    end
    object queryPesquisanome_produto: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'nome_produto'
      Origin = 'nome_produto'
      Size = 60
    end
  end
  inherited queryRecordCount: TFDQuery
    SQL.Strings = (
      'SELECT COUNT(I.ID)'
      'FROM PEDIDO_ITEM I'
      'INNER JOIN PRODUTO P ON'
      'P.ID = I.ID_PRODUTO'
      'WHERE I.ID_PEDIDO = :ID_PEDIDO')
    ParamData = <
      item
        Name = 'ID_PEDIDO'
        ParamType = ptInput
      end>
  end
  inherited queryCadastro: TFDQuery
    SQL.Strings = (
      'SELECT I.ID,'
      'I.ID_PRODUTO,'
      'I.ID_PEDIDO,'
      'I.VALOR,'
      'I.QUANTIDADE,'
      'P.NOME AS nome_produto'
      'FROM'
      'PEDIDO_ITEM I'
      ' INNER JOIN PRODUTO P'
      ' ON P.ID = I.ID_PRODUTO')
    object queryCadastroid: TLargeintField
      AutoGenerateValue = arAutoInc
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
    end
    object queryCadastroid_produto: TLargeintField
      FieldName = 'id_produto'
      Origin = 'id_produto'
    end
    object queryCadastroid_pedido: TLargeintField
      FieldName = 'id_pedido'
      Origin = 'id_pedido'
    end
    object queryCadastrovalor: TFMTBCDField
      FieldName = 'valor'
      Origin = 'valor'
      Precision = 20
      Size = 4
    end
    object queryCadastroquantidade: TFMTBCDField
      FieldName = 'quantidade'
      Origin = 'quantidade'
      Precision = 20
      Size = 4
    end
    object queryCadastronome_produto: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'nome_produto'
      Origin = 'nome_produto'
      Size = 60
    end
  end
end
