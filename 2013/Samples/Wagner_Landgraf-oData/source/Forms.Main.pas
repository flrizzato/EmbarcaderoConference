unit Forms.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, System.UITypes,
  System.Actions, Vcl.ActnList;

type
  TForm1 = class(TForm)
    Button1: TButton;
    MainMenu1: TMainMenu;
    ools1: TMenuItem;
    UpdateDatabase1: TMenuItem;
    Button2: TButton;
    Phone1: TMenuItem;
    IncludeCountryCode1: TMenuItem;
    ExcludeCountryCode1: TMenuItem;
    ActionList1: TActionList;
    ConnSQLiteAction: TAction;
    ConnFirebirdAction: TAction;
    ConnRemoteDBAction: TAction;
    Connections1: TMenuItem;
    ConnSQLiteAction1: TMenuItem;
    ConnFirebirdAction1: TMenuItem;
    ConnRemoteDBAction1: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure UpdateDatabase1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure IncludeCountryCode1Click(Sender: TObject);
    procedure ExcludeCountryCode1Click(Sender: TObject);
    procedure ConnSQLiteActionExecute(Sender: TObject);
    procedure ConnFirebirdActionExecute(Sender: TObject);
    procedure ConnRemoteDBActionExecute(Sender: TObject);
    procedure ConnSQLiteActionUpdate(Sender: TObject);
    procedure ConnFirebirdActionUpdate(Sender: TObject);
    procedure ConnRemoteDBActionUpdate(Sender: TObject);
  private
  public
  end;

var
  Form1: TForm1;

implementation

uses
  Forms.CustomerList, Forms.CountryList, Modules.Connections,
  PhoneTools;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  CustomersForm: TCustomersForm;
begin
  CustomersForm := TCustomersForm.Create(Application);
  try
    CustomersForm.ShowModal;
  finally
    CustomersForm.Free;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  CountriesForm: TCountriesForm;
begin
  CountriesForm := TCountriesForm.Create(Application);
  try
    CountriesForm.ShowModal;
  finally
    CountriesForm.Free;
  end;
end;

procedure TForm1.ConnFirebirdActionExecute(Sender: TObject);
begin
  Connections.DefaultConnection := Connections.FirebirdConnection;
end;

procedure TForm1.ConnFirebirdActionUpdate(Sender: TObject);
begin
  TAction(Sender).Checked := Connections.DefaultConnection = Connections.FirebirdConnection;
end;

procedure TForm1.ConnRemoteDBActionExecute(Sender: TObject);
begin
  Connections.DefaultConnection := Connections.RemoteDBConnection;
end;

procedure TForm1.ConnRemoteDBActionUpdate(Sender: TObject);
begin
  TAction(Sender).Checked := Connections.DefaultConnection = Connections.RemoteDBConnection;
end;

procedure TForm1.ConnSQLiteActionExecute(Sender: TObject);
begin
  Connections.DefaultConnection := Connections.SQLiteConnection;
end;

procedure TForm1.ConnSQLiteActionUpdate(Sender: TObject);
begin
  TAction(Sender).Checked := Connections.DefaultConnection = Connections.SQLiteConnection;
end;

procedure TForm1.ExcludeCountryCode1Click(Sender: TObject);
begin
  if MessageDlg('Exclude country code from all phone numbers?', mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrYes then
  begin
    TPhoneTools.UpdateCountryCodes(false);
    ShowMessage('Phone numbers updated.');
  end;
end;

procedure TForm1.IncludeCountryCode1Click(Sender: TObject);
begin
  if MessageDlg('Include country code from all phone numbers?', mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrYes then
  begin
    TPhoneTools.UpdateCountryCodes(true);
    ShowMessage('Phone numbers updated.');
  end;
end;

procedure TForm1.UpdateDatabase1Click(Sender: TObject);
begin
  Connections.UpdateDatabase;
  ShowMessage('Database updated succesfully.');
end;

end.
