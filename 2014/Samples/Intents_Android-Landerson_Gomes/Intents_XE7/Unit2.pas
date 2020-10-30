unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.Controls.Presentation, FMX.Calendar, FMX.StdCtrls, FMX.DateTimeCtrls,
  FMX.Edit, FMX.Objects;

type
  TForm2 = class(TForm)
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    DateEdit1: TDateEdit;
    TimeEdit1: TTimeEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Image1: TImage;
    Button1: TButton;
    Button2: TButton;
    Image2: TImage;
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}
{$R *.SmXhdpiPh.fmx ANDROID}
{$R *.LgXhdpiTb.fmx ANDROID}

uses Androidapi.Helpers,
    IdURI, FMX.Helpers.Android, Androidapi.Jni.GraphicsContentViewText,
    Androidapi.Jni.Net, Androidapi.Jni.JavaTypes,
    DateUtils;

procedure TForm2.Button1Click(Sender: TObject);
var
  IntentCalendario : JIntent;
  Calendario : JCalendar;
  uri : string;
begin
  uri := 'content://com.android.calendar/events';
  IntentCalendario := TJIntent.JavaClass.init(
                    TJIntent.JavaClass.ACTION_EDIT,
                    TJnet_Uri.JavaClass.parse(StringToJString(TIdURI.URLEncode(uri))));
  Calendario := TJCalendar.JavaClass.getInstance;
  Calendario.&set(YearOf(DateEdit1.DateTime), MonthOf(DateEdit1.DateTime) -1,
                      DayOf(DateEdit1.DateTime),
                      HourOf(TimeEdit1.Time), MinuteOf(TimeEdit1.Time));
  IntentCalendario.putExtra(StringToJString('beginTime'), Calendario.getTimeInMillis());
  IntentCalendario.putExtra(StringToJString('endTime'), Calendario.getTimeInMillis()+ 2 *3600*1000);
  IntentCalendario.putExtra(StringToJString('title'), StringToJString(Edit1.Text));
  IntentCalendario.putExtra(StringToJString('eventLocation'),
                StringToJString('Espaço Apas, Rua Pio XI, 1200 - Alto da Lapa, São Paulo - SP'));
  IntentCalendario.putExtra(StringToJString('description'),
          StringToJString(Edit2.Text));
  SharedActivity.startActivity(IntentCalendario);
end;

procedure TForm2.Button2Click(Sender: TObject);
var
  Intent : JIntent;
  uri : string;
begin
  uri := 'google.streetview:cbll=-23.53388,-46.7137252&cbp=1,90,,0,1.0&mz=14';   // Espaco APAS
  try
    Intent := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_VIEW,
        TJnet_Uri.JavaClass.parse(StringToJString(uri)));
    SharedActivity.startActivity(Intent);
  except on E: Exception do
    ShowMessage(E.Message);
  end;
end;

procedure TForm2.FormActivate(Sender: TObject);
begin
  TabControl1.TabIndex := 0;
  DateEdit1.Date := Now();
  TimeEdit1.Time := Now();

end;

end.
