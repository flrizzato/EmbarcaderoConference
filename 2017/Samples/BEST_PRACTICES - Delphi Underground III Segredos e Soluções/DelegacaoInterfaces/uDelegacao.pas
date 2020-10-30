unit uDelegacao;

interface

uses
  System.Classes;

type
  ICameraFotografica = interface
    ['{ADFA03E6-EBF9-4160-944F-0830850676FC}']
    procedure TirarFoto;
  end;

  IMp3Player = interface
    ['{59424B32-3B0A-40FE-B568-6CD2D1401C29}']
    procedure ReproduzirPlaylist;
  end;

  ITelefone = interface
    ['{92D8D251-D30B-4545-8259-57EB653DE52A}']
    procedure Telefonar;
  end;

  TCameraFotografica = class(TInterfacedObject, ICameraFotografica)
  public
    procedure TirarFoto;
  end;

  TTelefone = class(TInterfacedObject, ITelefone)
  public
    procedure Telefonar;
  end;

  TSmartphone = class(TTelefone, ICameraFotografica, IMp3Player)
  strict private
    FCameraFotografica: ICameraFotografica;

    property CameraFotografica: ICameraFotografica read FCameraFotografica implements ICameraFotografica;
  public
    procedure ReproduzirPlaylist;
  end;



implementation


{ TCameraFotografica }

procedure TCameraFotografica.TirarFoto;
begin

end;

{ TTelefone }

procedure TTelefone.Telefonar;
begin

end;

{ TSmartphone }

procedure TSmartphone.ReproduzirPlaylist;
begin

end;

end.
