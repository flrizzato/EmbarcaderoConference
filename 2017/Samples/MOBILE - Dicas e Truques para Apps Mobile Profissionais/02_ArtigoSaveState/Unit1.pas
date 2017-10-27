unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.DateTimeCtrls, FMX.Controls.Presentation, FMX.Edit;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    DateEdit1: TDateEdit;
    Image1: TImage;
    procedure FormSaveState(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}
uses System.IOUtils;

procedure TForm1.FormCreate(Sender: TObject);
var
  DadosSalvos: TBinaryReader;
begin
  SaveState.StoragePath := TPath.GetHomePath;
  if SaveState.Stream.Size > 0 then begin
    DadosSalvos := TBinaryReader.Create(SaveState.Stream);
    try
      Edit1.Text := DadosSalvos.ReadString;
      DateEdit1.Text := DadosSalvos.ReadString;
    finally
      DadosSalvos.Free;
    end;
  end;
end;

procedure TForm1.FormSaveState(Sender: TObject);
var
  Dados: TBinaryWriter;
begin
  SaveState.Stream.Clear;
  Dados := TBinaryWriter.Create(SaveState.Stream);
  try
    Dados.Write(Edit1.Text);
    Dados.Write(DateEdit1.Text);
  finally
    Dados.Free;
  end;
end;

end.
