{//************************************************************//}
{//                                                            //}
{//         Código gerado pelo assistente                      //}
{//                                                            //}
{//         Projeto MVCBr                                      //}
{//         tireideletra.com.br  / amarildo lacerda            //}
{//************************************************************//}
{// Data: 13/06/2017 23:41:39                                  //}
{//************************************************************//}
/// <summary>
///    Uma View representa a camada de apresentação ao usuário
///    deve esta associado a um controller onde ocorrerá
///    a troca de informações e comunicação com os Models
/// </summary>
unit EConference2017.View;
interface
uses
{$IFDEF FMX}FMX.Forms, {$ELSE}VCL.Forms,
   {$ENDIF}
  System.SysUtils, System.Classes,MVCBr.Interf,
  MVCBr.View,MVCBr.FormView,MVCBr.Controller, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Vcl.ExtCtrls, Vcl.DBCtrls,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, MVCBr.ODataDatasetAdapter,
  oData.Comp.Client, MVCBr.IdHTTPRestClient, Vcl.Controls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, MVCBr.ODataFDMemTable, MVCBr.ODataDatasetBuilder,
  Vcl.Buttons, MVCBr.HTTPRestClient;

type
  // Interface para a VIEW
  IEConference2017View = interface(IView)
    ['{FF9F7385-2C12-49B3-85F8-683AC991EE70}']
    // incluir especializacoes aqui
  end;

  // Object Factory que implementa a interface da VIEW
  TEConference2017View = class(TFormFactory {TFORM} ,IView,IThisAs<TEConference2017View>,
                        IEConference2017View,IViewAs<IEConference2017View>)
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    DBNavigator1: TDBNavigator;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Button3: TButton;
    Edit1: TEdit;
    ODataDatasetBuilder1: TODataDatasetBuilder;
    Label2: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    MemoExecucao: TMemo;
    EdtPesquisa: TEdit;
    Label3: TLabel;
    BitBtn1: TBitBtn;
    ODataFDMemTable1: TODataFDMemTable;
    BitBtn2: TBitBtn;
    ODataDatasetBuilder2: TODataDatasetBuilder;
    ODataFDMemTable2: TODataFDMemTable;
    DataSource2: TDataSource;
    Button4: TButton;
    EdtCampo: TEdit;
    EdtOpera: TEdit;
    ODataDatasetBuilder3: TODataDatasetBuilder;
    ODataFDMemTable3: TODataFDMemTable;
    DataSource3: TDataSource;
    DBGrid2: TDBGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ODataFDMemTable1AfterInsert(DataSet: TDataSet);
    procedure ODataDatasetBuilder1AfterExecute(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure DataSource2DataChange(Sender: TObject; Field: TField);
  private
     FInited:Boolean;
  protected
    procedure Init;
    function Controller(const aController: IController): IView;override;
  public
   { Public declarations }
    class function New(AController:IController):IView;
    function This: TObject;override;
    function ThisAs:TEConference2017View;
    function ViewAs:IEConference2017View;
    function ShowView(const AProc: TProc<IView>): integer;override;
  end;

Implementation

{$R *.DFM}

function TEConference2017View.ViewAs:IEConference2017View;
begin
  result := self;
end;

class function TEConference2017View.new(AController:IController):IView;
begin
   result := TEConference2017View.create(nil);
   result.controller(AController);
end;

procedure TEConference2017View.ODataDatasetBuilder1AfterExecute(Sender: TObject);
begin
     MemoExecucao.Lines.Clear;
     MemoExecucao.Lines.Add(ODataDatasetBuilder1.RestClient.Resource);
end;

procedure TEConference2017View.ODataFDMemTable1AfterInsert(DataSet: TDataSet);
begin
     ODataFDMemTable1.FieldByName('ID_CLIENTE').AsInteger := 0;
     ODataFDMemTable1.FieldByName('CODIGO').AsInteger := 0;
end;

procedure TEConference2017View.BitBtn1Click(Sender: TObject);
begin
     //ODataDatasetBuilder1.Filter := 'NOME containing '+QuotedStr( EdtPesquisa.Text );
     //ODataDatasetBuilder1.Filter := Edit1.Text+' containing '+QuotedStr( EdtPesquisa.Text );
     //ODataDatasetBuilder1.execute;


     ODataDatasetBuilder1.Filter := EdtCampo.Text+' '+EdtOpera.Text+' '+QuotedStr( EdtPesquisa.Text );
     ODataDatasetBuilder1.execute;
end;

procedure TEConference2017View.BitBtn2Click(Sender: TObject);
begin
     if ODataFDMemTable1.UpdatesPending then
     begin
          MemoExecucao.Lines.Add(ODataFDMemTable1.Changes.ToString);
          ODataFDMemTable1.ApplyUpdates;
          //ODataDatasetBuilder1.ApplyUpdates;
     end;
end;

procedure TEConference2017View.Button1Click(Sender: TObject);
begin
     ODataDatasetBuilder1.Filter := '';
     ODataDatasetBuilder1.TopRows := StrToIntDef(Edit1.Text,0);
     ODataDatasetBuilder1.Execute;
end;

procedure TEConference2017View.Button2Click(Sender: TObject);
begin
     ODataFDMemTable1.Close;
end;

procedure TEConference2017View.Button3Click(Sender: TObject);
begin
     Label1.Caption := FormatFloat(',0',ODataFDMemTable1.RecordCount);
end;

procedure TEConference2017View.Button4Click(Sender: TObject);
begin
     ODataDatasetBuilder2.TopRows := StrToIntDef(Edit1.Text,10);
     ODataDatasetBuilder2.execute;
end;

function TEConference2017View.Controller(const AController:IController):IView;
begin
  result := inherited Controller(AController);
  if not FInited then
  begin
       init;
       FInited := True;
  end;
end;
procedure TEConference2017View.DataSource2DataChange(Sender: TObject; Field: TField);
begin
     if ODataFDMemTable2.FieldByName('REG').AsInteger > 0 then
     begin
          ODataDatasetBuilder3.Filter := 'ID_NOTA eq '+ODataFDMemTable2.FieldByName('REG').AsString;
          ODataDatasetBuilder3.execute;
     end;
end;

procedure TEConference2017View.Init;
var vArq: string;
begin
   // incluir incializações aqui
   //TStyleManager.LoadFromFile('..\..\Amakrits.vsf');
   //TStyleManager.TrySetStyle('Amakrits');
end;
function TEConference2017View.This:TObject;
begin
   result := inherited This;
end;
function TEConference2017View.ThisAs:TEConference2017View;
begin
   result := self;
end;
function TEConference2017View.ShowView(const AProc:TProc<IView>):integer;
begin
  inherited;
end;
end.
