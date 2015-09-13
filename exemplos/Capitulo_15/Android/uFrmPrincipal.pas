unit uFrmPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, utNetwork,
  FMX.StdCtrls;

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

procedure TForm1.btnWIFIClick(Sender: TObject);
begin
 if IsWiFiConnected then
  ShowMessage('WI-FI LIGADO!')
 else
  ShowMessage('WI-FI DESLIGADO!');
end;

end.
