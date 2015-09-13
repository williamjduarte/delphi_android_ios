object DM_Conexao: TDM_Conexao
  OldCreateOrder = False
  Height = 185
  Width = 254
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\WILLIAM\Desktop\Livro William\exemplos\Capitul' +
        'o_14\sqlite\capitulo13.s3db'
      'LockingMode=Normal'
      'DriverID=SQLite')
    LoginPrompt = False
    AfterConnect = FDConnection1AfterConnect
    BeforeConnect = FDConnection1BeforeConnect
    Left = 152
    Top = 16
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 56
    Top = 72
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 176
    Top = 128
  end
end
