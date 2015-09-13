program prjSQLite;

uses
  System.StartUpCopy,
  FMX.Forms,
  uFrmPrincipal in 'uFrmPrincipal.pas' {FrmPrincipal},
  uDmConexao in 'uDmConexao.pas' {DM_Conexao: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM_Conexao, DM_Conexao);
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
