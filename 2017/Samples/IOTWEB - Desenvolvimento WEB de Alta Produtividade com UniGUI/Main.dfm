object MainForm: TMainForm
  Left = 0
  Top = 0
  ClientHeight = 301
  ClientWidth = 528
  Caption = 'MainForm'
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  OnCreate = UniFormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object UniButton1: TUniButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Hint = ''
    Caption = 'Novo'
    TabOrder = 0
    ClientEvents.UniEvents.Strings = (
      
        'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'  config.base' +
        'Cls="btn";'#13#10'  config.cls="btn-success btn-md";'#13#10#13#10'}')
    OnClick = UniButton1Click
  end
  object UniButton2: TUniButton
    Left = 88
    Top = 8
    Width = 75
    Height = 25
    Hint = ''
    Caption = 'Editar'
    TabOrder = 1
    ClientEvents.UniEvents.Strings = (
      
        'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    config.ba' +
        'seCls="btn";'#13#10'  config.cls="btn-danger btn-md";'#13#10'}')
  end
  object UniButton3: TUniButton
    Left = 168
    Top = 8
    Width = 75
    Height = 25
    Hint = ''
    Caption = 'Salvar'
    TabOrder = 2
    ClientEvents.UniEvents.Strings = (
      
        'beforeInit=function beforeInit(sender, config)'#13#10'{'#13#10'    config.ba' +
        'seCls="btn";'#13#10'  config.cls="btn-primary btn-md";'#13#10'}')
  end
  object UniButton4: TUniButton
    Left = 248
    Top = 8
    Width = 75
    Height = 25
    Hint = ''
    Caption = 'Cancelar'
    TabOrder = 3
  end
  object UniButton5: TUniButton
    Left = 336
    Top = 8
    Width = 75
    Height = 25
    Hint = ''
    Caption = 'Excluir'
    TabOrder = 4
  end
  object UniDBEdit1: TUniDBEdit
    Left = 8
    Top = 100
    Width = 121
    Height = 22
    Hint = ''
    DataField = 'CODIGO'
    DataSource = DM.DataSource1
    TabOrder = 5
  end
  object UniDBEdit2: TUniDBEdit
    Left = 144
    Top = 100
    Width = 121
    Height = 22
    Hint = ''
    DataField = 'apelido'
    DataSource = DM.DataSource1
    TabOrder = 6
  end
  object UniDBEdit3: TUniDBEdit
    Left = 280
    Top = 100
    Width = 240
    Height = 22
    Hint = ''
    DataField = 'razaosocial'
    DataSource = DM.DataSource1
    TabOrder = 7
  end
  object UniDBGrid1: TUniDBGrid
    Left = 0
    Top = 136
    Width = 528
    Height = 165
    Hint = ''
    DataSource = DM.DataSource1
    LoadMask.Message = 'Loading data...'
    Align = alBottom
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 8
    OnCellClick = UniDBGrid1CellClick
    Columns = <
      item
        FieldName = 'CODIGO'
        Title.Caption = 'CODIGO'
        Width = 64
      end
      item
        FieldName = 'apelido'
        Title.Caption = 'apelido'
        Width = 184
      end
      item
        FieldName = 'razaosocial'
        Title.Caption = 'razaosocial'
        Width = 100
      end
      item
        FieldName = 'IMPRIMIR'
        Title.Caption = 'IMPRIMIR'
        Width = 604
      end>
  end
  object UniLabel1: TUniLabel
    Left = 8
    Top = 81
    Width = 33
    Height = 13
    Hint = ''
    Caption = 'Codigo'
    TabOrder = 9
  end
  object UniLabel2: TUniLabel
    Left = 144
    Top = 81
    Width = 35
    Height = 13
    Hint = ''
    Caption = 'Apelido'
    TabOrder = 10
  end
  object UniLabel3: TUniLabel
    Left = 280
    Top = 81
    Width = 60
    Height = 13
    Hint = ''
    Caption = 'Razao Social'
    TabOrder = 11
  end
end
