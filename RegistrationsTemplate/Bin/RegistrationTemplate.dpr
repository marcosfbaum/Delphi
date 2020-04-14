program RegistrationTemplate;

uses
  Vcl.Forms,
  uMainForm in '..\Forms\uMainForm.pas' {Form1},
  uEntity in '..\FrameWork\uEntity.pas',
  uEntityAttributes in '..\FrameWork\uEntityAttributes.pas',
  uIConexaoDatabase in '..\FrameWork\uIConexaoDatabase.pas',
  uConexaoDatabase in '..\FrameWork\uConexaoDatabase.pas',
  uIniFile.Utils in '..\Utils\uIniFile.Utils.pas',
  uFRegistrationTemplate in '..\Templates\uFRegistrationTemplate.pas' {FRegistrationTemplate},
  uGenericDAO in '..\FrameWork\uGenericDAO.pas',
  uAlunoEntity in '..\Entities\uAlunoEntity.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
