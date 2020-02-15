unit Service.TaskDialogProgress;

interface

uses
  Winapi.Windows, Winapi.Messages, Winapi.CommCtrl,
  System.Classes, System.Math, System.SysUtils, System.UITypes,
  System.Diagnostics, System.TimeSpan,
  Vcl.Dialogs, Vcl.Forms, Vcl.StdCtrls;

type
  TTaskConfig = class
  strict private
    FAutoClose: Boolean;
    FCaption: String;
    FUserCanAbort: Boolean;
    FLockButtons: Boolean;
  public
    constructor Create;
    procedure Reset;
    property AutoClose: Boolean read FAutoClose write FAutoClose;
    property Caption: String read FCaption write FCaption;
    property UserCanAbort: Boolean read FUserCanAbort write FUserCanAbort;
    property LockButtons: Boolean read FLockButtons write FLockButtons;
  end;

  TTaskStatus = class
  strict private const
    CWIDTH_LINE: Integer  = 280;
    CHEIGHT_LINE: Integer = 21;
    CTIME_TO_CLOSE: Integer  = 6;
  private
    var
    FLabel: TLabel;
    FCurrentProgress: Byte;
    FMessage: String;
    FUserRequestAbort: Boolean;
    FTimeToClose: Integer;
    FTimerUnlockButton: TStopwatch;
    FTimeSpan: TTimeSpan;
  public
    constructor Create;
    destructor Destroy; override;

    procedure ExecuteWaitToCLose;
    procedure ExecuteWaitToClose2;
    procedure SetMessage(const AMessage: String);
    procedure SetMessageFmt(const AMessage: String; const Args: array of const);
    procedure SetProgress(const APosition, ATotal: Integer);
    procedure Reset;
    property &Message: String read FMessage;
    property UserRequestAbort: Boolean read FUserRequestAbort;
  end;

  TTaskProcObj = procedure of object;
  TTaskProcRef = reference to procedure(const ATaskStatus: TTaskStatus);

  TTaskDialogProgress = class
  strict private
    var
    FException: Exception;
    FHWNDButton: HWND;
    FTaskConfig: TTaskConfig;
    FTaskDialog: TCustomTaskDialog;
    FTaskEnded: Boolean;
    FTaskStatus: TTaskStatus;
    FThread: TThread;
    procedure ChangeProgressState(const AState: TProgressBarState);
    procedure DoHandleException;
    procedure HandleException;
    procedure OnDialogConstructed(ASender: TObject);
    procedure OnTaskTimer(ASender: TObject; ATickCount: Cardinal; var AReset: Boolean);
    procedure OnTaskClick(Sender: TObject; ModalResult: TModalResult; var CanClose: Boolean);
    procedure OnTerminateTask(Sender: TObject);
    procedure Reset;
    procedure ShowTaskDialog;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Start(const ATaskProc: TTaskProcObj); overload;
    procedure Start(const ATaskProc: TTaskProcRef); overload;

    property Config: TTaskConfig read FTaskConfig write FTaskConfig;
    property Status: TTaskStatus read FTaskStatus write FTaskStatus;
  end;

  function FTaskDialogProgress: TTaskDialogProgress;
  function FindDisabledDlgControl(hWindow: HWND; _param: LPARAM): BOOL; stdcall;

implementation

var
  FTaskDialogProgressSingleton: TTaskDialogProgress = nil;

function FTaskDialogProgress: TTaskDialogProgress;
begin
  if (FTaskDialogProgressSingleton = nil) then
    FTaskDialogProgressSingleton := TTaskDialogProgress.Create;
  Result := FTaskDialogProgressSingleton;
end;

function FindDisabledDlgControl(hWindow: HWND; _param: LPARAM): BOOL; stdcall;
type
  PHWND = ^HWND;
begin
  if (not IsWindowEnabled(hWindow)) then
  begin
    PHWND(_param)^ := hWindow;
    Result := False;
  end
  else
    Result := True;
end;

{ TTaskDialogProgress }

