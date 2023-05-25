inherited ServiceProduto: TServiceProduto
  inherited queryPesquisa: TFDQuery
    SQL.Strings = (
      'SELECT * FROM PRODUTO'
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
    object queryPesquisavalor: TFMTBCDField
      FieldName = 'valor'
      Origin = 'valor'
      Precision = 20
      Size = 4
    end
    object queryPesquisastatus: TSmallintField
      FieldName = 'status'
      Origin = 'status'
    end
    object queryPesquisaestoque: TFMTBCDField
      FieldName = 'estoque'
      Origin = 'estoque'
      Precision = 20
      Size = 4
    end
  end
  inherited queryRecordCount: TFDQuery
    SQL.Strings = (
      'SELECT COUNT(*) FROM PRODUTO'
      'WHERE 1=1')
    Top = 184
  end
  inherited queryCadastro: TFDQuery
    SQL.Strings = (
      'SELECT * FROM PRODUTO')
    Left = 384
    object queryCadastroid: TLargeintField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object queryCadastronome: TWideStringField
      FieldName = 'nome'
      Origin = 'nome'
      Size = 60
    end
    object queryCadastrovalor: TFMTBCDField
      FieldName = 'valor'
      Origin = 'valor'
      Precision = 20
      Size = 4
    end
    object queryCadastrostatus: TSmallintField
      FieldName = 'status'
      Origin = 'status'
    end
    object queryCadastroestoque: TFMTBCDField
      FieldName = 'estoque'
      Origin = 'estoque'
      Precision = 20
      Size = 4
    end
  end
end
