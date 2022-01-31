program RestJsonSerializer;

uses
  Vcl.Forms,
  Form.Json.Serializer in 'Form.Json.Serializer.pas' {Form1},
  uPeople in 'model\uPeople.pas',
  ServiceRestJson in 'service\ServiceRestJson.pas',
  uAddress in 'model\uAddress.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
