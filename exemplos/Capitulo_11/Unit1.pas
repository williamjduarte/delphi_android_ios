unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Notification;

type
  TForm1 = class(TForm)
    NotificationCenter1: TNotificationCenter;
    btnNotifcaca: TButton;
    btnAgendada: TButton;
    procedure btnNotifcacaClick(Sender: TObject);
    procedure btnAgendadaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}
{$R *.NmXhdpiPh.fmx ANDROID}

procedure TForm1.btnAgendadaClick(Sender: TObject);
var
  MyNotification: TNotification;
begin
  MyNotification := NotificationCenter1.CreateNotification;
  try
    MyNotification.Name := 'LivroDelphiAgendado';
    MyNotification.AlertBody := 'Notificação Agendada!';

    MyNotification.FireDate := Now + EncodeTime(0, 0, 10, 0);

    NotificationCenter1.ScheduleNotification(MyNotification);
  finally
    MyNotification.DisposeOf;
  end;
end;

procedure TForm1.btnNotifcacaClick(Sender: TObject);
var
  MyNotification: TNotification;
begin
 MyNotification := NotificationCenter1.CreateNotification;
  try
    MyNotification.Name := 'LivroDelphi';
    MyNotification.AlertBody := 'William Duarte!';
    MyNotification.Number := 1;
    MyNotification.EnableSound := True;
    NotificationCenter1.PresentNotification(MyNotification);
  finally
    MyNotification.DisposeOf;
  end;
end;

end.
