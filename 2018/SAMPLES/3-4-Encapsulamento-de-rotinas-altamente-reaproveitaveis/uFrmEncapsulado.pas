unit uFrmEncapsulado;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls;

type
  TForm3 = class(TForm)
    DataSource1: TDataSource;
    Button1: TButton;
    DBGrid1: TDBGrid;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

uses uConnection;

procedure TForm3.Button1Click(Sender: TObject);
begin
  DataSource1.DataSet :=
      TDBConnection.GetInstance.ExecuteSelect('select * from contato');
end;

end.
