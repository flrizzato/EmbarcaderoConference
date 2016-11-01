unit uFramework;

interface

uses
  System.Generics.Collections;

type
 IObserver = interface
   procedure Atualizar();
 end;

 TSubject = class abstract
 strict private
   FObservers: TList<IObserver>;
 public
   constructor Create();
   procedure Attach(AObserver: IObserver);
   procedure Detach(AObserver: IObserver);
   procedure Notificar();
 end;

 // Observado
 TBalanco = class (TSubject)
 strict private
   FBalancoEmAndamento: boolean;
 public
   function getBalancoEmAndamento(): boolean;
   procedure Iniciar();
   procedure Finalizar();
 end;

 // Observador
 TVenda = class (TInterfacedObject, IObserver)
 strict private
   FBalanco: TBalanco;
   FBalancoEmAndamento: boolean;
 public
   procedure Iniciar();
   procedure Finalizar();
   procedure Atualizar();
   procedure SetBalanco(ABalanco: TBalanco);
 end;


implementation

{ TSubject }

procedure TSubject.Attach(AObserver: IObserver);
begin
  FObservers.Add(AObserver);
end;

constructor TSubject.Create();
begin
  Self.FObservers := TList<IObserver>.Create();

end;

procedure TSubject.Detach(AObserver: IObserver);
begin
  FObservers.Remove(AObserver);
end;

procedure TSubject.Notificar();
var
  each: IObserver;
begin
  for each in FObservers do
    each.Atualizar();
end;

{ TBalanco }

procedure TBalanco.Finalizar();
begin
  Writeln('Balanço finalizado');
  FBalancoEmAndamento := false;
  Notificar();
end;

function TBalanco.getBalancoEmAndamento(): boolean;
begin
  exit(FBalancoEmAndamento);
end;

procedure TBalanco.Iniciar();
begin
  Writeln('Balanço iniciado');
  FBalancoEmAndamento := true;
  Notificar();
end;

{ TVenda }

procedure TVenda.Atualizar();
begin
  FBalancoEmAndamento := FBalanco.getBalancoEmAndamento();
end;

procedure TVenda.Finalizar();
begin
  WriteLn('Venda finalizada');
end;

procedure TVenda.Iniciar();
begin
  if FBalancoEmAndamento then
    WriteLn('Não posso iniciar venda com balanço em andamento')
  else
    WriteLn('Venda inicada');
end;

procedure TVenda.SetBalanco(ABalanco: TBalanco);
begin
  self.FBalanco := ABalanco;
end;

end.
