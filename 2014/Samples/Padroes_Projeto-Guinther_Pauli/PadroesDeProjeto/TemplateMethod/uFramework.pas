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

type
  // Abstract Class
  Correcao = class abstract
    public procedure Corrigir(); virtual; abstract;
    public procedure VerificarPrerequisitos(); virtual; abstract;
    public procedure EnviarDadosParaBancoDeDados(); virtual; abstract;
    public procedure LimparCorrecoesAnteriores(); virtual; abstract;
    public procedure Iniciar(); virtual; abstract;
    // Template Method
    public procedure Processar();
  end;

  CorrecaoProva = class(Correcao)
    public procedure Corrigir(); override;
    public procedure VerificarPrerequisitos(); override;
    public procedure EnviarDadosParaBancoDeDados(); override;
    public procedure LimparCorrecoesAnteriores(); override;
    public procedure Iniciar(); override;
  end;

  CorrecaoRedacao = class(Correcao)
    public procedure Corrigir(); override;
    public procedure VerificarPrerequisitos(); override;
    public procedure EnviarDadosParaBancoDeDados(); override;
    public procedure LimparCorrecoesAnteriores(); override;
    public procedure Iniciar(); override;
  end;

  CorrecaoInscricao = class(Correcao)
    public procedure Corrigir(); override;
    public procedure VerificarPrerequisitos(); override;
    public procedure EnviarDadosParaBancoDeDados(); override;
    public procedure LimparCorrecoesAnteriores(); override;
    public procedure Iniciar(); override;
  end;


implementation

{ Correcao }

procedure Correcao.Processar;
begin
  // orquesta a chama de métodos virtuais
  Iniciar();
  VerificarPrerequisitos();
  LimparCorrecoesAnteriores();
  Corrigir();
  EnviarDadosParaBancoDeDados();
end;

{ CorrecaoProva }

procedure CorrecaoProva.Corrigir();
begin
  Writeln('Corrigindo prova...');
end;

procedure CorrecaoProva.EnviarDadosParaBancoDeDados();
begin
  Writeln('Enviando dados da prova para o BD...');
end;

procedure CorrecaoProva.Iniciar();
begin
  Writeln('Iniciando processo de correção da prova...');
end;

procedure CorrecaoProva.LimparCorrecoesAnteriores();
begin
  Writeln('Limpando dados de correções anteriores de provas...');
end;

procedure CorrecaoProva.VerificarPrerequisitos();
begin
  Writeln('Verificando pré-requisitos para correção da prova...');
end;

{ CorrecaoRedacao }

procedure CorrecaoRedacao.Corrigir();
begin
  Writeln('Corrigindo redação pela nota...');
end;

procedure CorrecaoRedacao.EnviarDadosParaBancoDeDados();
begin
  Writeln('Enviando dados da redação para o BD...');
end;

procedure CorrecaoRedacao.Iniciar();
begin
   Writeln('Iniciando processo de correção da redação...');
end;

procedure CorrecaoRedacao.LimparCorrecoesAnteriores();
begin
  Writeln('Limpando dados de correções anteriores de redação...');
end;

procedure CorrecaoRedacao.VerificarPrerequisitos();
begin
  Writeln('Verificando pré-requisitos para correação da redação...');
end;

{ CorrecaoInscricao }

procedure CorrecaoInscricao.Corrigir();
begin
  Writeln('Processando inscrição...');
end;

procedure CorrecaoInscricao.EnviarDadosParaBancoDeDados();
begin
  Writeln('Enviando dados da inscrição para o BD...');
end;

procedure CorrecaoInscricao.Iniciar();
begin
   Writeln('Iniciando processo de inscrição...');
end;

procedure CorrecaoInscricao.LimparCorrecoesAnteriores();
begin
  Writeln('Limpando dados de inscrições anteriores...');
end;

procedure CorrecaoInscricao.VerificarPrerequisitos();
begin
  Writeln('Verificando pré-requisitos para inscrição...');
end;

end.
