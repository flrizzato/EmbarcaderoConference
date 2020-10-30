namespace;

interface

uses
  System,
  System.Data,
  System.Configuration,
  System.Web,
  System.Web.Security,
  System.Web.SessionState,
  System.Web.UI,
  System.Web.UI.WebControls,
  System.Web.UI.WebControls.WebParts,
  System.Web.UI.HtmlControls;

type
  treinamentos = public partial class(System.Web.UI.Page)
  protected
    method Page_Load(sender: Object; e: EventArgs);
  end;

implementation

method treinamentos.Page_Load(sender: Object; e: EventArgs);
begin

end;

end.
