object QueueServerForm: TQueueServerForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Queue Server'
  ClientHeight = 252
  ClientWidth = 482
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 19
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 482
    Height = 73
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    object edMessage: TLabeledEdit
      Left = 8
      Top = 30
      Width = 297
      Height = 27
      EditLabel.Width = 75
      EditLabel.Height = 19
      EditLabel.Caption = 'Mensagem'
      TabOrder = 0
    end
    object Button1: TButton
      Left = 311
      Top = 27
      Width = 82
      Height = 34
      Caption = 'Enviar'
      Default = True
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  object ListBox1: TListBox
    Left = 0
    Top = 73
    Width = 482
    Height = 179
    Align = alClient
    ItemHeight = 19
    TabOrder = 1
  end
  object AmazonConnectionInfo1: TAmazonConnectionInfo
    AccountName = 'XXX'
    AccountKey = 'XXX'
    Protocol = 'https'
    TableEndpoint = 'sdb.amazonaws.com'
    QueueEndpoint = 'sqs.us-west-2.amazonaws.com'
    StorageEndpoint = 's3.amazonaws.com'
    UseDefaultEndpoints = False
    Left = 200
    Top = 104
  end
end
