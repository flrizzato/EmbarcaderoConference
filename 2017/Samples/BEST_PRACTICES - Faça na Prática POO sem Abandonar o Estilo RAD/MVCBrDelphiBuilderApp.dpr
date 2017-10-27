program MVCBrDelphiBuilderApp;

// Código gerado pelo Assistente MVCBr OTA
// www.tireideletra.com.br
// Amarildo Lacerda & Grupo MVCBr-2017

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Forms,
  MVCBr.ApplicationController,
  MVCBr.Controller,
  NewMVCApp.Controller in 'Controllers\NewMVCApp.Controller.pas',
  NewMVCApp.Controller.Interf in 'Controllers\NewMVCApp.Controller.Interf.pas',
  NewMVCAppView in 'Views\NewMVCAppView.pas' {NewMVCAppView},
  View2.Controller.Interf in 'Controllers\View2.Controller.Interf.pas',
  View2.Controller in 'Controllers\View2.Controller.pas',
  View2View in 'Views\View2View.pas' {View2View},
  ACBrValidador.Model in '..\..\..\AdIN\ACBr\ACBrValidador.Model.pas',
  ACBrValidador.Model.Interf in '..\..\..\AdIN\ACBr\ACBrValidador.Model.Interf.pas',
  WinNotification.Model in '..\..\..\AdIN\Windows\WinNotification.Model.pas',
  WinNotification.Model.Interf in '..\..\..\AdIN\Windows\WinNotification.Model.Interf.pas',
  ORMCadastroGrupos.PersistentModel in 'Models\ORMCadastroGrupos.PersistentModel.pas',
  ORMCadastroGrupos.PersistentModel.Interf in 'Models\ORMCadastroGrupos.PersistentModel.Interf.pas',
  CadastroGrupo.Controller.Interf in 'Controllers\CadastroGrupo.Controller.Interf.pas',
  CadastroGrupo.Controller in 'Controllers\CadastroGrupo.Controller.pas',
  CadastroGrupoView in 'Views\CadastroGrupoView.pas' {CadastroGrupoView};

{$R *.res}

function CheckApplicationAuth: boolean;
begin
  // retornar True se o applicatio pode ser carregado
  //          False se não foi autorizado inicialização
  result := true;
end;

begin
/// Inicializa o Controller e Roda o MainForm
if CheckApplicationAuth then
  ApplicationController.Run(TNewMVCAppController.New);
end.

