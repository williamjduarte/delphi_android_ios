program prjLinguagemNativa;

uses
  System.StartUpCopy,
  FMX.Forms,
  uFrmPrincipal in 'uFrmPrincipal.pas' {Form1},
  utNetwork in 'utNetwork.pas',
  Androidapi.JNI.Toast in 'Androidapi.JNI.Toast.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
