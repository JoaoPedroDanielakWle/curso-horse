object ProvidersCadastro: TProvidersCadastro
  Height = 480
  Width = 640
  object FDConnection1: TFDConnection
    Params.Strings = (
      'ConnectionDef=Curso_Pooled')
    Connected = True
    Left = 152
    Top = 16
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    VendorHome = 'C:\delphi\business\'
    Left = 40
    Top = 16
  end
  object queryPesquisa: TFDQuery
    CachedUpdates = True
    Connection = FDConnection1
    SQL.Strings = (
      '')
    Left = 136
    Top = 184
  end
  object queryRecordCount: TFDQuery
    CachedUpdates = True
    Connection = FDConnection1
    Left = 256
    Top = 176
    object queryRecordCountCOUNT: TLargeintField
      FieldName = 'COUNT'
    end
  end
  object queryCadastro: TFDQuery
    CachedUpdates = True
    Connection = FDConnection1
    Left = 376
    Top = 176
  end
end
