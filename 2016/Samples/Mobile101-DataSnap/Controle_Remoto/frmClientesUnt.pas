unit frmClientesUnt;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  frmMoldeTelasUnt, Data.DB, Datasnap.DBClient, FMX.Objects, FMX.Edit,
  FMX.ListBox, FMX.TabControl, FMX.Gestures, FMX.Controls.Presentation;

type
  TfrmClientes = class(TfrmMoldeTelas)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmClientes: TfrmClientes;

implementation

{$R *.fmx}

end.
