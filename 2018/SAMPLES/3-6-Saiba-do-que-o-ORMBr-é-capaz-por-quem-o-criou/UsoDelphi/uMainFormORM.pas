unit uMainFormORM;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  DB,
  Grids,
  DBGrids,
  StdCtrls,
  Mask,
  DBClient,
  DBCtrls,
  ExtCtrls,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, FireDAC.Comp.Client, FireDAC.Stan.Intf,
  FireDAC.Stan.ExprFuncs, FireDAC.Comp.UI, FireDAC.DApt, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.Phys.IBBase;

type
  TForm3 = class(TForm)
    dtsMestre: TDataSource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Button2: TButton;
    DBGrid2: TDBGrid;
    dtsDetalhe: TDataSource;
    dtsCliente: TDataSource;
    DBEdit1: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    Label7: TLabel;
    FDConnection1: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    Label8: TLabel;
    DBEdit7: TDBEdit;
    Button3: TButton;
    Memo1: TMemo;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDMestre: TFDQuery;
    FDDetalhe: TFDQuery;
    FDCliente: TFDQuery;
    FDStatus: TFDQuery;
    FDMestreID: TIntegerField;
    FDMestreDESCRICAO: TStringField;
    FDMestreDATACADASTRO: TDateField;
    FDMestreDATAALTERACAO: TDateField;
    FDMestreCLIENTE_ID: TIntegerField;
    FDDetalheID: TIntegerField;
    FDDetalheMESTRE_ID: TIntegerField;
    FDDetalheSTATUS_ID: TIntegerField;
    FDDetalheOBSERVACAO: TStringField;
    FDDetalhePRECO: TBCDField;
    FDStatusID: TIntegerField;
    FDStatusDESCRICAO: TStringField;
    dtsStatus: TDataSource;
    FDDetalheAggPRECO: TAggregateField;
    FDClienteID: TIntegerField;
    FDClienteNOME: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FDMestreAfterOpen(DataSet: TDataSet);
    procedure FDMestreBeforeClose(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    published
  end;

var
  Form3: TForm3;

implementation

uses
  StrUtils;

{$R *.dfm}

procedure TForm3.Button2Click(Sender: TObject);
begin
  FDMestre.ApplyUpdates(0);
end;

procedure TForm3.FDMestreAfterOpen(DataSet: TDataSet);
begin
  FDDetalhe.Open;
  FDCliente.Open;
  FDStatus.Open;
end;

procedure TForm3.FDMestreBeforeClose(DataSet: TDataSet);
begin
  FDDetalhe.Close;
  FDCliente.Close;
  FDStatus.Close;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  FDMestre.Open;
end;

end.
