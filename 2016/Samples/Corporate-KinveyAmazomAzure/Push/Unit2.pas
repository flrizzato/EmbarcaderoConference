unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, IPPeerClient,
  REST.Backend.PushTypes, REST.Backend.MetaTypes, System.JSON,
  REST.Backend.KinveyServices, Data.Bind.Components, Data.Bind.ObjectScope,
  REST.Backend.BindSource, REST.Backend.ServiceComponents,
  REST.Backend.KinveyProvider, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.Layouts, FMX.Edit;

type
  TForm2 = class(TForm)
    KinveyProvider1: TKinveyProvider;
    BackendPush1: TBackendPush;
    Button1: TButton;
    Edit1: TEdit;
    Layout1: TLayout;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

procedure TForm2.Button1Click(Sender: TObject);
begin
  BackendPush1.Message := Edit1.Text;
  BackendPush1.Push;
end;

end.
