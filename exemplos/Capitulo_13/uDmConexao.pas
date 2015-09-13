unit uDmConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, Data.DB,
  FireDAC.Comp.Client, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait, FireDAC.Comp.UI;

type
  TDM_Conexao = class(TDataModule)
    FDConnection1: TFDConnection;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    procedure FDConnection1BeforeConnect(Sender: TObject);
    procedure FDConnection1AfterConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM_Conexao: TDM_Conexao;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
uses
  System.IOUtils;

{$R *.dfm}

procedure TDM_Conexao.FDConnection1AfterConnect(Sender: TObject);
begin
  FDConnection1.ExecSQL ('CREATE TABLE IF NOT EXISTS Item (ShopItem TEXT NOT NULL)');
end;

procedure TDM_Conexao.FDConnection1BeforeConnect(Sender: TObject);
begin
  {$IF DEFINED(IOS) or DEFINED(ANDROID)}
  FDConnection1.Params.Values['Database'] :=
    TPath.GetDocumentsPath + PathDelim + 'capitulo13.s3db';
  {$ENDIF}
end;

end.
