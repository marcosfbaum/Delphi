unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Service.TaskDialogProgress;

type
  TFTaskDialogExample = class(TForm)
    btnIncrementProc: TButton;
    btnUndeterminedProgress: TButton;
    btnUserCanAbort: TButton;
    BtnWithException: TButton;
    btnProcessoLento: TButton;
    procedure btnIncrementProcClick(Sender: TObject);
    procedure btnUndeterminedProgressClick(Sender: TObject);
    procedure BtnWithExceptionClick(Sender: TObject);
    procedure btnUserCanAbortClick(Sender: TObject);
    procedure btnProcessoLentoClick(Sender: TObject);
  private
    procedure ProcessoLento;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FTaskDialogExample: TFTaskDialogExample;

implementation

{$R *.dfm}

procedure TFTaskDialogExample.btnIncrementProcClick(Sender: TObject);
begin
  FTaskDialogProgress.Config.Caption := 'Aguarde o processo de atualização';
  FTaskDialogProgress.Config.AutoClose := False;
  FTaskDialogProgress.Config.UserCanAbort := False;
  FTaskDialogProgress.Start(
    procedure(const AStatus: TTaskStatus)
    begin
      AStatus.SetProgress(1, 100);
      AStatus.SetMessage('Fazendo backup físico do banco de dados...');
      Sleep(3000);

      AStatus.SetProgress(33, 100);
      AStatus.SetMessage('Executando SQL Script no banco de dados no banco de dados no banco de dados no banco de dados no banco de dados...');
      Sleep(3000);

      AStatus.SetProgress(66, 100);
      AStatus.SetMessage('Atualizando a aplicação e suas dependências...');
      Sleep(3000);

      AStatus.SetProgress(95, 100);
      AStatus.SetMessage('Removendo arquivos temporários...');
      Sleep(1000);

      AStatus.SetProgress(100, 100);
      AStatus.SetMessage('Atualização completa!');
    end);
end;

procedure TFTaskDialogExample.btnUndeterminedProgressClick(Sender: TObject);
begin
  FTaskDialogProgress.Config.Caption := 'Aguarde o processo de atualização';
  FTaskDialogProgress.Start(
    procedure(const AStatus: TTaskStatus)
    begin
      AStatus.SetMessage('Fazendo backup físico do banco de dados...');
      Sleep(3000);

      AStatus.SetMessage('Executando SQL Script no banco de dados...');
      Sleep(3000);

      AStatus.SetMessage('Atualizando a aplicação e suas dependências...');
      Sleep(3000);

      AStatus.SetMessage('Atualização completa!');
    end);
end;

procedure TFTaskDialogExample.btnUserCanAbortClick(Sender: TObject);
begin
  FTaskDialogProgress.Config.Caption := 'Aguarde o processo de atualização';
  FTaskDialogProgress.Config.AutoClose := False;
  FTaskDialogProgress.Config.UserCanAbort := True;
  FTaskDialogProgress.Start(
    procedure(const AStatus: TTaskStatus)
    begin
      AStatus.SetMessage('Fazendo backup físico do banco de dados...');
      Sleep(3000);

      if (AStatus.UserRequestAbort) then
        raise Exception.Create('Processo abortado pelo usuário');

      AStatus.SetMessage('Executando SQL Script no banco de dados...');
      Sleep(3000);

      if (AStatus.UserRequestAbort) then
        raise Exception.Create('Processo abortado pelo usuário');

      AStatus.SetMessage('Atualizando a aplicação e suas dependências...');
      Sleep(3000);

      if (AStatus.UserRequestAbort) then
        raise Exception.Create('Processo abortado pelo usuário');

      Sleep(1000);

      AStatus.SetMessage('Atualização completa!');
    end);
end;

procedure TFTaskDialogExample.BtnWithExceptionClick(Sender: TObject);
begin
  FTaskDialogProgress.Config.AutoClose := False;
  FTaskDialogProgress.Config.Caption := 'Aguarde o processo de atualização';
  FTaskDialogProgress.Start(
    procedure(const AStatus: TTaskStatus)
    begin
      AStatus.SetMessage('Fazendo backup físico do banco de dados...');
      Sleep(3000);

      raise Exception.Create('Ocorreu uma exceção no meio do procedimento!');

      AStatus.SetMessage('Executando SQL Script no banco de dados...');
      Sleep(3000);

      AStatus.SetMessage('Atualizando a aplicação e suas dependências...');
      Sleep(3000);

      AStatus.SetMessage('Atualização completa!');
    end);
end;

procedure TFTaskDialogExample.btnProcessoLentoClick(Sender: TObject);
begin
  FTaskDialogProgress.Config.AutoClose := False;
  FTaskDialogProgress.Config.Caption := 'Aguarde o processo de atualização';
  FTaskDialogProgress.Start(ProcessoLento);
end;

procedure TFTaskDialogExample.ProcessoLento;
begin
  FTaskDialogProgress.Status.SetMessage('Fazendo backup físico do banco de dados...');
  Sleep(3000);

  FTaskDialogProgress.Status.SetMessage('Executando SQL Script no banco de dados...');
  Sleep(3000);

  FTaskDialogProgress.Status.SetMessage('Atualizando a aplicação e suas dependências...');
  Sleep(3000);

  FTaskDialogProgress.Status.SetMessage('Atualização completa!');
end;



end.
