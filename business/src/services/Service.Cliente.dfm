inherited ServiceCliente: TServiceCliente
  inherited queryPesquisa: TFDQuery
    CachedUpdates = True
    SQL.Strings = (
      'SELECT * FROM CLIENTE'
      'WHERE 1=1')
    object queryPesquisaid: TLargeintField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object queryPesquisanome: TWideStringField
      FieldName = 'nome'
      Origin = 'nome'
      Size = 60
    end
    object queryPesquisastatus: TSmallintField
      FieldName = 'status'
      Origin = 'status'
    end
  end
  inherited queryRecordCount: TFDQuery
    CachedUpdates = True
    SQL.Strings = (
      'SELECT COUNT(*) FROM CLIENTE'
      'WHERE 1=1')
  end
  inherited queryCadastro: TFDQuery
    CachedUpdates = True
    SQL.Strings = (
      'SELECT * FROM CLIENTE')
    object queryCadastroid: TLargeintField
      AutoGenerateValue = arAutoInc
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
    end
    object queryCadastronome: TWideStringField
      FieldName = 'nome'
      Origin = 'nome'
      Size = 60
    end
    object queryCadastrostatus: TSmallintField
      FieldName = 'status'
      Origin = 'status'
    end
  end
end
