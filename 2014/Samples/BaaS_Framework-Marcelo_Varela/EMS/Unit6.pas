unit Unit6;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  IPPeerClient, REST.Backend.EMSProvider, FMX.Layouts, FMX.Grid,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.UI.Intf, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.Stan.Error, REST.Backend.EMSServices,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope,
  REST.Backend.EMSFireDAC, FireDAC.Comp.Client, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.UI, FMX.StdCtrls;

type
  TForm6 = class(TForm)
    Grid1: TGrid;
    EMSProvider1: TEMSProvider;
    FDSchemaAdapter2: TFDSchemaAdapter;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    memPessoa: TFDMemTable;
    taPessoa: TFDTableAdapter;
    EMSFireDACClient1: TEMSFireDACClient;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

{$R *.fmx}

procedure TForm6.Button1Click(Sender: TObject);
begin
  EMSFireDACClient1.GetData;
end;

procedure TForm6.Button2Click(Sender: TObject);
begin
  EMSFireDACClient1.PostUpdates;
end;

procedure TForm6.Button3Click(Sender: TObject);
begin
  memPessoa.Delete;
end;

end.
