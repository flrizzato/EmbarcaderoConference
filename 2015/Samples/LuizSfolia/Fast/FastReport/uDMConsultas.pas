unit uDMConsultas;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.IB,
  FireDAC.Phys.IBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Datasnap.Provider, Datasnap.DBClient;

type
  TDMConsultas = class(TDataModule)
    qryEmployee: TFDQuery;
    dspEmployee: TDataSetProvider;
    cdsEmployee: TClientDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMConsultas: TDMConsultas;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses uDMConexao;

{$R *.dfm}

end.
