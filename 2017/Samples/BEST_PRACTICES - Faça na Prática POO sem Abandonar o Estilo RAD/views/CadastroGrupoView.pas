{ //************************************************************// }
{ //                                                            // }
{ //         Código gerado pelo assistente                      // }
{ //                                                            // }
{ //         Projeto MVCBr                                      // }
{ //         tireideletra.com.br  / amarildo lacerda            // }
{ //************************************************************// }
{ // Data: 19/08/2017 11:11:22                                  // }
{ //************************************************************// }

/// <summary>
/// Uma View representa a camada de apresentação ao usuário
/// deve esta associado a um controller onde ocorrerá
/// a troca de informações e comunicação com os Models
/// </summary>
unit CadastroGrupoView;

interface

uses
{$IFDEF FMX}FMX.Forms, {$ELSE}VCL.Forms, {$ENDIF}
  System.SysUtils, System.Classes, MVCBr.Interf, System.JSON,
  MVCBr.View, MVCBr.FormView, MVCBr.Controller, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, oData.Comp.Client, MVCBr.ODataDatasetBuilder,
  VCL.Controls, VCL.Grids, VCL.DBGrids, VCL.StdCtrls, VCL.ExtCtrls,
  MVCBr.ODataFDMemTable;

type
  /// Interface para a VIEW
  ICadastroGrupoView = interface(IView)
    ['{7DCB872A-E7C8-4B5B-B56B-2AF3282AA9B8}']
    // incluir especializacoes aqui
  end;

  /// Object Factory que implementa a interface da VIEW
  TCadastroGrupoView = class(TFormFactory { TFORM } , IView,
    IThisAs<TCadastroGrupoView>, ICadastroGrupoView,
    IViewAs<ICadastroGrupoView>)
    DBGrid1: TDBGrid;
    ODataDatasetBuilder1: TODataDatasetBuilder;
    DataSource1: TDataSource;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ODataFDMemTable1: TODataFDMemTable;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    FInited: boolean;
  protected
    function Controller(const aController: IController): IView; override;
  public
    { Public declarations }
    class function New(aController: IController): IView;
    function ThisAs: TCadastroGrupoView;
    function ViewAs: ICadastroGrupoView;
    function ShowView(const AProc: TProc<IView>): integer; override;
  end;

Implementation

{$R *.DFM}

function TCadastroGrupoView.ViewAs: ICadastroGrupoView;
begin
  result := self;
end;

class function TCadastroGrupoView.New(aController: IController): IView;
begin
  result := TCadastroGrupoView.create(nil);
  result.Controller(aController);
end;

procedure TCadastroGrupoView.Button1Click(Sender: TObject);
begin
  ODataDatasetBuilder1.execute;
end;

procedure TCadastroGrupoView.Button2Click(Sender: TObject);
begin
  if ODataFDMemTable1.State in dsEditModes then
    ODataFDMemTable1.post;
  ODataDatasetBuilder1.ApplyUpdates;
end;

procedure TCadastroGrupoView.Button3Click(Sender: TObject);
begin
  ODataFDMemTable1.close;
end;

function TCadastroGrupoView.Controller(const aController: IController): IView;
begin
  result := inherited Controller(aController);
  if not FInited then
  begin
    init;
    FInited := true;
  end;
end;

function TCadastroGrupoView.ThisAs: TCadastroGrupoView;
begin
  result := self;
end;

function TCadastroGrupoView.ShowView(const AProc: TProc<IView>): integer;
begin
  inherited;
end;

end.
