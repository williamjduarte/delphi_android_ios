unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Sensors,
  System.Sensors.Components, FMX.StdCtrls, FMX.WebBrowser;

type
  TForm1 = class(TForm)
    ToolBar1: TToolBar;
    Switch1: TSwitch;
    WebBrowser1: TWebBrowser;
    btnEndereco: TButton;
    LocationSensor1: TLocationSensor;
    procedure Switch1Switch(Sender: TObject);
    procedure LocationSensor1LocationChanged(Sender: TObject; const OldLocation,
      NewLocation: TLocationCoord2D);
    procedure btnEnderecoClick(Sender: TObject);
  private
    { Private declarations }
    FGeocoder : TGeocoder;
    FEndereco : string;
    procedure OnGeocodeReverseEvent(const Address: TCivicAddress);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}
{$R *.NmXhdpiPh.fmx ANDROID}
{$R *.SmXhdpiPh.fmx ANDROID}

procedure TForm1.btnEnderecoClick(Sender: TObject);
begin
  ShowMessage(FEndereco);
end;

procedure TForm1.LocationSensor1LocationChanged(Sender: TObject;
  const OldLocation, NewLocation: TLocationCoord2D);
var
  LDecSeparator: String;
  URLString: String;
begin
  LDecSeparator := FormatSettings.DecimalSeparator;
  FormatSettings.DecimalSeparator := '.';
  URLString := Format(
    'https://maps.google.com/maps?q=%s,%s',
      [Format('%2.6f', [NewLocation.Latitude]), Format('%2.6f', [NewLocation.Longitude])]);
  WebBrowser1.Navigate(URLString);

  try

    if not Assigned(FGeocoder) then
    begin
      if Assigned(TGeocoder.Current) then
        FGeocoder := TGeocoder.Current.Create;
      if Assigned(FGeocoder) then
        FGeocoder.OnGeocodeReverse := OnGeocodeReverseEvent;
    end;

    if Assigned(FGeocoder) and not FGeocoder.Geocoding then
      FGeocoder.GeocodeReverse(NewLocation);
  except
    FEndereco := 'Geocoder error';
  end;

end;

procedure TForm1.OnGeocodeReverseEvent(const Address: TCivicAddress);
begin
   FEndereco := Address.AdminArea + ' '  +
    Address.CountryCode + ' ' +
    Address.CountryName + ' ' +
    Address.FeatureName + ' ' +
    Address.Locality + ' ' +
    Address.PostalCode + ' ' +
    Address.SubAdminArea + ' ' +
    Address.SubLocality + ' ' +
    Address.SubThoroughfare + ' ' +
    Address.Thoroughfare;
end;

procedure TForm1.Switch1Switch(Sender: TObject);
begin
  LocationSensor1.Active := Switch1.IsChecked;
end;

end.
