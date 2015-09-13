unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListBox,
  FMX.Layouts, FMX.StdCtrls, FMX.MultiView, FMX.WebBrowser,
  FMX.Controls.Presentation, FMX.Edit;

type
  TForm1 = class(TForm)
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    Layout1: TLayout;
    Edit1: TEdit;
    WebBrowser1: TWebBrowser;
    procedure SpeedButton1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
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

procedure TForm1.Edit1Change(Sender: TObject);
begin
  WebBrowser1.Navigate(Edit1.Text);
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  WebBrowser1.GoBack;
end;

end.
