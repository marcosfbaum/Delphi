program ProjSistemaAmortizacaoJuros;

uses
  Vcl.Forms,
  uFPrincipal in '..\Forms\uFPrincipal.pas' {FPrincipal},
  uFSimulacaoFinanciamento in '..\Forms\uFSimulacaoFinanciamento.pas' {FSimulacaoFinanciamento},
  uFDMemTableHelper in '..\Helpers\uFDMemTableHelper.pas',
  uTEditHelper in '..\Helpers\uTEditHelper.pas',
  uException.Validation in '..\Utils\uException.Validation.pas',
  uTDBGridHelper in '..\Helpers\uTDBGridHelper.pas',
  uFinance.Controller in '..\Controllers\uFinance.Controller.pas',
  uInstallment in '..\Units\uInstallment.pas',
  uIInstallment in '..\Units\uIInstallment.pas',
  uFinancing in '..\Units\uFinancing.pas',
  uIFinancing in '..\Units\uIFinancing.pas',
  uSystemUtils in '..\Utils\uSystemUtils.pas',
  uResources.Utils in '..\Forms\uResources.Utils.pas' {FResourcesUtils};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  ReportMemoryLeaksOnShutdown := True;
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.CreateForm(TFResourcesUtils, FResourcesUtils);
  Application.Run;
end.
