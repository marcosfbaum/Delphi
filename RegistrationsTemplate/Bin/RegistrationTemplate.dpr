program RegistrationTemplate;

uses
  Vcl.Forms,
  uMainForm in '..\Forms\uMainForm.pas' {FMain},
  uEntity in '..\FrameWork\uEntity.pas',
  uEntityAttributes in '..\FrameWork\uEntityAttributes.pas',
  uIConexaoDatabase in '..\FrameWork\uIConexaoDatabase.pas',
  uConexaoDatabase in '..\FrameWork\uConexaoDatabase.pas',
  uIniFile.Utils in '..\Utils\uIniFile.Utils.pas',
  uFRegistrationTemplate in '..\Templates\uFRegistrationTemplate.pas' {FRegistrationTemplate},
  uGenericDAO in '..\FrameWork\uGenericDAO.pas',
  uStudentEntity in '..\Entities\uStudentEntity.pas',
  UStudentRegistration in '..\Registrations\UStudentRegistration.pas' {FStudentRegistration},
  uGenericService in '..\FrameWork\uGenericService.pas',
  uException.Validation in '..\Utils\uException.Validation.pas';

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown   := True;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMain, FMain);
  Application.Run;
end.
