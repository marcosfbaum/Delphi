program TaskDialogExample;

uses
  Vcl.Forms,
  uMain in '..\Form\uMain.pas' {FTaskDialogExample},
  Service.TaskDialogProgress in '..\Unit\Service.TaskDialogProgress.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFTaskDialogExample, FTaskDialogExample);
  Application.Run;
end.
