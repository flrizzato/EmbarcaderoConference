unit Unit8;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.VCLUI.Wait,
  FireDAC.Phys.IBBase, FireDAC.Phys.IB, FireDAC.Phys.ODBCBase,
  FireDAC.Phys.MSSQL, FireDAC.Comp.UI, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.StdCtrls, FireDAC.VCLUI.Error, FireDAC.Phys.IBDef;

type
  TBanco = (Interbase, SqlServer);

  TForm8 = class(TForm)
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    FDQuery1CAMPO01: TSQLTimeStampField;
    FDQuery1CAMPO02: TSingleField;
    FDQuery1CAMPO03: TFloatField;
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    Memo2: TMemo;
    CheckBox1: TCheckBox;
    FDGUIxErrorDialog1: TFDGUIxErrorDialog;
    CheckBox2: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
    procedure SetDados(Banco: TBanco);
  public
    { Public declarations }
  end;

var
  Form8: TForm8;

implementation

{$R *.dfm}
{ TForm8 }

procedure TForm8.Button1Click(Sender: TObject);
begin
  SetDados(TBanco.Interbase);
end;

procedure TForm8.Button2Click(Sender: TObject);
begin
  SetDados(TBanco.SqlServer);
end;

procedure TForm8.CheckBox1Click(Sender: TObject);
begin
  CheckBox2.Enabled := CheckBox1.Checked;
end;

procedure TForm8.SetDados(Banco: TBanco);
begin
  FDConnection1.Close();
  case Banco of
    Interbase:
      begin
        FDConnection1.Params.Values['Database'] :=
          'C:\Programacao\EC 2014\Bancos\EC-2014.GDB';
        FDConnection1.Params.Values['User_Name'] := 'sysdba';
        FDConnection1.Params.Values['Password'] := 'masterkey';
        FDConnection1.Params.Values['DriverID'] := 'IB';
      end;
    SqlServer:
      begin
        FDConnection1.Params.Values['Database'] := 'EC-2014';
        FDConnection1.Params.Values['User_Name'] := 'sa';
        FDConnection1.Params.Values['Password'] := '732154Al#';
        FDConnection1.Params.Values['Server'] := 'localhost';
        FDConnection1.Params.Values['OSAuthent'] := 'No';
        FDConnection1.Params.Values['DriverID'] := 'MSSQL';
      end;
  end;
  if CheckBox1.Checked then
  begin
    try
      FDQuery1.ExecSQL('insert into Clientes values(:Codigo, :Nome, :Data)',
        [1, 'Alan Glei', '1978-05-11']);
    except
      on E: EFDDBEngineException do
      begin
        if E.Kind = ekUKViolated then
        begin
          if CheckBox2.Checked then
          begin
            FDGUIxErrorDialog1.Execute(E);
          end
          else
          begin
            case Banco of
              Interbase:
                Memo1.Lines.Text := 'Registro Duplicado.';
              SqlServer:
                Memo2.Lines.Text := 'Registro Duplicado.';
            end;
          end;
        end;
      end;
    end;
  end
  else
  begin
    try
      FDQuery1.ExecSQL
        ('insert into Clientes values(1,''Alan Glei'',''1978-05-11'')')
    except
      on E: Exception do
      begin
        case Banco of
          Interbase:
            Memo1.Lines.Text := E.Message;
          SqlServer:
            Memo2.Lines.Text := E.Message;
        end;
      end;
    end;
  end;
end;

end.
