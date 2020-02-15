program MoneyMachine;

uses
  Vcl.Forms,
  uMain in '..\form\uMain.pas' {FMain},
  UIMaquina in '..\interface\UIMaquina.pas',
  UMaquinaDinheiro in '..\class\UMaquinaDinheiro.pas',
  UTroco in '..\class\UTroco.pas',
  UExeptionExtension in '..\class\UExeptionExtension.pas';

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := (DebugHook <> 0);
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMain, FMain);
  Application.Run;
end.
