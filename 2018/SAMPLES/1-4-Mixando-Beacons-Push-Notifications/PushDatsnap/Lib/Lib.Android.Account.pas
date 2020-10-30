unit Lib.Android.Account;
interface
uses
  Androidapi.Helpers,
  Androidapi.Jni,
  Androidapi.JNI.Accounts,
  Androidapi.JNIBridge,
  Androidapi.JNI.App,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Os,
  System.Classes;

  procedure FillAccountEmails(const AccountType: String; AList: TStrings);
  function GetAccountEmails(const AccountType: String): TArray<String>;
  function GetFirstAccountEmail(const AccountType: string): string;

implementation

procedure FillAccountEmails(const AccountType: String; AList: TStrings);
var
  AccountManager: JAccountManager;
  Accounts: TJavaObjectArray<JAccount>;
  Account: JAccount;
  AccountLoopCounter: Integer;
begin
  AccountManager := TJAccountManager.JavaClass.get(TAndroidHelper.Context);
  if AccountManager <> nil then
  begin
    Accounts:= AccountManager.getAccountsByType(StringToJString(AccountType));
    if Accounts <> nil then
    begin
      for AccountLoopCounter := 0 to Pred(Accounts.Length) do
      begin
        Account:= TJAccount.Wrap(Accounts.GetRawItem(AccountLoopCounter));
        AList.Add(JStringtoString(Account.name));
      end
    end;
  end;
end;

function GetAccountEmails(const AccountType: String): TArray<String>;
var
  AccountManager: JAccountManager;
  Accounts: TJavaObjectArray<JAccount>;
  Account: JAccount;
  AccountLoopCounter: Integer;
begin
  AccountManager := TJAccountManager.JavaClass.get(TAndroidHelper.Context);
  if AccountManager <> nil then
  begin
    Accounts:= AccountManager.getAccountsByType(StringToJString(AccountType));
    if Accounts <> nil then
    begin
      SetLength(Result, Accounts.Length);
      for AccountLoopCounter := 0 to Pred(Accounts.Length) do
      begin
        Account:= TJAccount.Wrap(Accounts.GetRawItem(AccountLoopCounter));
        Result[AccountLoopCounter] := JStringtoString(Account.name);
      end
    end;
  end;
end;

function GetFirstAccountEmail(const AccountType: string): string;
var
  AccountManager: JAccountManager;
  Accounts: TJavaObjectArray<JAccount>;
  Account: JAccount;
begin
  AccountManager := TJAccountManager.JavaClass.get(TAndroidHelper.Context);
  if AccountManager <> nil then
  begin
    Accounts := AccountManager.getAccountsByType(StringToJString(AccountType));
    if Accounts <> nil then
    begin
      Account:= TJAccount.Wrap(Accounts.GetRawItem(0));
      Result:= JStringtoString(Account.name);
    end;
  end;
end;

end.
