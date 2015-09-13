unit uFrmPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Advertising,
  FMX.Objects, FMX.StdCtrls;

type
  TForm1 = class(TForm)
    BannerAd1: TBannerAd;
    ToolBar1: TToolBar;
    lblAds: TLabel;
    Image1: TImage;
    Button1: TButton;
    procedure FormShow(Sender: TObject);
    procedure BannerAd1DidFail(Sender: TObject; const Error: string);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    sErro : String;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.BannerAd1DidFail(Sender: TObject; const Error: string);
begin
  sErro := Error;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  ShowMessage(sErro);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  BannerAd1.AdUnitID := 'ca-app-pub-xxxxxxxxxxx1234567890';
  BannerAd1.LoadAd;
end;

end.