procedure TTaskDialogProgress.ChangeProgressState(const AState: TProgressBarState);
begin
  FTaskDialog.ProgressBar.State := AState;

  case AState of
    TProgressBarState.pbsNormal : FTaskDialog.MainIcon := tdiInformation;
    TProgressBarState.pbsError  : FTaskDialog.MainIcon := tdiError;
    TProgressBarState.pbsPaused : FTaskDialog.MainIcon := tdiWarning;
  end;

  if (AState in [TProgressBarState.pbsError, TProgressBarState.pbsPaused]) then
  begin //hack
    FTaskDialog.Flags := FTaskDialog.Flags - [tfShowMarqueeProgressBar];
    FTaskDialog.ProgressBar.Initialize;

    FTaskDialog.ProgressBar.Position := FTaskDialog.ProgressBar.Max;
    FTaskDialog.ProgressBar.Position := FTaskDialog.ProgressBar.Max;
    FTaskDialog.ProgressBar.Position := FTaskDialog.ProgressBar.Max + 1;
    FTaskStatus.FCurrentProgress := FTaskDialog.ProgressBar.Position;
  end;
end;

constructor TTaskDialogProgress.Create;
begin
  FTaskConfig                    := TTaskConfig.Create;
  FTaskStatus                    := TTaskStatus.Create;
  FTaskStatus.FTimerUnlockButton := TStopwatch.Create();

  FTaskDialog := TCustomTaskDialog.Create(nil);
  FTaskDialog.CommonButtons            := [tcbClose];
  FTaskDialog.DefaultButton            := tcbClose;
  FTaskDialog.FooterIcon               := tdiWarning;
  FTaskDialog.OnButtonClicked          := OnTaskClick;
  FTaskDialog.OnDialogConstructed      := OnDialogConstructed;
  FTaskDialog.ProgressBar.MarqueeSpeed := 50;
end;

destructor TTaskDialogProgress.Destroy;
begin
  FTaskConfig.Free;
  FTaskStatus.Free;
  FTaskDialog.Free;

  inherited;
end;

procedure TTaskDialogProgress.DoHandleException;
begin
  if (Assigned(FException)) then
  begin
    try
      if (FException is Exception) then
        raise FException at ReturnAddress;
    finally
      FException := nil;
      ReleaseExceptionObject;
    end;
  end;
end;

procedure TTaskDialogProgress.HandleException;
begin
  FException := Exception(AcquireExceptionObject);
end;

procedure TTaskDialogProgress.OnDialogConstructed(ASender: TObject);
begin
  SendMessage(FTaskDialog.Handle, TDM_ENABLE_BUTTON, IDCLOSE, LPARAM(False));

  FHWNDButton := 0;
  EnumChildWindows(FTaskDialog.Handle, @FindDisabledDlgControl, LPARAM(@FHWNDButton));

  if (FHWNDButton <> 0) then
    SendMessage(FHWNDButton, WM_SETTEXT, 0, LPARAM(PChar('&Cancelar')));

  if (FTaskConfig.UserCanAbort) then
    SendMessage(FTaskDialog.Handle, TDM_ENABLE_BUTTON, IDCLOSE, LPARAM(True));
end;

procedure TTaskDialogProgress.OnTaskClick(Sender: TObject; ModalResult: TModalResult; var CanClose: Boolean);
begin
  CanClose := FTaskEnded;
  if FTaskConfig.LockButtons then
    Exit;

  if (not FTaskEnded) then
  begin
    FTaskStatus.FUserRequestAbort := True;

    SendMessage(FTaskDialog.Handle, TDM_ENABLE_BUTTON, IDCLOSE, LPARAM(False));
    if (FHWNDButton <> 0) then
      SendMessage(FHWNDButton, WM_SETTEXT, 0, LPARAM(PChar('&Cancelando')));

    ChangeProgressState(TProgressBarState.pbsPaused);
  end;
end;

procedure TTaskDialogProgress.OnTaskTimer(ASender: TObject; ATickCount: Cardinal; var AReset: Boolean);
var
  LTaskEnded: Boolean;
  LThreadStarted: Boolean;
