unit uFrmPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls;

type
  TForm1 = class(TForm)
    btnWIFI: TButton;
    procedure btnWIFIClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses
  utNetwork, MACAPI.Objectivec;

procedure TForm1.btnWIFIClick(Sender: TObject);
var
  MobileNetWork : TMobileNetworkStatus;
begin
  Try
    MobileNetWork := TMobileNetworkStatus.Create;
    if MobileNetWork.IsWiFiConnected then
      ShowMessage('WI-FI LIGADO!')
    else
      ShowMessage('WI-FI DESLIGADO!');

  Finally
    FreeAndNil(MobileNetWork);
  End;
end;

end.
