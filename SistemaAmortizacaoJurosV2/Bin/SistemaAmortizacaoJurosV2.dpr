program SistemaAmortizacaoJurosV2;

uses
  Vcl.Forms,
  IIFinanciamento.Factory in '..\Core\Financiamento\Factory\IIFinanciamento.Factory.pas',
  IIFinanciamento.Service in '..\Core\Financiamento\Service\IIFinanciamento.Service.pas',
  IIFinanciamento in '..\Base\IIFinanciamento.pas',
  IIFinanciamento.PagamentoUnico in '..\Core\Financiamento\IIFinanciamento.PagamentoUnico.pas',
  IFinanciamento.Observer in '..\Observer\Financiamento\IFinanciamento.Observer.pas',
  IFinanciamento.Subject in '..\Observer\Financiamento\IFinanciamento.Subject.pas',
  Financiamento.Factory in '..\Core\Financiamento\Factory\Financiamento.Factory.pas',
  Financiamento.Model in '..\Models\Financiamento.Model.pas',
  Financiamento.Types in '..\Core\Financiamento\Financiamento.Types.pas',
  Financiamento.PagamentoUnico in '..\Core\Financiamento\Financiamento.PagamentoUnico.pas',
  FinanciamentoModel.Subject in '..\Observer\Financiamento\FinanciamentoModel.Subject.pas',
  uFPrincipal in '..\View\uFPrincipal.pas' {FPrincipal},
  FSimulacaoFinanciamento in '..\View\FSimulacaoFinanciamento.pas' {FSimulacaoFinanciamento},
  uResources.Utils in '..\View\uResources.Utils.pas' {FResourcesUtils};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.CreateForm(TFResourcesUtils, FResourcesUtils);
  Application.Run;
end.
