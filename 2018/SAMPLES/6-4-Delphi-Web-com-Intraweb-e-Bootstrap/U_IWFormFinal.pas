unit U_IWFormFinal;

interface

uses
  Classes, SysUtils, IWAppForm, IWApplication, IWColor, IWTypes, IWVCLComponent,
  IWBaseLayoutComponent, IWBaseContainerLayout, IWContainerLayout,
  IWTemplateProcessorHTML, IWCompEdit, Vcl.Controls, IWVCLBaseControl,
  IWBaseControl, IWBaseHTMLControl, IWControl, IWCompButton;

type
  TIWFormFinal = class(TIWAppForm)
    IWTemplateProcessorHTML1: TIWTemplateProcessorHTML;
    IWBTNACAO: TIWButton;
    IWACAO: TIWEdit;
    procedure IWBTNACAOClick(Sender: TObject);
  public
  end;

implementation

{$R *.dfm}

uses ServerController;


procedure TIWFormFinal.IWBTNACAOClick(Sender: TObject);
begin
  // Todo clique de menu passa por aqui
  Controller.AcaoMenu(IWACAO.Text);
end;

end.
