unit ufrmCRUD;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Vcl.ExtCtrls, Vcl.DBCtrls,
  Data.DB, Vcl.Mask, Vcl.StdCtrls, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Aspect4D,
  Aspect4D.Impl, uTransactionAspect;

type
  TForm2 = class(TForm)
    Memo1: TMemo;
    FDMemTable1: TFDMemTable;
    FDMemTable1ID: TIntegerField;
    FDMemTable1Campo1: TStringField;
    FDMemTable1Campo2: TStringField;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    DataSource1: TDataSource;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    DBNavigator1: TDBNavigator;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FAspectContext: IAspectContext;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.FormCreate(Sender: TObject);
begin
  FDMemTable1.CreateDataSet;
  FAspectContext := TAspectContext.Create;
  FAspectContext.Register(TTransactionAspect.Create(Memo1.Lines));
  FAspectContext.Weaver.Proxify(FDMemTable1);
end;

procedure TForm2.FormDestroy(Sender: TObject);
begin
  FAspectContext.Weaver.Unproxify(FDMemTable1);
end;

end.
