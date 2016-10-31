unit AqDrop.Core.Helpers.Exception;

interface

uses
  System.SysUtils;

type
  TExceptionHelper = class helper for Exception
  public
    procedure ForThisAndInnerExceptions(const pHandler: TProc<Exception>);
  end;

implementation

{ TExceptionHelper }

procedure TExceptionHelper.ForThisAndInnerExceptions(const pHandler: TProc<Exception>);
var
  lException: Exception;
begin
  lException := Self;

  while Assigned(lException) do
  begin
    pHandler(lException);

    lException := lException.InnerException;
  end;
end;

end.
