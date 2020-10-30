unit POO.Controller.Exception;

interface

uses
  VCL.Forms, SysUtils, POO.Controller.Log.Facade, Dialogs;

Type
  TControllerException = class(TInterfacedObject)
    private
    public
      constructor Create;
      destructor Destroy; override;
      procedure TratarException(Sender: TObject; E: Exception);
  end;

implementation

{ TControllerException }

constructor TControllerException.Create;
begin
  Application.OnException := TratarException;
end;

destructor TControllerException.Destroy;
begin

  inherited;
end;

procedure TControllerException.TratarException(Sender: TObject; E: Exception);
begin
  TControllerLogFacade.New.SalvarLog(E.Message);
  MessageDlg(E.Message, mtError, [mbOK], 0);
end;

var
  ControllerException : TControllerException;

initialization
  ControllerException := TControllerException.Create;

finalization
  ControllerException.Free;

end.
