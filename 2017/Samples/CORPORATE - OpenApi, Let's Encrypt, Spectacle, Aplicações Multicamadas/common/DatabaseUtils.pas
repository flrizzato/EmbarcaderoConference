unit DatabaseUtils;

interface

uses
  Aurelius.Criteria.Base,
  Aurelius.Drivers.Interfaces,
  Aurelius.Engine.DatabaseManager,
  Aurelius.Engine.ObjectManager,
  AureliusEntities;

procedure UpdateDatabase(Conn: IDBConnection);

implementation

procedure SaveAllObjects(M: TObjectManager);
var
  Rock, Alternative: TGenre;
  Led, Nirvana, REM: TArtist;
  LedIV, Presence, Nevermind, OutOfTime: TAlbum;
begin
  Rock := TGenre.Create('Rock');
  Alternative := TGenre.Create('Alternative');

  Led := TArtist.Create('Led Zeppelin');
  Nirvana := TArtist.Create('Nirvana');
  REM := TArtist.Create('R.E.M.');

  LedIV := TAlbum.Create('Led Zeppelin IV', Led);
  LedIV.Tracks.Add(TTrack.Create('Black Dog', Rock, 'Jimmy Page, Robert Plant, John Paul Jones', 296672));
  LedIV.Tracks.Add(TTrack.Create('Rock & Roll', Rock, 'Jimmy Page, Robert Plant, John Paul Jones, John Bonam', 220917));
  LedIV.Tracks.Add(TTrack.Create('The Battle of Evermore', Rock, 'Jimmy Page, Robert Plant', 351555));
  LedIV.Tracks.Add(TTrack.Create('Stairway to Heaven', Rock, 'Jimmy Page, Robert Plant', 481619));
  LedIV.Tracks.Add(TTrack.Create('Misty Mountain Hop', Rock, 'Jimmy Page, Robert Plant, John Paul Jones', 278857));
  LedIV.Tracks.Add(TTrack.Create('Four Sticks', Rock, 'Jimmy Page, Robert Plant', 284447));
  LedIV.Tracks.Add(TTrack.Create('Going to California', Rock, 'Jimmy Page, Robert Plant', 215693));
  LedIV.Tracks.Add(TTrack.Create('When the Levee Breaks', Rock, 'Jimmy Page, Robert Plant, John Paul Jones, John Bonhan, Memphis Minnie', 427702));
  M.Save(LedIV);

  Presence := TAlbum.Create('Presence', Led);
  Presence.Tracks.Add(TTrack.Create('Achilles Last Stand', Rock, 'Jimmy Page, Robert Plant', 625502));
  Presence.Tracks.Add(TTrack.Create('For Your Life', Rock, 'Jimmy Page, Robert Plant', 384391));
  Presence.Tracks.Add(TTrack.Create('Royal Orleans', Rock, 'John Bonham, John Paul Jones', 179591));
  Presence.Tracks.Add(TTrack.Create('Nobody''s Fault But Mine', Rock, 'Jimmy Page, Robert Plant', 376215));
  Presence.Tracks.Add(TTrack.Create('Candy Store Rock', Rock, 'Jimmy Page, Robert Plant', 252055));
  Presence.Tracks.Add(TTrack.Create('Hots On For Nowhere', Rock, 'Jimmy Page, Robert Plant', 284107));
  Presence.Tracks.Add(TTrack.Create('Tea For One', Rock, 'Jimmy Page, Robert Plant', 566752));
  M.Save(Presence);

  Nevermind := TAlbum.Create('Nevermind', Nirvana);
  Nevermind.Tracks.Add(TTrack.Create('Smells Like Teen Spirit', Rock, 'Kurt Cobain', 301296));
  Nevermind.Tracks.Add(TTrack.Create('In Bloom', Rock, 'Kurt Cobain', 254928));
  Nevermind.Tracks.Add(TTrack.Create('Come As You Are', Rock, 'Kurt Cobain', 219219));
  Nevermind.Tracks.Add(TTrack.Create('Breed', Rock, 'Kurt Cobain', 183928));
  Nevermind.Tracks.Add(TTrack.Create('Lithium', Rock, 'Kurt Cobain', 256992));
  Nevermind.Tracks.Add(TTrack.Create('Polly', Rock, 'Kurt Cobain', 177031));
  Nevermind.Tracks.Add(TTrack.Create('Territorial Pissings', Rock, 'Kurt Cobain', 143281));
  Nevermind.Tracks.Add(TTrack.Create('Drain You', Rock, 'Kurt Cobain', 223973));
  Nevermind.Tracks.Add(TTrack.Create('Lounge Act', Rock, 'Kurt Cobain', 156786));
  Nevermind.Tracks.Add(TTrack.Create('Stay Away', Rock, 'Kurt Cobain', 212636));
  Nevermind.Tracks.Add(TTrack.Create('On a Plain', Rock, 'Kurt Cobain', 196440));
  Nevermind.Tracks.Add(TTrack.Create('Something In The Way', Rock, 'Kurt Cobain', 230556));
  M.Save(Nevermind);

  OutOfTime := TAlbum.Create('Out of Time', REM);
  OutOfTime.Tracks.Add(TTrack.Create('Shiny Happy People', Alternative, 'Bill Berry/Michael Stipe/Mike Mills/Peter Buck', 226298));
  OutOfTime.Tracks.Add(TTrack.Create('Me In Honey', Alternative, 'Bill Berry/Michael Stipe/Mike Mills/Peter Buck', 246674));
  OutOfTime.Tracks.Add(TTrack.Create('Radio Song', Alternative, 'Bill Berry/Michael Stipe/Mike Mills/Peter Buck', 255477));
  OutOfTime.Tracks.Add(TTrack.Create('Losing My Religion', Alternative, 'Bill Berry/Michael Stipe/Mike Mills/Peter Buck', 269035));
  OutOfTime.Tracks.Add(TTrack.Create('Low', Alternative, 'Bill Berry/Michael Stipe/Mike Mills/Peter Buck', 296777));
  OutOfTime.Tracks.Add(TTrack.Create('Near Wild Heaven', Alternative, 'Bill Berry/Michael Stipe/Mike Mills/Peter Buck', 199862));
  OutOfTime.Tracks.Add(TTrack.Create('Endgame', Alternative, 'Bill Berry/Michael Stipe/Mike Mills/Peter Buck', 230687));
  OutOfTime.Tracks.Add(TTrack.Create('Belong', Alternative, 'Bill Berry/Michael Stipe/Mike Mills/Peter Buck', 247013));
  OutOfTime.Tracks.Add(TTrack.Create('Half A World Away', Alternative, 'Bill Berry/Michael Stipe/Mike Mills/Peter Buck', 208431));
  OutOfTime.Tracks.Add(TTrack.Create('Texarkana', Alternative, 'Bill Berry/Michael Stipe/Mike Mills/Peter Buck', 220081));
  OutOfTime.Tracks.Add(TTrack.Create('Country Feedback', Alternative, 'Bill Berry/Michael Stipe/Mike Mills/Peter Buck', 249782));
  M.Save(OutOfTime);
end;

procedure UpdateDatabase(Conn: IDBConnection);
var
  DB: TDatabaseManager;
  Manager: TObjectManager;
  Trans: IDBTransaction;
begin
  DB := TDatabaseManager.Create(Conn);
  try
    DB.UpdateDatabase;
  finally
    DB.Free;
  end;

  Manager := TObjectManager.Create(Conn);
  try
    // Simple test that works for this demo (might fail in production environments):
    // try to find an artist from database, if no artist, then add all objects
    if Manager.Find<TArtist>.Take(1).UniqueResult = nil then
    begin
      Trans := conn.BeginTransaction;
      try
        SaveAllObjects(Manager);
        Trans.Commit;
      except
        Trans.Rollback;
        raise;
      end;
    end;
  finally
    Manager.Free;
  end;
end;

end.
