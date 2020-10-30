inherited F_CadastroCliente: TF_CadastroCliente
  Caption = 'Cadastro de Cliente'
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 8
    Top = 17
    Width = 60
    Height = 13
    Caption = 'Raz'#227'o Social'
  end
  object Label2: TLabel [1]
    Left = 8
    Top = 69
    Width = 45
    Height = 13
    Caption = 'Endere'#231'o'
  end
  inherited Panel1: TPanel
    inherited BitBtn1: TBitBtn
      ExplicitLeft = 432
    end
    inherited BitBtn2: TBitBtn
      ExplicitLeft = 335
    end
  end
  object MRazaoSocial: TEdit
    Left = 8
    Top = 32
    Width = 489
    Height = 21
    Hint = 'Raz'#227'o Social do Cliente'
    TabOrder = 1
    Text = 'MRazaoSocial'
  end
  object MEndereco: TEdit
    Left = 8
    Top = 83
    Width = 489
    Height = 21
    Hint = 'Endere'#231'o do Cliente'
    TabOrder = 2
    Text = 'Edit1'
  end
end
