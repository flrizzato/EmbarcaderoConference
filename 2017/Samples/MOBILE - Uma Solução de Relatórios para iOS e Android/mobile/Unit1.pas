unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  ClientModuleUnit1, FMX.Controls.Presentation, FMX.StdCtrls,

  System.IOUtils, FMX.Objects, FMX.ListBox, FMX.Layouts, FMX.TabControl,
  FMX.Edit;

type
  TForm1 = class(TForm)
    TabControl1: TTabControl;
    TabItem2: TTabItem;
    btnDown: TButton;
    Layout4: TLayout;
    pgbProgressoPDF: TProgressBar;
    edtIP: TEdit;
    btnIP: TButton;
    ToolBar1: TToolBar;
    lblStatus: TLabel;
    procedure btnDownClick(Sender: TObject);
    procedure btnIPClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses
  xPlat.OpenPDF;

procedure TForm1.btnDownClick(Sender: TObject);
var
  RetStream  : TStream;
  Buffer     : PByte;
  Mem        : TMemoryStream;
  BytesRead  : Integer;
  DocumentId : Int64;
  Size       : Int64;
  Filename   : String;
  BufSize    : Integer;
  Destino    : String;
  QualImagem : String;
begin
  BufSize := 1024;
  try
    Mem := TMemoryStream.Create;
    GetMem(Buffer, BufSize);
    try
      FileName := 'Relatorio.pdf';
      RetStream := CM.ServerMethods1Client.GerarPDF(Size);
      RetStream.Position := 0;
      if (Size <> 0) then
      begin
        pgbProgressoPDF.Max := Size;
        pgbProgressoPDF.Value := 0;
        //FileName := 'Relatorio.pdf';
        repeat
          BytesRead := RetStream.Read(Pointer(Buffer)^, BufSize);
          if (BytesRead > 0) then
            Mem.WriteBuffer(Pointer(Buffer)^, BytesRead);

          lblStatus.Text := Format('Baixando %s de %s bytes', [IntToStr(Mem.Size), IntToStr(Size)]);
          pgbProgressoPDF.Value := Mem.Size;
          Application.ProcessMessages;
        until (BytesRead < BufSize);

        {$IFDEF MSWINDOWS}
          Destino := ExtractFilePath(ParamStr(0)) + FileName;
        {$ELSE}
          Destino := System.IOUtils.TPath.Combine(System.IOUtils.TPath.GetDocumentsPath, FileName);
        {$ENDIF}
        Mem.SaveToFile(Destino);

        //Abre o PDF
        {$IFNDEF MWWINDOWS}
          OpenPDF('Relatorio.pdf');
        {$ENDIF}

        if (Size <> Mem.Size) then
          raise Exception.Create( 'Erro ao baixar...' );
      end
      else
        lblStatus.Text := EmptyStr;
    finally
      FreeMem(Buffer, BufSize);
      FreeAndNIl(Mem);
      lblStatus.Text := EmptyStr;
      pgbProgressoPDF.Max := 0;
      pgbProgressoPDF.Value := 0;
    end;
  except on E: Exception do
    ShowMessage(E.ClassName + ': ' + E.Message);
  end;
end;

procedure TForm1.btnIPClick(Sender: TObject);
begin
 CM.DSRestConnection1.Host := edtIP.Text;
 ShowMessage('IP atualizado com sucesso!');
end;

end.
