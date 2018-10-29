unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, IPPeerClient,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Response.Adapter,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, FMX.StdCtrls,
  FMX.Edit, FMX.Layouts, FMX.Objects, FMX.Controls.Presentation,
  Data.Bind.EngExt, FMX.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  FMX.Bind.Editors, Data.Bind.DBScope;

type
  TForm1 = class(TForm)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    FDMemTable1: TFDMemTable;
    ToolBar1: TToolBar;
    Label1: TLabel;
    Image1: TImage;
    Layout1: TLayout;
    Edit1: TEdit;
    Button1: TButton;
    FDMemTable1cep: TWideStringField;
    FDMemTable1logradouro: TWideStringField;
    FDMemTable1complemento: TWideStringField;
    FDMemTable1bairro: TWideStringField;
    FDMemTable1localidade: TWideStringField;
    FDMemTable1uf: TWideStringField;
    FDMemTable1unidade: TWideStringField;
    FDMemTable1ibge: TWideStringField;
    FDMemTable1gia: TWideStringField;
    Rectangle1: TRectangle;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkPropertyToFieldText: TLinkPropertyToField;
    LinkPropertyToFieldText2: TLinkPropertyToField;
    LinkPropertyToFieldText3: TLinkPropertyToField;
    LinkPropertyToFieldText4: TLinkPropertyToField;
    AniIndicator1: TAniIndicator;
    procedure Button1Click(Sender: TObject);
  private
    procedure ShowAnimator(AShow: Boolean);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses System.Threading;

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
begin
  ShowAnimator(True);
  TTask.Run(
    procedure
    begin
      Sleep(5000);
      TThread.Synchronize(TThread.Current,
        procedure
        begin
          RESTRequest1.Params.ParameterByName('meucep').Value := Edit1.Text;
          RESTRequest1.Execute;
          ShowAnimator(False);
        end);
    end);
end;

procedure TForm1.ShowAnimator(AShow: Boolean);
begin
  AniIndicator1.Visible := AShow;
  AniIndicator1.Enabled := AShow;
  Button1.Enabled := not AShow;
  if AShow then
  begin
    Button1.Text := EmptyStr;
  end
  else
  begin
    Button1.Text := 'OK';
  end
end;

end.
