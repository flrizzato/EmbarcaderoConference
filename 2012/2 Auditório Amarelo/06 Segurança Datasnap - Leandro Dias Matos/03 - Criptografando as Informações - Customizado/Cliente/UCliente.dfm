object FrmClienteFiltro: TFrmClienteFiltro
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Seguran'#231'a no DataSnap com Delphi XE3 - Usando Filtro Customizado'
  ClientHeight = 55
  ClientWidth = 512
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object grpClient: TGroupBox
    Left = 0
    Top = 0
    Width = 512
    Height = 55
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 98
      Height = 13
      Caption = 'Hora do Servidor:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtHora: TEdit
      Left = 122
      Top = 21
      Width = 271
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object BitBtn1: TBitBtn
      Left = 399
      Top = 3
      Width = 75
      Height = 49
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300130000031
        00333773F77777FF7733331000909000133333377737F777FF33330098F0F890
        0333337733F733F77F33370980FFF08907333373373F373373F33099FFFFFFF9
        903337F3F373F33FF7F33090F000FF00903337F73337F37737F3B099FFF0FFF9
        90B3373F33F7F3F33733070980F0F0890703337FF737F7337F33BB0098F0F890
        0BB33F77FF3733377FFF000009999900000377777FFFFF77777F088700000008
        77037F3377777773337F088887707888870373F3337773F33373B078800B0088
        70B3373FF733373FF73303700BBBBB007303337773F3F3777F33330BB0B0B0BB
        033333733737F73F73F330BB03B0B30BB0333733733733733733}
      NumGlyphs = 2
      TabOrder = 1
      OnClick = BitBtn1Click
    end
  end
  object SQLCN: TSQLConnection
    DriverName = 'DataSnap'
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=Data.DBXDataSnap'
      'HostName=localhost'
      'Port=212'
      'CommunicationProtocol=tcp/ip'
      'DatasnapContext=datasnap/'
      
        'DriverAssemblyLoader=Borland.Data.TDBXClientDriverLoader,Borland' +
        '.Data.DbxClientDriver,Version=17.0.0.0,Culture=neutral,PublicKey' +
        'Token=91d62ebb5b0d1b1b'
      'Filters={}')
    Left = 224
    Top = 8
    UniqueId = '{D56F7754-4C02-470B-858F-F7A75B0BC962}'
  end
end
