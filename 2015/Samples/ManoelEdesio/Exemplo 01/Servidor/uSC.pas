unit uSC;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSCommonServer, Datasnap.DSServer;

type
  TSC = class(TDataModule)
    DSServerClass1: TDSServerClass;
    DSServer1: TDSServer;
    procedure DSServerClass1GetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SC: TSC;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses uSM;

{$R *.dfm}

procedure TSC.DSServerClass1GetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
   PersistentClass := uSM.TSM;
end;

end.
