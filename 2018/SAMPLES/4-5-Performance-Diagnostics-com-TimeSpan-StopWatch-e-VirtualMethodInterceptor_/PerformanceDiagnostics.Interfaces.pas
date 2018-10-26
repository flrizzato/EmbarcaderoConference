unit PerformanceDiagnostics.Interfaces;

interface

type
  IMethodProxy = interface
  ['{A30FC512-01B1-44FE-8A80-86080BD3F152}']

  end;

  IMethodInterceptor = interface
  ['{9536B254-CD46-4778-AFBF-9136334E497F}']

  end;

  IPerformanceDiagnostics = interface
  ['{E206BC61-8D6A-42DC-B89B-EDF21F4762E1}']
    function Add(_AMethodName: string): IPerformanceDiagnostics;
    function GetTotalSeconds: Double;
    function GetTotalMiliseconds: Double;
  end;

implementation

end.
