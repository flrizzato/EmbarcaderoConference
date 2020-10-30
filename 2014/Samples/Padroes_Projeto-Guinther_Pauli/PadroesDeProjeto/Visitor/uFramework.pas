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
  Generics.Collections;

type

  // forwards
  ConcreteElementA = class;
  ConcreteElementB = class;

  // "Visitor"
  Visitor = class abstract
    public procedure VisitConcreteElementA(
      concreteElementA: ConcreteElementA); virtual; abstract;
    public procedure VisitConcreteElementB(
      concreteElementB: ConcreteElementB); virtual; abstract;
  end;

  // "ConcreteVisitor1"
  ConcreteVisitor1 = class(Visitor)
    public procedure VisitConcreteElementA(
      concreteElementA: ConcreteElementA); override;
    public procedure VisitConcreteElementB(
      concreteElementB: ConcreteElementB); override;
  end;

    // "ConcreteVisitor2"
  ConcreteVisitor2 = class(Visitor)
    public procedure VisitConcreteElementA(
      concreteElementA: ConcreteElementA); override;
    public procedure VisitConcreteElementB(
      concreteElementB: ConcreteElementB); override;
  end;

  // "Element"
  Element = class abstract
    public procedure Accept(visitor: Visitor); virtual; abstract;
  end;

  // "ConcreteElementA"
  ConcreteElementA = class(Element)
    public procedure Accept(visitor: Visitor); override;
    public procedure OperationA();
  end;

   // "ConcreteElementB"
  ConcreteElementB = class(Element)
    public procedure Accept(visitor: Visitor); override;
    public procedure OperationB();
  end;

  // "ObjectStructure"
  ObjectStructure = class
    private elements: TList<Element>;
    public procedure Attach(element: Element);
    public procedure DeAttach(element: Element);
    public procedure Accept(visitor: Visitor);
    public constructor Create();
    public destructor Destroy(); override;
  end;

implementation

uses
  System.SysUtils;

{ ConcreteVisitor1 }

procedure ConcreteVisitor1.VisitConcreteElementA(
  concreteElementA: ConcreteElementA);
begin
  Writeln(Format('%s visited by %s',
    [concreteElementA.ClassType.ClassName,
    self.ClassType.ClassName]));
end;

procedure ConcreteVisitor1.VisitConcreteElementB(
  concreteElementB: ConcreteElementB);
begin
  Writeln(Format('%s visited by %s',
    [concreteElementB.ClassType.ClassName,
    self.ClassType.ClassName]));
end;

{ ConcreteVisitor2 }

procedure ConcreteVisitor2.VisitConcreteElementA(
  concreteElementA: ConcreteElementA);
begin
  Writeln(Format('%s visited by %s',
    [concreteElementA.ClassType.ClassName,
    self.ClassType.ClassName]));
end;

procedure ConcreteVisitor2.VisitConcreteElementB(
  concreteElementB: ConcreteElementB);
begin
 Writeln(Format('%s visited by %s',
    [concreteElementB.ClassType.ClassName,
    self.ClassType.ClassName]));
end;

{ ConcreteElementA }

procedure ConcreteElementA.Accept(visitor: Visitor);
begin
  visitor.VisitConcreteElementA(self);
end;

procedure ConcreteElementA.OperationA();
begin
  Writeln('ConcreteElementA.OperationA()');
end;

{ ConcreteElementB }

procedure ConcreteElementB.Accept(visitor: Visitor);
begin
  visitor.VisitConcreteElementB(self);
end;

procedure ConcreteElementB.OperationB();
begin
  Writeln('ConcreteElementB.OperationB()');
end;

{ ObjectStructure }

procedure ObjectStructure.Accept(visitor: Visitor);
var
  e: Element;
begin
  for e in self.elements do
    e.Accept(visitor);
 end;

procedure ObjectStructure.Attach(element: Element);
begin
  self.elements.Add(element);
end;

constructor ObjectStructure.Create();
begin
 self.elements := TList<Element>.Create();
end;

procedure ObjectStructure.DeAttach(element: Element);
begin
  self.elements.Remove(element);
end;

destructor ObjectStructure.Destroy();
begin
  self.elements.Free();
  inherited;
end;

end.
