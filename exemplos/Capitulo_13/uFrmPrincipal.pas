unit uFrmPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView, FMX.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Data.Bind.DBScope;

type
  TFrmPrincipal = class(TForm)
    ToolBar1: TToolBar;
    btnInsert: TButton;
    btnexcluir: TButton;
    Label1: TLabel;
    ListView1: TListView;
    BindSourceDB1: TBindSourceDB;
    FDQuery1: TFDQuery;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    qryInsert: TFDQuery;
    QryExcluir: TFDQuery;
    procedure ListView1ItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure btnInsertClick(Sender: TObject);
    procedure btnexcluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure OnInputQuery_Close(const AResult: TModalResult; const AValues: array of string);
    procedure OnIdle(Sender: TObject; var FDone: Boolean);
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}
{$R *.iPhone4in.fmx IOS}
{$R *.iPhone.fmx IOS}
{$R *.SmXhdpiPh.fmx ANDROID}

uses
  uDMConexao;

procedure TFrmPrincipal.btnexcluirClick(Sender: TObject);
var
  Nome: String;
begin
  Nome := ListView1.Selected.Text;
  try
    qryExcluir.ParamByName('ShopItem').AsString := Nome;
    qryExcluir.ExecSQL();
    FDQuery1.Close;
    FDQuery1.Open;
    LinkFillControlToField1.BindList.FillList;
    btnexcluir.Visible := ListView1.Selected <> nil;
  except
    on e: Exception do
      begin
        SHowMessage(e.Message);
      end;
  end;
end;

procedure TFrmPrincipal.btnInsertClick(Sender: TObject);
var
  Values: array[0 .. 0] of String;
begin
  Values[0] := String.Empty;
  InputQuery('Entre com o nome', ['Nome'], Values, Self.OnInputQuery_Close);
  LinkFillControlToField1.BindList.FillList;
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  try
    // For unidirectional dataset, don't refill automatically when dataset is activated
    // because dataset is reactivated everytime use DataSet.First.
    LinkFillControlToField1.AutoActivate := False;
    LinkFillControlToField1.AutoFill := False;
    Application.OnIdle := OnIdle;
    DM_Conexao.FDConnection1.Connected := True;
    FDQuery1.Active := True;
    LinkFillControlToField1.BindList.FillList;
  except
    on e: Exception do
    begin
      SHowMessage(e.Message);
    end;
  end;
end;

procedure TFrmPrincipal.ListView1ItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  btnexcluir.Visible := ListView1.Selected <> nil;
end;

procedure TFrmPrincipal.OnIdle(Sender: TObject; var FDone: Boolean);
begin
  btnexcluir.Visible := ListView1.Selected <> nil;
end;

procedure TFrmPrincipal.OnInputQuery_Close(const AResult: TModalResult;
  const AValues: array of string);
var
  NomeDoProduto: String;
begin
  NomeDoProduto := string.Empty;
    if AResult <> mrOk then
      Exit;
  NomeDoProduto := AValues[0];
  try
    if (NomeDoProduto.Trim <> '')
    then
      begin
        qryInsert.ParamByName('ShopItem').AsString := NomeDoProduto;
        qryInsert.ExecSQL();
        FDQuery1.Close();
        FDQuery1.Open;
        btnexcluir.Visible := ListView1.Selected <> nil;
      end;
  except
    on e: Exception do
      begin
        ShowMessage(e.Message);
      end;
  end;
end;

end.
