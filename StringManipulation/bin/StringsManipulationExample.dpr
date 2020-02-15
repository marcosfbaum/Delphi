program StringsManipulationExample;

uses
  Vcl.Forms,
  uMain in '..\form\uMain.pas' {FMain},
  uISubstitui in '..\interface\uISubstitui.pas',
  uSubstitui in '..\units\uSubstitui.pas',
  uExeptionExtension in '..\units\uExeptionExtension.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMain, FMain);
  Application.Run;
end.
