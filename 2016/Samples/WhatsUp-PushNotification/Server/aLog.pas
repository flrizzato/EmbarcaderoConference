unit aLog;
interface

type
  ILog = interface
  ['{E8D1CD6F-A09C-46AB-BF1D-4A5FB9EDF401}']
    procedure Log(const Msg: string); stdcall;
  end;

implementation

end.
