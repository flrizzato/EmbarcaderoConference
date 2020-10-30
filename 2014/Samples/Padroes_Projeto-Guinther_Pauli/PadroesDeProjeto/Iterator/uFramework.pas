{
Sobre o autor:
Guinther Pauli
Delphi Certified Professional - 3,5,6,7,2005,2006,Delphi Web,Kylix,XE
Microsoft Certified Professional - MCP,MCAD,MCSD.NET,MCTS,MCPD (C#, ASP.NET, Arquitetura)
Colaborador Editorial Revistas .net Magazine e ClubeDelphi
MVP (Most Valuable Professional) - Embarcadero Technologies - US
http://gpauli.com
http://www.facebook.com/guintherpauli
http://www.twitter.com/guintherpauli
http://br.linkedin.com/in/guintherpauli
}

unit uFramework;

interface

uses
  System.Contnrs;

type

  TCliente = class
    private _id: integer;
    private _nome: string;
    private procedure SetID(const Value: integer);
    private procedure SetNome(const Value: string);
    private function GetID: integer;
    private function GetNome: string;
    public property ID: integer read GetID write SetID;
    public property Nome: string read GetNome write SetNome;
    public constructor Create(ID: integer; Nome: string);
  end;

  TClienteList = class
    private _items: TObjectList;
    public procedure Add(const Item: TCliente);
    public procedure Insert(Idx: Integer; const Item: TCliente);
    public procedure Delete(Idx: Integer);
    public procedure Remove(const Item: TCliente);
    public procedure Clear();
    public function Contains(const Item: TCliente): Boolean;
    public function GetCount: Integer;
    public function GetItem(Idx: Integer): TCliente;
    public constructor Create();
    public destructor Destroy();
  end;

  TClienteIterator = class
    private _list: TClienteList;
    private _currentItem: Integer;
    public procedure Reset();
    public function Next(): Boolean;
    public function CurrentItem: TCliente;
    public constructor Create(const List: TClienteList);
  end;

implementation

{ TClienteIterator }

constructor TClienteIterator.Create(const List: TClienteList);
begin
  inherited Create;
  self._list := List;
  self.Reset();
end;

function TClienteIterator.CurrentItem(): TCliente;
begin
  if (self._list <> nil) and ((self._currentItem >= 0) and
     (self._currentItem < self._list.GetCount)) then
    result := _list.GetItem(self._currentItem)
  else
    result := nil;
end;

function TClienteIterator.Next(): Boolean;
begin
  result := (self._list <> nil) and
    (self._currentItem < (self._list.GetCount - 1));
  if result then
    Inc(self._currentItem);
end;

procedure TClienteIterator.Reset();
begin
  self._currentItem := -1;
end;

{ TCliente }

constructor TCliente.Create(ID: integer; Nome: string);
begin
  self._id := ID;
  self._nome := Nome;
end;

function TCliente.GetID(): integer;
begin
  result := self._id;
end;

function TCliente.GetNome(): string;
begin
  result := self._nome;
end;

procedure TCliente.SetID(const Value: integer);
begin
  self._id := Value;
end;

procedure TCliente.SetNome(const Value: string);
begin
  self._nome := Value;
end;

{ TClienteList }

procedure TClienteList.Add(const Item: TCliente);
begin
  self._items.Add(item);
end;

procedure TClienteList.Clear();
begin
   self._items.Clear();
end;

function TClienteList.Contains(const Item: TCliente): Boolean;
begin
  result := self._items.IndexOf(item) >= 0;
end;

constructor TClienteList.Create();
begin
  self._items := TObjectList.Create();
end;

procedure TClienteList.Delete(Idx: Integer);
begin
  self._items.Delete(Idx);
end;

destructor TClienteList.Destroy;
begin
  self._items.Free();
  inherited;
end;

function TClienteList.GetCount(): Integer;
begin
  result := self._items.Count;
end;

function TClienteList.GetItem(Idx: Integer): TCliente;
begin
  result := self._items[Idx] as TCliente;
end;

procedure TClienteList.Insert(Idx: Integer; const Item: TCliente);
begin
  self._items.Insert(Idx,Item);
end;

procedure TClienteList.Remove(const Item: TCliente);
begin
  self._items.Remove(item);
end;

end.