begin
  //variáveis que podem sofrer alteração pela TThread enquando executa esse procedimento
  LThreadStarted := FThread.Started;
  LTaskEnded := FTaskEnded;

  //Necessário para criar uma caixa de diálogo maior e evitar o clipping da tela
  //Remarks em: https://msdn.microsoft.com/en-us/library/windows/desktop/bb760536(v=vs.85).aspx
  FTaskDialog.Title := FTaskStatus.Message;

  if (FTaskStatus.FCurrentProgress > 1) then
  begin
    if (tfShowMarqueeProgressBar in FTaskDialog.Flags) then
    begin
        FTaskDialog.Flags := FTaskDialog.Flags - [tfShowMarqueeProgressBar];
      FTaskDialog.ProgressBar.Initialize;
    end;
  end
  else
  begin
    if (not (tfShowMarqueeProgressBar in FTaskDialog.Flags)) then
    begin
      FTaskDialog.Flags := FTaskDialog.Flags + [tfShowMarqueeProgressBar];
      FTaskDialog.ProgressBar.Initialize;
    end;
  end;


  if (FTaskStatus.FCurrentProgress <> FTaskDialog.ProgressBar.Position) then
    FTaskDialog.ProgressBar.Position := FTaskStatus.FCurrentProgress;

  if (LTaskEnded) then
  begin
    FTaskDialog.OnTimer := nil;

    if (FHWNDButton <> 0) then
      SendMessage(FHWNDButton, WM_SETTEXT, 0, LPARAM(PChar('&Fechar')));

    SendMessage(FTaskDialog.Handle, TDM_ENABLE_BUTTON, IDCLOSE, LPARAM(True));

    FTaskDialog.Flags := FTaskDialog.Flags - [tfShowMarqueeProgressBar];
    FTaskDialog.ProgressBar.Initialize;
    FTaskDialog.ProgressBar.Position := FTaskDialog.ProgressBar.Max;

    if (FTaskConfig.AutoClose) then
    begin
      Application.ProcessMessages;
      if (Assigned(FException)) then
        TThread.Sleep(1000);

      SendMessage(FTaskDialog.Handle, TDM_CLICK_BUTTON, IDCLOSE, 0);
    end;
  end
  else if (not LThreadStarted) then
    FThread.Start;
end;

procedure TTaskDialogProgress.OnTerminateTask(Sender: TObject);
begin
  if ((Assigned(FException)) and (not FTaskStatus.UserRequestAbort)) then
    ChangeProgressState(TProgressBarState.pbsError);

  if (Assigned(FException)) then
    FTaskStatus.SetMessage(FException.Message);
end;

procedure TTaskDialogProgress.Reset;
begin
  if ((not FThread.Finished) and (FTaskStatus.UserRequestAbort)) then
  begin
    FThread.FreeOnTerminate := False;
    FThread.Free;
  end;

  FTaskConfig.Reset;
  FTaskStatus.Reset;
  FTaskEnded := False;
end;

procedure TTaskDialogProgress.ShowTaskDialog;
begin
  FTaskDialog.Caption              := FTaskConfig.Caption;
  FTaskDialog.Flags                := [tfCallbackTimer, tfShowProgressBar, tfShowMarqueeProgressBar];
  FTaskDialog.MainIcon             := tdiInformation;
  FTaskDialog.OnTimer              := OnTaskTimer;
  FTaskDialog.ProgressBar.Position := 0;
  FTaskDialog.ProgressBar.State    := TProgressBarState.pbsNormal;
  FTaskDialog.Title                := FTaskStatus.Message;

  if (FTaskConfig.LockButtons) then
    FTaskStatus.FTimerUnlockButton.StartNew;

  FTaskDialog.Execute;
end;

procedure TTaskDialogProgress.Start(const ATaskProc: TTaskProcObj);
begin
  Start(
    procedure(const ATaskStatus: TTaskStatus)
    begin
      ATaskProc;
    end);
end;

