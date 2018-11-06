unit Classe.Cotacao;

interface

uses
  System.Generics.Collections;

type
(*
  {
  "status": "ok",
  "name": "Market Price (USD)",
  "unit": "USD",
  "period": "day",
  "description": "Average USD market price across major bitcoin exchanges.",
  "values": [{
      "x": 1499990400,
      "y": 2190.947833333333
      }
   ]}

   }
*)
  TValor = class
  private
    Fx: Int64;
    Fy: Double;
  public
    property x: Int64 read Fx write Fx;
    property y: Double read Fy write Fy;
  end;

  TCotacao = class
  private
    FStatus: string;
    Fname: string;
    FUnit: string;
    Fperiod: string;
    Fdescription: string;
    Fvalues: TArray<TValor>;
  public
    property status: string read Fstatus write Fstatus;
    property name: string read Fname write Fname;
    property &unit: string read FUnit write FUnit;
    property period: string read Fperiod write Fperiod;
    property description: string read Fdescription write Fdescription;
    property values: TArray<TValor> read Fvalues write Fvalues;
  end;

implementation

end.
