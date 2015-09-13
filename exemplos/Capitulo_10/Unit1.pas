unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Sensors,
  FMX.StdCtrls, FMX.Layouts, FMX.ListBox;

type
  TForm1 = class(TForm)
    ListBox1: TListBox;
    Label1: TLabel;
    Button1: TButton;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    FSensorAtivo : TCustomSensor;
    FShowInfo : Boolean;
  public
    { Public declarations }
    function GetSensorCategoryName(ASensorCategory: TSensorCategory): string;
    function GetFullInfo(ACategory, AType, AClass, AAvailibleProperties: string): string;
    function GetTypeNameLight(AType: TLightSensorType): string;
    function GetTypeNameOrientation(AType: TOrientationSensorType): string;
    function GetTypeNameMotion(AType: TMotionSensorType): string;
    function GetSensorType(ASensor: TCustomSensor): string;
    procedure ListBoxItemClick(Sender: TObject);
    function GetInfoAboutLight(ASensor: TCustomSensor): string;
    function GetInfoAboutOrientation(ASensor: TCustomSensor): string;
    function GetInfoAboutMotion(ASensor: TCustomSensor): string;

    function ToFormStr(AProp : string; AVal : Single): string;
    function ToFormStrS(AProp : string; AVal : string): string;
    function ToFormStrB(AProp : string; AVal : Boolean): string;

  end;

var
  Form1: TForm1;

Const
  AllCat : TSensorCategories =
  [TSensorCategory.Location, TSensorCategory.Environmental, TSensorCategory.Motion,
  TSensorCategory.Orientation, TSensorCategory.Mechanical, TSensorCategory.Electrical,
  TSensorCategory.Biometric, TSensorCategory.Light, TSensorCategory.Scanner];
  cForm = '  %s =' + sLineBreak + '%30s        %3.5f ' + sLineBreak;
  cFormS = '  %s =' + sLineBreak + '%30s        %s ' + sLineBreak;

implementation

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.NmXhdpiPh.fmx ANDROID}

function TForm1.GetSensorCategoryName(ASensorCategory: TSensorCategory): string;
begin
  Result := 'Nao definido' ;
  case ASensorCategory of
    TSensorCategory.Location: Result := 'Location' ;
    TSensorCategory.Environmental: Result := 'Environmental' ;
    TSensorCategory.Motion: Result := 'Motion' ;
    TSensorCategory.Orientation: Result := 'Orientation' ;
    TSensorCategory.Mechanical: Result := 'Mechanical' ;
    TSensorCategory.Electrical: Result := 'Electrical' ;
    TSensorCategory.Biometric: Result := 'Biometric' ;
    TSensorCategory.Light: Result := 'Light' ;
    TSensorCategory.Scanner: Result := 'Scanner' ;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  FShowINfo := False;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  LSensorCat : TSensorCategory ; //Categoria dos sensores
  LHeader : TListBoxGroupHeader; //Objeto Header (cabeçalho) do seu ListBox
  LSensorArray : TSensorArray; //Vetor contendo todos os sensores
  LSensor : TCustomSensor; //Sensor especifico.
  LItem : TListBoxItem; //Item do ListBox
begin
  FSensorAtivo := nil; //Declarado no item 2)
  FShowInfo := False; //Declarado no Item 2)

  //Ativa os sensores
  TSensorManager.Current.Activate();
  for LSensorCat in AllCat do
   begin
    //Cria um cabeçalho para o ListBox
    LSensorArray := TSensorManager.Current.GetSensorsByCategory(LSensorCat);
    LHeader := TListBoxGroupHeader.Create(Owner);
    LHeader.Parent := ListBox1;
    LHeader.Text := GetSensorCategoryName(LSensorCat);
    LHeader.Height := LHeader.Height * 2;
    for LSensor in LSensorArray do
      begin
        LItem := TListBoxItem.Create(Owner);
        LItem.Parent := ListBox1;
        LItem.Text := GetSensorType(LSensor);
        LItem.ItemData.Accessory := TListBoxItemData.TAccessory.aDetail;
        LItem.Height := LItem.Height * 2;
        LItem.Font.Size := LItem.Font.Size * 2;
        LItem.Data := LSensor;
        LItem.OnClick := ListBoxItemClick;
      end;
  End;
End;

function TForm1.GetFullInfo(ACategory, AType, AClass,
  AAvailibleProperties: string): string;
begin
  Result := sLineBreak + 'Category:' + sLineBreak
    + '  ' + ACategory + sLineBreak + sLineBreak
    + 'Sensor type:' + sLineBreak
    + '  ' + AType + sLineBreak + sLineBreak
    + 'Base class:' + sLineBreak
    + '  ' + AClass + sLineBreak + sLineBreak
    + 'Available properties:' + sLineBreak
    + AAvailibleProperties;
