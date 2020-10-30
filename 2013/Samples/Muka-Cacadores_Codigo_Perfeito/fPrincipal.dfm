object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'frmPrincipal'
  ClientHeight = 492
  ClientWidth = 446
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 446
    Height = 492
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 356
    ExplicitHeight = 383
    object GroupBox1: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 436
      Height = 59
      Align = alTop
      Caption = 'Regra 2'
      TabOrder = 0
      ExplicitWidth = 346
      object btnValidarCpf: TButton
        Left = 15
        Top = 22
        Width = 95
        Height = 25
        Caption = 'ValidarCPF'
        TabOrder = 0
        OnClick = btnValidarCpfClick
      end
      object edtCpf: TEdit
        Left = 125
        Top = 24
        Width = 95
        Height = 21
        TabOrder = 1
        Text = '01234567890'
      end
      object btnTValidadorCpf: TButton
        Left = 235
        Top = 22
        Width = 95
        Height = 25
        Caption = 'TValidador.CPF'
        TabOrder = 2
        OnClick = btnTValidadorCpfClick
      end
    end
    object stbInfo: TStatusBar
      Left = 0
      Top = 469
      Width = 442
      Height = 19
      Panels = <
        item
          Width = 250
        end
        item
          Width = 50
        end>
      ExplicitTop = 360
      ExplicitWidth = 352
    end
    object GroupBox2: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 135
      Width = 436
      Height = 61
      Align = alTop
      Caption = 'Regra 4'
      TabOrder = 2
      ExplicitWidth = 346
      object btnLoginComum: TButton
        Left = 15
        Top = 22
        Width = 95
        Height = 25
        Caption = 'Login Comum'
        TabOrder = 0
        OnClick = btnLoginComumClick
      end
      object btnLoginWith: TButton
        Left = 125
        Top = 22
        Width = 95
        Height = 25
        Caption = 'Login With'
        TabOrder = 1
        OnClick = btnLoginWithClick
      end
      object btnLoginOO: TButton
        Left = 235
        Top = 22
        Width = 95
        Height = 25
        Caption = 'Login OO'
        TabOrder = 2
        OnClick = btnLoginOOClick
      end
    end
    object GroupBox3: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 68
      Width = 436
      Height = 61
      Align = alTop
      Caption = 'Regra 3'
      TabOrder = 3
      ExplicitWidth = 346
      object bntAlteraUsuario: TButton
        Left = 15
        Top = 22
        Width = 95
        Height = 25
        Caption = 'TUsuario'
        TabOrder = 0
        OnClick = bntAlteraUsuarioClick
      end
      object edtUsuario: TEdit
        Left = 125
        Top = 24
        Width = 95
        Height = 21
        TabOrder = 1
      end
    end
    object GroupBox4: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 202
      Width = 436
      Height = 223
      Align = alTop
      Caption = 'Regra 7'
      TabOrder = 4
      ExplicitWidth = 346
      DesignSize = (
        436
        223)
      object Button2: TButton
        Left = 112
        Top = 25
        Width = 101
        Height = 25
        Caption = 'Exec pelo dtm'
        TabOrder = 0
        OnClick = Button2Click
      end
      object Button1: TButton
        Left = 4
        Top = 25
        Width = 101
        Height = 25
        Caption = 'Exec pelo evento'
        TabOrder = 1
        OnClick = Button1Click
      end
      object pgbStatus: TProgressBar
        Left = 2
        Top = 204
        Width = 432
        Height = 17
        Align = alBottom
        TabOrder = 2
        ExplicitLeft = 0
        ExplicitTop = 222
        ExplicitWidth = 380
      end
      object memNome: TMemo
        AlignWithMargins = True
        Left = 4
        Top = 64
        Width = 426
        Height = 137
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 3
      end
      object Button3: TButton
        Left = 220
        Top = 25
        Width = 101
        Height = 25
        Caption = 'Exec pelo obj'
        TabOrder = 4
        OnClick = Button3Click
      end
      object Button4: TButton
        Left = 328
        Top = 25
        Width = 101
        Height = 25
        Caption = 'Exec pela classe'
        TabOrder = 5
        OnClick = Button4Click
      end
    end
  end
end
