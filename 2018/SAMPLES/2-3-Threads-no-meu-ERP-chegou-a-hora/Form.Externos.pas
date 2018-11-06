unit Form.Externos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmExternos = class(TForm)
    PanelSalvaArq: TPanel;
    PanelCarregaArq: TPanel;
    ButtonSalvaArq: TButton;
    ButtonCarregaArq: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
