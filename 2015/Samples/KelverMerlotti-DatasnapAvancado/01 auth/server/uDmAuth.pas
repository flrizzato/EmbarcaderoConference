unit uDmAuth;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.IB,
  FireDAC.Phys.IBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Phys.IBBase;

type
  TdmAuth = class(TDataModule)
    ConAuth: TFDConnection;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    qry: TFDQuery;
    qryEMP_NO: TSmallintField;
    qryJOB_CODE: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
    class function ValidUser(const aUser, aPass: String; out UserId: Integer;
      out Role: String): Boolean;
  end;

//To avoid create unecessary instances
//var
//  dmAuth: TdmAuth;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

class function TdmAuth.ValidUser(const aUser, aPass: String;
  out UserId: Integer; out Role: String): Boolean;
var
  LocalInstance: TdmAuth;
begin
  result := False;
  LocalInstance := TdmAuth.Create(nil);
  try
    try
      LocalInstance.qry.ParamByName('username').Value := aUser;
      LocalInstance.qry.ParamByName('password').Value := aPass;
      LocalInstance.qry.Open;
      result := not LocalInstance.qry.IsEmpty;
      if result then
      begin
        UserId := LocalInstance.qryEMP_NO.Value;
        Role   := LocalInstance.qryJOB_CODE.AsString;
      end;
    except
      result := False;
    end;
  finally
    LocalInstance.ConAuth.Close;
    LocalInstance.Free;
  end;
end;

end.