end;


function TForm1.GetTypeNameLight(AType: TLightSensorType): string;
begin
  Result := 'Nao definido';
  case AType of
    TLightSensorType.AmbientLight: Result := 'AmbientLight' ;
  end;
end;

function TForm1.GetTypeNameOrientation(
  AType: TOrientationSensorType): string;
begin
  case AType of
    TOrientationSensorType.Compass1D: Result := 'Compass1D';
    TOrientationSensorType.Compass2D: Result := 'Compass2D';
    TOrientationSensorType.Compass3D: Result := 'Compass3D';
    TOrientationSensorType.Inclinometer1D: Result := 'Inclinometer1D';
    TOrientationSensorType.Inclinometer2D: Result := 'Inclinometer2D';
    TOrientationSensorType.Inclinometer3D: Result := 'Inclinometer3D';
    TOrientationSensorType.Distance1D: Result := 'Distance1D';
    TOrientationSensorType.Distance2D: Result := 'Distance2D';
    TOrientationSensorType.Distance3D: Result := 'Distance3D';
  else
    Result := 'Nao definido';
  end;
end;

function TForm1.GetTypeNameMotion(AType: TMotionSensorType): string;
begin
  case AType of
    TMotionSensorType.Accelerometer1D: Result := 'Accelerometer1D';
    TMotionSensorType.Accelerometer2D: Result := 'Accelerometer2D';
    TMotionSensorType.Accelerometer3D: Result := 'Accelerometer3D';
    TMotionSensorType.MotionDetector: Result := 'MotionDetector';
    TMotionSensorType.Gyrometer1D: Result := 'Gyrometer1D';
    TMotionSensorType.Gyrometer2D: Result := 'Gyrometer2D';
    TMotionSensorType.Gyrometer3D: Result := 'Gyrometer3D';
    TMotionSensorType.Speedometer: Result := 'Speedometer';
    TMotionSensorType.LinearAccelerometer3D: Result := 'LinearAccelerometer3D';
    TMotionSensorType.GravityAccelerometer3D: Result := 'GravityAccelerometer3D';
  else
    Result := 'Nao definido';
  end;
end;


function TForm1.GetSensorType(ASensor: TCustomSensor): string;
begin
  Result := 'Não definido';
  Case ASensor.Category of
    TSensorCategory.Motion: Result := GetTypeNameMotion(TCustomMotionSensor(ASensor).SensorType) ;
    TSensorCategory.Orientation: Result := GetTypeNameOrientation(TCustomOrientationSensor(ASensor).SensorType);
    TSensorCategory.Light: Result := GetTypeNameLight(TCustomLightSensor(ASensor).SensorType);
  End;
end;

procedure TForm1.ListBoxItemClick(Sender: TObject);
begin
  if Sender is TListBoxItem then
    FSensorAtivo := TCustomSensor(TListBoxItem(Sender).Data);
  FShowInfo := True;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  ResultText : string;
begin
  if Assigned(FSensorAtivo) then
  begin
    case FSensorAtivo.Category of
      TSensorCategory.Motion: ResultText := GetInfoAboutMotion(FSensorAtivo);
      TSensorCategory.Light: ResultText := GetInfoAboutLight(FSensorAtivo);
      TSensorCategory.Orientation: ResultText := GetInfoAboutOrientation(FSensorAtivo);
    end;
    Label1.Text := ResultText;
  end;

  if not FShowInfo then
  begin
    Label1.Visible := False;
    ListBox1.Visible := True;
  end
  else
    begin
      Label1.Visible := True;
      ListBox1.Visible := False;
    end;

end;

function TForm1.ToFormStr(AProp: string; AVal: Single): string;
begin
  Result := Format(cForm,[AProp,'', AVal]);
end;

function TForm1.ToFormStrB(AProp: string; AVal: Boolean): string;
begin
 if AVal then
    ToFormStrS(AProp,'True')
  else
    ToFormStrS(AProp, 'False');
end;

function TForm1.ToFormStrS(AProp, AVal: string): string;
begin
 Result := Format(cFormS,[AProp,'', AVal]);
end;

function TForm1.GetInfoAboutLight(ASensor: TCustomSensor): string;
var
  ls : TCustomLightSensor;
  LValues : string;
  LProp : TCustomLightSensor.TProperty;
begin
  LValues := '';
  ls := TCustomLightSensor(ASensor);
  for LProp in ls.AvailableProperties do
  begin
    case LProp of
      TCustomLightSensor.TProperty.Lux:
        LValues := LValues + ToFormStr('Lux', ls.Lux);
      TCustomLightSensor.TProperty.Temperature:
        LValues := LValues + ToFormStr('Temperature', ls.Temperature);
      TCustomLightSensor.TProperty.Chromacity:
        LValues := LValues + ToFormStr('Chromacity', ls.Chromacity);
    end;
  end;
  Result := GetFullInfo(
    GetSensorCategoryName(ASensor.Category),GetTypeNameLight(ls.SensorType),
    ls.ClassName,LValues) ;
