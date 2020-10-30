unit uContextoAspecto;

interface

uses
  Aspect4D;

function ContextoAspecto: IAspectContext;

implementation

uses
  Aspect4D.Impl;

var
  FAspectContext: IAspectContext;

function ContextoAspecto: IAspectContext;
begin
  if not Assigned(FAspectContext) then
    FAspectContext := TAspectContext.Create;
  result := FAspectContext;
end;

end.
