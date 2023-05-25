inherited ServiceAuth: TServiceAuth
  object queryLogin: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select id,senha'
      'from usuario'
      'where login = :login'
      'and status = 1')
    Left = 288
    Top = 280
    ParamData = <
      item
        Name = 'LOGIN'
        ParamType = ptInput
      end>
    object queryLoginid: TLargeintField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object queryLoginsenha: TWideStringField
      FieldName = 'senha'
      Origin = 'senha'
      Size = 256
    end
  end
end
