object ProvidersConnection: TProvidersConnection
  Height = 480
  Width = 640
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    VendorHome = 'C:\delphi\auth'
    Left = 288
    Top = 120
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'ConnectionDef=Curso_Pooled')
    Left = 432
    Top = 128
  end
end
