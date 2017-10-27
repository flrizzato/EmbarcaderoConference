unit POO.Model.Interfaces;

interface

type

  iLog = interface
    ['{9C88A19B-664B-470D-B197-8D73C0CAD2CD}']
    function Salvar(Value : String) : iLog;
  end;

  iLogFactory = interface
    ['{BEB48CBD-AF64-4F54-B0E9-2CFB54475410}']
    function Log : iLog;
    function LogTXT(Decorator : iLog) : iLog;
    function LogEmail(Decorator : iLog) : iLog;
    function LogBD(Decorator : iLog) : iLog;
  end;

implementation

end.