procedure TTaskDialogProgress.Start(const ATaskProc: TTaskProcRef);
begin
  FThread := TThread.CreateAnonymousThread(
  procedure
  begin
    try
      try
        ATaskProc(FTaskStatus);
      except
        HandleException;
      end;
    finally
      FTaskEnded := True;
    end
  end);

  FThread.Priority := tpLowest;
  FThread.OnTerminate := OnTerminateTask;

  ShowTaskDialog;

  Reset;

  DoHandleException;
end;

{ TTaskStatus }

constructor TTaskStatus.Create;
begin
  FLabel := TLabel.Create(nil);
  FLabel.Font.Size := 12;
  FLabel.Font.Name := 'Segoe UI';
  FLabel.Constraints.MaxWidth := CWIDTH_LINE;
  FLabel.Constraints.MinWidth := CWIDTH_LINE;
  FLabel.AutoSize := True;
  FLabel.WordWrap := True;

  Reset;
end;

destructor TTaskStatus.Destroy;
begin
  FLabel.Free;
  inherited;
end;

procedure TTaskStatus.Reset;
begin
  FCurrentProgress := 0;
  SetMessage(''); //'Aguarde enquanto a tarefa é executada...';
  FUserRequestAbort := False;
  FTimeToClose := CTIME_TO_CLOSE;
  FTimerUnlockButton.Reset;
end;

procedure TTaskStatus.ExecuteWaitToCLose;
  function GetPosition: Integer;
  var
    Coef: Integer;
  begin
    FTimerUnlockButton.Stop;
    try
      Coef  := Trunc(100 / CTIME_TO_CLOSE);
      FTimeSpan := FTimerUnlockButton.Elapsed;
      result    := Round(FTimeSpan.TotalSeconds) * Coef;
      Result    := Trunc(Result);
    finally
      FTimerUnlockButton.Start;
    end;
  end;
begin
  while FCurrentProgress < 100  do
  begin
    SetProgress(GetPosition, 100);
    sleep(50);
  end;
  sleep(100);
end;

procedure TTaskStatus.ExecuteWaitToClose2;
begin
  sleep(1000);
  SetProgress(16, 100);
  sleep(1000);
  SetProgress(33, 100);
  sleep(1000);
  SetProgress(50, 100);
  sleep(1000);
  SetProgress(66, 100);
  sleep(1000);
  SetProgress(82, 100);
  sleep(1000);
  SetProgress(100, 100);
  sleep(200);
end;

procedure TTaskStatus.SetMessage(const AMessage: String);
var
  LExceedMessage: Boolean;
begin
  FLabel.Caption := AMessage;

  LExceedMessage := (FLabel.Height > (CHEIGHT_LINE * 3));

  while (FLabel.Height <= (CHEIGHT_LINE * 3)) do //Ajusta texto para 3 Linhas
    FLabel.Caption := FLabel.Caption + ' ';

  while (FLabel.Height > (CHEIGHT_LINE * 3)) do //Ajusta texto para 3 Linhas
    FLabel.Caption := String(FLabel.Caption).Remove(String(FLabel.Caption).Length - 1, 1);

  if (LExceedMessage) then
    FLabel.Caption := String(FLabel.Caption).Remove(String(FLabel.Caption).Length - 3) + '...';

  FMessage := FLabel.Caption;
end;

procedure TTaskStatus.SetMessageFmt(const AMessage: String; const Args: array of const);
begin
  SetMessage(Format(AMessage, Args));
end;

procedure TTaskStatus.SetProgress(const APosition, ATotal: Integer);
begin
  FCurrentProgress := Trunc((APosition * 100) / ATotal);
end;

{ TTaskConfig }

constructor TTaskConfig.Create;
begin
  Reset;
end;

procedure TTaskConfig.Reset;
begin
  FAutoClose    := True;
  FCaption      := 'Aguarde';
  FUserCanAbort := False;
  FLockButtons  := False;
end;

initialization

finalization
  if (FTaskDialogProgressSingleton <> nil) then
    FTaskDialogProgressSingleton.Free;

end.
