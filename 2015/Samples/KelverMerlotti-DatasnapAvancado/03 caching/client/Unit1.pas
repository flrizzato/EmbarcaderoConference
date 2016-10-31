unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.StorageBin, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.DBGrids, Vcl.Samples.Spin, Vcl.ExtCtrls, IPPeerClient, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    DBGrid1: TDBGrid;
    mem: TFDMemTable;
    FDStanStorageBinLink1: TFDStanStorageBinLink;
    ds: TDataSource;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    const FileName = 'countries.dat';
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses ClientModuleUnit1;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if FileExists(FileName) then
  begin
    mem.Close;
    mem.LoadFromFile(FileName);
    exit;
  end;

  mem.CopyDataSet(ClientModule1.smCachedDataClient.Countries,
                  [coStructure, coRestart, coAppend]);
  mem.SaveToFile(FileName);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  DeleteFile(FileName);
end;

end.
