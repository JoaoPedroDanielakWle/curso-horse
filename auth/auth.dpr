program auth;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  Horse.Jhonson,
  System.JSON,
  Controller.Auth in 'src\controllers\Controller.Auth.pas',
  Providers.Connection in 'src\providers\Providers.Connection.pas' {DataModule1: TDataModule},
  Service.Auth in 'src\services\Service.Auth.pas' {ServiceAuth: TDataModule},
  Horse.HandleException;

begin
  THorse.Use(Jhonson())
    .Use(HandleException);
  Controller.Auth.RegistrarRotas;


  THorse.Listen(8000);
end.
