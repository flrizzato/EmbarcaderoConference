unit fPrincipalVI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Rtti;

type
  IMinhaInterfaceMaisUmaVez = interface(IInvokable)
    ['{6EE6548F-D2B4-4676-A585-166BD8256548}']
    procedure Metodo1;
    procedure Metodo2;
  end;

  TForm4 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

procedure TForm4.Button1Click(Sender: TObject);
var
  lReferencia: IMinhaInterfaceMaisUmaVez;
  lObjeto: TObject;
begin
  ReportMemoryLeaksOnShutdown := True;

  lReferencia := TVirtualInterface.Create(TypeInfo(IMinhaInterfaceMaisUmaVez),
    procedure(Method: TRttiMethod; const Args: TArray<TValue>; out Result: TValue)
    begin
      Memo1.Lines.Add(Method.ToString);
    end) as IMinhaInterfaceMaisUmaVez;

  lReferencia.Metodo1;
  lReferencia.Metodo2;
end;

end.
