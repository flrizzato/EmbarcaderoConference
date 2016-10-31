unit uConexao;

interface

type
  TConexao = class
  public
    class procedure BeginTransaction;
    class procedure Commit;
    class procedure Rollback;
  end;

implementation

uses
  FMX.Dialogs;

class procedure TConexao.BeginTransaction;
begin
  ShowMessage('TConexao.BeginTransaction');
end;

class procedure TConexao.Commit;
begin
  ShowMessage('TConexao.Commit');
end;

class procedure TConexao.Rollback;
begin
  ShowMessage('TConexao.Rollback');
end;

end.