end;

function TForm1.GetInfoAboutOrientation(
  ASensor: TCustomSensor): string;
var
  ls : TCustomOrientationSensor;
  LValues : string;
  LProp : TCustomOrientationSensor.TProperty;
begin
  LValues := '';
  ls := TCustomOrientationSensor(ASensor);
  if not ls.Started then
    ls.Start;
  for LProp in ls.AvailableProperties do
  begin
    case LProp of
      TCustomOrientationSensor.TProperty.TiltX:
        LValues := LValues + ToFormStr('TiltX', ls.TiltX);
      TCustomOrientationSensor.TProperty.TiltY:
        LValues := LValues + ToFormStr('TiltY', ls.TiltY);
      TCustomOrientationSensor.TProperty.TiltZ:
        LValues := LValues + ToFormStr('TiltZ', ls.TiltZ);
      TCustomOrientationSensor.TProperty.DistanceX:
        LValues := LValues + ToFormStr('DistanceX', ls.DistanceX);
      TCustomOrientationSensor.TProperty.DistanceY:
        LValues := LValues + ToFormStr('DistanceY', ls.DistanceY);
      TCustomOrientationSensor.TProperty.DistanceZ:
        LValues := LValues + ToFormStr('DistanceZ', ls.DistanceZ);
      TCustomOrientationSensor.TProperty.HeadingX:
        LValues := LValues + ToFormStr('HeadingX', ls.HeadingX);
      TCustomOrientationSensor.TProperty.HeadingY:
        LValues := LValues + ToFormStr('HeadingY', ls.HeadingY);
      TCustomOrientationSensor.TProperty.HeadingZ:
        LValues := LValues + ToFormStr('HeadingZ', ls.HeadingZ);
      TCustomOrientationSensor.TProperty.MagHeading:
        LValues := LValues + ToFormStr('MagHeading', ls.MagHeading);
      TCustomOrientationSensor.TProperty.TrueHeading:
        LValues := LValues + ToFormStr('TrueHeading', ls.TrueHeading);
      TCustomOrientationSensor.TProperty.CompMagHeading:
        LValues := LValues + ToFormStr('CompMagHeading', ls.CompMagHeading);
      TCustomOrientationSensor.TProperty.CompTrueHeading:
        LValues := LValues + ToFormStr('CompTrueHeading', ls.CompTrueHeading);
    end;
  end;
  Result := GetFullInfo(
    GetSensorCategoryName(ASensor.Category),
    GetTypeNameOrientation(ls.SensorType),
    ls.ClassName,
    LValues
  ) ;
end;

function TForm1.GetInfoAboutMotion(ASensor: TCustomSensor): string;
var
  ls : TCustomMotionSensor;
  LValues : string;
  LProp : TCustomMotionSensor.TProperty;
begin
  LValues := '';
  ls := TCustomMotionSensor(ASensor);
  if not ls.Started then
    ls.Start;
  for LProp in ls.AvailableProperties do
  begin
    case LProp of
      TCustomMotionSensor.TProperty.AccelerationX:
        LValues := LValues + ToFormStr('AccelerationX', ls.AccelerationX);
      TCustomMotionSensor.TProperty.AccelerationY:
        LValues := LValues + ToFormStr('AccelerationY', ls.AccelerationY);
      TCustomMotionSensor.TProperty.AccelerationZ:
        LValues := LValues + ToFormStr('AccelerationZ', ls.AccelerationZ);
      TCustomMotionSensor.TProperty.AngleAccelX:
        LValues := LValues + ToFormStr('AngleAccelX', ls.AngleAccelX);
      TCustomMotionSensor.TProperty.AngleAccelY:
        LValues := LValues + ToFormStr('AngleAccelY', ls.AngleAccelY);
      TCustomMotionSensor.TProperty.AngleAccelZ:
        LValues := LValues + ToFormStr('AngleAccelZ', ls.AngleAccelZ);
      TCustomMotionSensor.TProperty.Motion:
        LValues := LValues + ToFormStr('Motion', ls.Motion);
      TCustomMotionSensor.TProperty.Speed:
        LValues := LValues + ToFormStr('Speed', ls.Speed);
    end;
  end;
  Result := GetFullInfo(
    GetSensorCategoryName(ASensor.Category),
    GetTypeNameMotion(ls.SensorType),
    ls.ClassName,
    LValues
  ) ;
end;


end.
