inherited ServicePedido: TServicePedido
  inherited queryPesquisa: TFDQuery
    SQL.Strings = (
      'SELECT P.*, C.NOME AS nome_cliente'
      'FROM PEDIDO P '
      'INNER JOIN CLIENTE C'
      'ON C.ID = P.ID_CLIENTE'
      'WHERE 1=1')
    object queryPesquisaid: TLargeintField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object queryPesquisaid_cliente: TLargeintField
      FieldName = 'id_cliente'
      Origin = 'id_cliente'
    end
    object queryPesquisaid_usuario: TLargeintField
      FieldName = 'id_usuario'
      Origin = 'id_usuario'
    end
    object queryPesquisadata: TSQLTimeStampField
      FieldName = 'data'
      Origin = 'data'
      ProviderFlags = [pfInUpdate]
    end
    object queryPesquisanome_cliente: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'nome_cliente'
      Origin = 'nome_cliente'
      Size = 60
    end
  end
  inherited queryRecordCount: TFDQuery
    SQL.Strings = (
      'select count(p.id)'
      'from pedido p'
      'inner join cliente c'
      'on c.id = p.id_cliente')
  end
  inherited queryCadastro: TFDQuery
    SQL.Strings = (
      'SELECT P.*, C.NOME AS nome_cliente'
      'FROM PEDIDO P '
      'INNER JOIN CLIENTE C'
      'ON C.ID = P.ID_CLIENTE')
    object queryCadastroid: TLargeintField
      AutoGenerateValue = arAutoInc
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
    end
    object queryCadastroid_cliente: TLargeintField
      FieldName = 'id_cliente'
      Origin = 'id_cliente'
    end
    object queryCadastroid_usuario: TLargeintField
      FieldName = 'id_usuario'
      Origin = 'id_usuario'
    end
    object queryCadastrodata: TSQLTimeStampField
      FieldName = 'data'
      Origin = 'data'
      ProviderFlags = [pfInUpdate]
    end
    object queryCadastronome_cliente: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'nome_cliente'
      Origin = 'nome_cliente'
      Size = 60
    end
  end
end
