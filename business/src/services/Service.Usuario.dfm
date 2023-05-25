inherited ServiceUsuario: TServiceUsuario
  inherited queryPesquisa: TFDQuery
    CachedUpdates = True
    SQL.Strings = (
      'SELECT ID,NOME,'
      'LOGIN,STATUS,'
      'TELEFONE,SEXO'
      ''
      'FROM'
      'USUARIO'
      'WHERE 1=1')
  end
  inherited queryRecordCount: TFDQuery
    CachedUpdates = True
    SQL.Strings = (
      'SELECT COUNT(ID) FROM USUARIO'
      'WHERE 1=1')
  end
  inherited queryCadastro: TFDQuery
    BeforePost = queryCadastroBeforePost
    CachedUpdates = True
    SQL.Strings = (
      'SELECT * FROM USUARIO')
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
    object queryCadastrologin: TWideStringField
      FieldName = 'login'
      Origin = '"login"'
      Size = 30
    end
    object queryCadastrosenha: TWideStringField
      FieldName = 'senha'
      Origin = 'senha'
      Size = 256
    end
    object queryCadastrostatus: TSmallintField
      FieldName = 'status'
      Origin = 'status'
    end
    object queryCadastrotelefone: TWideStringField
      FieldName = 'telefone'
      Origin = 'telefone'
    end
    object queryCadastrosexo: TSmallintField
      FieldName = 'sexo'
      Origin = 'sexo'
    end
    object queryCadastrofoto: TBlobField
      FieldName = 'foto'
      Origin = 'foto'
      Visible = False
    end
  end
end
