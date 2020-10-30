unit frmPrincipalUnt;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Controls.Presentation;

type
  TfrmPrincipal = class(TForm)
    ToolBar1: TToolBar;
    Label1: TLabel;
    GridPanelLayout1: TGridPanelLayout;
    ImageControl1: TImageControl;
    ImageControl4: TImageControl;
    ImageControl5: TImageControl;
    ImageControl6: TImageControl;
    ImageControl7: TImageControl;
    ImageControl8: TImageControl;
    ImageControl3: TImageControl;
    ImageControl2: TImageControl;
    procedure ImageControl8Click(Sender: TObject);
    procedure ImageControl7Click(Sender: TObject);
    procedure ImageControl6Click(Sender: TObject);
    procedure ImageControl5Click(Sender: TObject);
    procedure ImageControl1Click(Sender: TObject);
    procedure ImageControl3Click(Sender: TObject);
    procedure ImageControl4Click(Sender: TObject);
    procedure ImageControl2Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

uses Androidapi.Helpers,
  ClientClassesDistrimedUnt, ClientModuleDistrimedUnt, frmProdutosUnt,
  frmMoldeTelasUnt, frmVendedoresUnt, frmClientesUnt;

procedure TfrmPrincipal.ImageControl8Click(Sender: TObject);
var
  pw, s : string;
begin

    if MessageDlg('Deseja atualizar a carga do Sistema de Pedido Eletrônico?',
        TMsgDlgType.mtConfirmation,[TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0, TMsgDlgBtn.mbNo) = mrYes  then
    begin
      pw := InputBox('Senha de acesso: ', 'Informe a senha para iniciar a atualização:', '');
      if pw <> EmptyStr  then
      begin
       if ClientModuleDistrimed.DSServerModuleEstoqueClient.AtualizaCargaPE(pw, s) = True then
          ShowMessage(s)
        else
          ShowMessage(s);
      end
      else
        ShowMessage('Operação cancelada - senha vazia!');

    end;

end;

procedure TfrmPrincipal.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
{}
  CanClose := False;
  MessageDlg('Deseja fechar a aplicação Extreme Delphi BH?',
    System.UITypes.TMsgDlgType.mtInformation,
    [System.UITypes.TMsgDlgBtn.mbYes, System.UITypes.TMsgDlgBtn.mbNo], 0,
    procedure(const BotaoPressionado: TModalResult)
      begin
        case BotaoPressionado of
          mrYes: begin
              SharedActivity.Finish;
            end;
          mrNo: begin
//
            end;
        end;
      end
    );

end;

procedure TfrmPrincipal.ImageControl1Click(Sender: TObject);
begin
//    ShowMessage('Tratar Clientes');
    frmClientes := TfrmClientes.Create(Application);
    frmClientes.Show;

end;

procedure TfrmPrincipal.ImageControl2Click(Sender: TObject);
begin
  frmVendedores := TfrmVendedores.Create(Application);
  frmVendedores.Show;
end;

procedure TfrmPrincipal.ImageControl3Click(Sender: TObject);
begin
  frmProdutos := TfrmProdutos.Create(Application);
  frmProdutos.Show;
end;

procedure TfrmPrincipal.ImageControl4Click(Sender: TObject);
begin
  ShowMessage('Há... pegadinha do malandro');
end;

procedure TfrmPrincipal.ImageControl5Click(Sender: TObject);
begin
  ShowMessage('Extrme Pão de Queijo');
end;

procedure TfrmPrincipal.ImageControl6Click(Sender: TObject);
begin
  ShowMessage('Tá esperando o que pra começar a fazer o seu app');
end;

procedure TfrmPrincipal.ImageControl7Click(Sender: TObject);
begin
  ShowMessage('Olá bípedes!');
end;

end.
