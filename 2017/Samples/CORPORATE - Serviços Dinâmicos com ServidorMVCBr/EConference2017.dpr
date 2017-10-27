program EConference2017;

// Código gerado pelo Assistente MVCBr OTA
// www.tireideletra.com.br
// Amarildo Lacerda & Grupo MVCBr-2017
uses
  Forms,
  Vcl.Themes,
  Vcl.Styles,
  System.SysUtils,
  MVCBr.ApplicationController,
  MVCBr.Controller,
  EConference2017.Controller in 'Controllers\EConference2017.Controller.pas',
  EConference2017.Controller.Interf in 'Controllers\EConference2017.Controller.Interf.pas',
  EConference2017.View in 'Views\EConference2017.View.pas' {EConference2017View},
  EConference2017.ViewModel in 'ViewModels\EConference2017.ViewModel.pas',
  EConference2017.ViewModel.Interf in 'Models\EConference2017.ViewModel.Interf.pas';

{$R *.res}

var vArq: string;
begin

   if FileExists('..\..\AmethystKamri.vsf') then
      vArq := '..\..\AmethystKamri.vsf'
   else
       vArq := 'AmethystKamri.vsf';
   TStyleManager.LoadFromFile(vArq);
   TStyleManager.TrySetStyle('Amethyst Kamri');


  // Inicializa o Controller e Roda o MainForm
  ApplicationController.Run(TEConference2017Controller.New,
    function :boolean
    begin
      // retornar True se o applicatio pode ser carregado
      //          False se não foi autorizado inicialização
      result := true;
    end);
end.
