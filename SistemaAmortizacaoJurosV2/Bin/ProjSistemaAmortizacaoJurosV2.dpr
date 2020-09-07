program ProjSistemaAmortizacaoJurosV2;

uses
  Vcl.Forms,
  Financiamento.Factory in '..\Units\Financiamento.Factory.pas',
  FSimulacaoFinanciamento in '..\Forms\FSimulacaoFinanciamento.pas' {SimulacaoFinanciamento},
  Financiamento.Model in '..\Models\Financiamento.Model.pas',
  Financiamento.Types in '..\Units\Financiamento.Types.pas',
  IIFinanciamento.Factory in '..\Units\IIFinanciamento.Factory.pas',
  IIFinanciamento.Service in '..\Units\IIFinanciamento.Service.pas',
  IIFinanciamento in '..\Units\IIFinanciamento.pas',
  Financiamento.PagamentoUnico in '..\Units\Financiamento.PagamentoUnico.pas',
  uFPrincipal in '..\Forms\uFPrincipal.pas' {FPrincipal},
  uResources.Utils in '..\Forms\uResources.Utils.pas' {FResourcesUtils};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.CreateForm(TFResourcesUtils, FResourcesUtils);
  Application.Run;
end.
