program InputQueryExample;

uses
  Vcl.Forms,
  uMain in '..\Forms\uMain.pas' {Form1},
  uInputQueryForm in '..\Unit\uInputQueryForm.pas',
  uInputQuery in '..\Unit\uInputQuery.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
