object frmWebLogin: TfrmWebLogin
  Left = 0
  Top = 0
  Caption = 'frmWebLogin'
  ClientHeight = 550
  ClientWidth = 731
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object WebBrowser: TWebBrowser
    Left = 0
    Top = 49
    Width = 731
    Height = 501
    Align = alClient
    TabOrder = 0
    ExplicitTop = 111
    ExplicitHeight = 445
    ControlData = {
      4C0000008D4B0000C83300000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 731
    Height = 49
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 288
      Top = 16
      Width = 36
      Height = 13
      Caption = 'Usu'#225'rio'
    end
    object btnInsereEventos: TButton
      Left = 120
      Top = 10
      Width = 145
      Height = 25
      Caption = 'Inserir eventos na pagina'
      TabOrder = 0
      OnClick = btnInsereEventosClick
    end
    object btnCarregarPagina: TButton
      Left = 8
      Top = 10
      Width = 97
      Height = 25
      Caption = 'Carregar Pagina'
      TabOrder = 1
      OnClick = btnCarregarPaginaClick
    end
    object edtUsuario: TEdit
      Left = 328
      Top = 12
      Width = 121
      Height = 21
      TabOrder = 2
    end
  end
  object pgpHtml: TPageProducer
    HTMLDoc.Strings = (
      '<html>'
      '<body>'
      '    <script type="text/javascript">'
      '    function Versao()'
      '    {'
      '    alert(window.navigator.userAgent);'
      '    }'
      '    </script>'
      
        '    <input TYPE="BUTTON" NAME="submit" value="Vers'#227'o do Browser"' +
        ' onclick="Versao()" >'
      ''
      '    </p>'
      '    <label><b>Usuario</b></label>'
      
        '    <input type="text" placeholder="Enter Username" name="edtUsu' +
        'ario" id="edtUsuario" required>'
      '    </p>'
      '    <label><b>Senha</b></label>'
      
        '    <input type="password" placeholder="Enter Password" name="ed' +
        'tSenha" id="edtSenha" required>'
      '    </p>'
      
        '    <button type="submit" name="btnLogin" id="btnLogin">Login</b' +
        'utton>'
      ' </body>'
      '</html>')
    Left = 24
    Top = 57
  end
end
