//
// Created by the DataSnap proxy generator.
// 07/07/2018 10:49:01
//

unit ccPush;

interface

uses System.JSON, Datasnap.DSProxyRest, Datasnap.DSClientRest, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap, Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB, Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.DBXJSONReflect;

type
  TServerMethods1Client = class(TDSAdminRestClient)
  private
    FEchoStringCommand: TDSRestCommand;
    FReverseStringCommand: TDSRestCommand;
    FAutenticacaoCommand: TDSRestCommand;
    FAutenticacaoCommand_Cache: TDSRestCommand;
    FGetClientesCommand: TDSRestCommand;
    FGetClientesCommand_Cache: TDSRestCommand;
    FInsertClientesCommand: TDSRestCommand;
    FDeleteClientesCommand: TDSRestCommand;
    FUpdateClientesCommand: TDSRestCommand;
    FGetChamadasEmEsperaCommand: TDSRestCommand;
    FGetChamadasEmEsperaCommand_Cache: TDSRestCommand;
    FInsertChamadasEmEsperaCommand: TDSRestCommand;
    FDeleteChamadasEmEsperaCommand: TDSRestCommand;
    FUpdateChamadasEmEsperaCommand: TDSRestCommand;
    FAtualizaChaveMedicoCommand: TDSRestCommand;
    FFinalizaAntendimentoCommand: TDSRestCommand;
    FGetChatCommand: TDSRestCommand;
    FGetChatCommand_Cache: TDSRestCommand;
    FInsertChatCommand: TDSRestCommand;
    FDeleteChatCommand: TDSRestCommand;
    FUpdateChatCommand: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function EchoString(Value: string; const ARequestFilter: string = ''): string;
    function ReverseString(Value: string; const ARequestFilter: string = ''): string;
    function Autenticacao(vAplicacao: string; vSenha: string; const ARequestFilter: string = ''): TJSONArray;
    function Autenticacao_Cache(vAplicacao: string; vSenha: string; const ARequestFilter: string = ''): IDSRestCachedJSONArray;
    function GetClientes(vTicket: string; vIdClientes: Integer; vChaveEspecialidades: Integer; vNome: string; vCPF: string; vTipo: string; vLogin: string; const ARequestFilter: string = ''): TJSONArray;
    function GetClientes_Cache(vTicket: string; vIdClientes: Integer; vChaveEspecialidades: Integer; vNome: string; vCPF: string; vTipo: string; vLogin: string; const ARequestFilter: string = ''): IDSRestCachedJSONArray;
    function InsertClientes(vTicket: string; NewCliente: string; const ARequestFilter: string = ''): string;
    function DeleteClientes(vTicket: string; OldCliente: string; const ARequestFilter: string = ''): string;
    function UpdateClientes(vTicket: string; OldCliente: string; NewCliente: string; const ARequestFilter: string = ''): string;
    function GetChamadasEmEspera(vTicket: string; vEmEspera: string; vIP_Origem: string; vIP_Destino: string; vChavePaciente: Integer; vChaveEspecialidades: Integer; vChamada: TDateTime; vEncerrada: TDateTime; vChaveMedico: Integer; vInicioDoAtendimento: TDateTime; vFimDoAtendimento: TDateTime; const ARequestFilter: string = ''): TJSONArray;
    function GetChamadasEmEspera_Cache(vTicket: string; vEmEspera: string; vIP_Origem: string; vIP_Destino: string; vChavePaciente: Integer; vChaveEspecialidades: Integer; vChamada: TDateTime; vEncerrada: TDateTime; vChaveMedico: Integer; vInicioDoAtendimento: TDateTime; vFimDoAtendimento: TDateTime; const ARequestFilter: string = ''): IDSRestCachedJSONArray;
    function InsertChamadasEmEspera(vTicket: string; vObjJSON: string; const ARequestFilter: string = ''): string;
    function DeleteChamadasEmEspera(vTicket: string; vObjJSON: string; const ARequestFilter: string = ''): string;
    function UpdateChamadasEmEspera(vTicket: string; vObjJSON: string; const ARequestFilter: string = ''): string;
    function AtualizaChaveMedico(vTicket: string; vObjJSON: string; const ARequestFilter: string = ''): string;
    function FinalizaAntendimento(vTicket: string; vObjJSON: string; const ARequestFilter: string = ''): string;
    function GetChat(vTicket: string; vJaLida: string; vIdChat: Integer; vChaveChamada: Integer; vChavePaciente: Integer; vChaveMedico: Integer; vDataEnvio: TDateTime; const ARequestFilter: string = ''): TJSONArray;
    function GetChat_Cache(vTicket: string; vJaLida: string; vIdChat: Integer; vChaveChamada: Integer; vChavePaciente: Integer; vChaveMedico: Integer; vDataEnvio: TDateTime; const ARequestFilter: string = ''): IDSRestCachedJSONArray;
    function InsertChat(vTicket: string; vObjJSON: string; const ARequestFilter: string = ''): string;
    function DeleteChat(vTicket: string; vObjJSON: string; const ARequestFilter: string = ''): string;
    function UpdateChat(vTicket: string; vObjJSON: string; const ARequestFilter: string = ''): string;
  end;

  TdsmClientesClient = class(TDSAdminRestClient)
  private
    FFDConnectionBeforeConnectCommand: TDSRestCommand;
    FAutenticacaoCommand: TDSRestCommand;
    FAutenticacaoCommand_Cache: TDSRestCommand;
    FGetClientesCommand: TDSRestCommand;
    FGetClientesCommand_Cache: TDSRestCommand;
    FInsertClientesCommand: TDSRestCommand;
    FDeleteClientesCommand: TDSRestCommand;
    FUpdateClientesCommand: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    procedure FDConnectionBeforeConnect(Sender: TObject);
    function Autenticacao(vAplicacao: string; vSenha: string; const ARequestFilter: string = ''): TJSONArray;
    function Autenticacao_Cache(vAplicacao: string; vSenha: string; const ARequestFilter: string = ''): IDSRestCachedJSONArray;
    function GetClientes(vTicket: string; vIdClientes: Integer; vChaveEspecialidades: Integer; vNome: string; vCPF: string; vTipo: string; vLogin: string; const ARequestFilter: string = ''): TJSONArray;
    function GetClientes_Cache(vTicket: string; vIdClientes: Integer; vChaveEspecialidades: Integer; vNome: string; vCPF: string; vTipo: string; vLogin: string; const ARequestFilter: string = ''): IDSRestCachedJSONArray;
    function InsertClientes(vTicket: string; NewClient: string; const ARequestFilter: string = ''): string;
    function DeleteClientes(vTicket: string; OldClient: string; const ARequestFilter: string = ''): string;
    function UpdateClientes(vTicket: string; OldClient: string; NewClient: string; const ARequestFilter: string = ''): string;
  end;

  TdsmChamadasEmEsperaClient = class(TDSAdminRestClient)
  private
    FFDConnectionBeforeConnectCommand: TDSRestCommand;
    FAutenticacaoCommand: TDSRestCommand;
    FAutenticacaoCommand_Cache: TDSRestCommand;
    FGetChamadasEmEsperaCommand: TDSRestCommand;
    FGetChamadasEmEsperaCommand_Cache: TDSRestCommand;
    FInsertChamadasEmEsperaCommand: TDSRestCommand;
    FDeleteChamadasEmEsperaCommand: TDSRestCommand;
    FUpdateChamadasEmEsperaCommand: TDSRestCommand;
    FAtualizaChaveMedicoCommand: TDSRestCommand;
    FFinalizaAntendimentoCommand: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    procedure FDConnectionBeforeConnect(Sender: TObject);
    function Autenticacao(vAplicacao: string; vSenha: string; const ARequestFilter: string = ''): TJSONArray;
    function Autenticacao_Cache(vAplicacao: string; vSenha: string; const ARequestFilter: string = ''): IDSRestCachedJSONArray;
    function GetChamadasEmEspera(vTicket: string; vEmEspera: string; vIP_Origem: string; vIP_Destino: string; vChavePaciente: Integer; vChaveEspecialidades: Integer; vChamada: TDateTime; vEncerrada: TDateTime; vChaveMedico: Integer; vInicioDoAtendimento: TDateTime; vFimDoAtendimento: TDateTime; const ARequestFilter: string = ''): TJSONArray;
    function GetChamadasEmEspera_Cache(vTicket: string; vEmEspera: string; vIP_Origem: string; vIP_Destino: string; vChavePaciente: Integer; vChaveEspecialidades: Integer; vChamada: TDateTime; vEncerrada: TDateTime; vChaveMedico: Integer; vInicioDoAtendimento: TDateTime; vFimDoAtendimento: TDateTime; const ARequestFilter: string = ''): IDSRestCachedJSONArray;
    function InsertChamadasEmEspera(vTicket: string; vObjJSON: string; const ARequestFilter: string = ''): string;
    function DeleteChamadasEmEspera(vTicket: string; vObjJSON: string; const ARequestFilter: string = ''): string;
    function UpdateChamadasEmEspera(vTicket: string; vObjJSON: string; const ARequestFilter: string = ''): string;
    function AtualizaChaveMedico(vTicket: string; vObjJSON: string; const ARequestFilter: string = ''): string;
    function FinalizaAntendimento(vTicket: string; vObjJSON: string; const ARequestFilter: string = ''): string;
  end;

  TdsmChatClient = class(TDSAdminRestClient)
  private
    FFDConnectionBeforeConnectCommand: TDSRestCommand;
    FAutenticacaoCommand: TDSRestCommand;
    FAutenticacaoCommand_Cache: TDSRestCommand;
    FGetChatCommand: TDSRestCommand;
    FGetChatCommand_Cache: TDSRestCommand;
    FInsertChatCommand: TDSRestCommand;
    FDeleteChatCommand: TDSRestCommand;
    FUpdateChatCommand: TDSRestCommand;
  public
    constructor Create(ARestConnection: TDSRestConnection); overload;
    constructor Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    procedure FDConnectionBeforeConnect(Sender: TObject);
    function Autenticacao(vAplicacao: string; vSenha: string; const ARequestFilter: string = ''): TJSONArray;
    function Autenticacao_Cache(vAplicacao: string; vSenha: string; const ARequestFilter: string = ''): IDSRestCachedJSONArray;
    function GetChat(vTicket: string; vJaLida: string; vIdChat: Integer; vChaveChamada: Integer; vChavePaciente: Integer; vChaveMedico: Integer; vDataEnvio: TDateTime; const ARequestFilter: string = ''): TJSONArray;
    function GetChat_Cache(vTicket: string; vJaLida: string; vIdChat: Integer; vChaveChamada: Integer; vChavePaciente: Integer; vChaveMedico: Integer; vDataEnvio: TDateTime; const ARequestFilter: string = ''): IDSRestCachedJSONArray;
    function InsertChat(vTicket: string; vObjJSON: string; const ARequestFilter: string = ''): string;
    function DeleteChat(vTicket: string; vObjJSON: string; const ARequestFilter: string = ''): string;
    function UpdateChat(vTicket: string; vObjJSON: string; const ARequestFilter: string = ''): string;
  end;

const
  TServerMethods1_EchoString: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Value'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_ReverseString: array [0..1] of TDSRestParameterMetaData =
  (
    (Name: 'Value'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_Autenticacao: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'vAplicacao'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vSenha'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TJSONArray')
  );

  TServerMethods1_Autenticacao_Cache: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'vAplicacao'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vSenha'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods1_GetClientes: array [0..7] of TDSRestParameterMetaData =
  (
    (Name: 'vTicket'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vIdClientes'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'vChaveEspecialidades'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'vNome'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vCPF'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vTipo'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vLogin'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TJSONArray')
  );

  TServerMethods1_GetClientes_Cache: array [0..7] of TDSRestParameterMetaData =
  (
    (Name: 'vTicket'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vIdClientes'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'vChaveEspecialidades'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'vNome'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vCPF'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vTipo'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vLogin'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods1_InsertClientes: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'vTicket'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'NewCliente'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_DeleteClientes: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'vTicket'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'OldCliente'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_UpdateClientes: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'vTicket'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'OldCliente'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'NewCliente'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_GetChamadasEmEspera: array [0..11] of TDSRestParameterMetaData =
  (
    (Name: 'vTicket'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vEmEspera'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vIP_Origem'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vIP_Destino'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vChavePaciente'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'vChaveEspecialidades'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'vChamada'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: 'vEncerrada'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: 'vChaveMedico'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'vInicioDoAtendimento'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: 'vFimDoAtendimento'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TJSONArray')
  );

  TServerMethods1_GetChamadasEmEspera_Cache: array [0..11] of TDSRestParameterMetaData =
  (
    (Name: 'vTicket'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vEmEspera'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vIP_Origem'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vIP_Destino'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vChavePaciente'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'vChaveEspecialidades'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'vChamada'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: 'vEncerrada'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: 'vChaveMedico'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'vInicioDoAtendimento'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: 'vFimDoAtendimento'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods1_InsertChamadasEmEspera: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'vTicket'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vObjJSON'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_DeleteChamadasEmEspera: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'vTicket'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vObjJSON'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_UpdateChamadasEmEspera: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'vTicket'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vObjJSON'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_AtualizaChaveMedico: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'vTicket'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vObjJSON'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_FinalizaAntendimento: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'vTicket'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vObjJSON'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_GetChat: array [0..7] of TDSRestParameterMetaData =
  (
    (Name: 'vTicket'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vJaLida'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vIdChat'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'vChaveChamada'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'vChavePaciente'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'vChaveMedico'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'vDataEnvio'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TJSONArray')
  );

  TServerMethods1_GetChat_Cache: array [0..7] of TDSRestParameterMetaData =
  (
    (Name: 'vTicket'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vJaLida'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vIdChat'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'vChaveChamada'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'vChavePaciente'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'vChaveMedico'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'vDataEnvio'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TServerMethods1_InsertChat: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'vTicket'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vObjJSON'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_DeleteChat: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'vTicket'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vObjJSON'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TServerMethods1_UpdateChat: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'vTicket'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vObjJSON'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TdsmClientes_FDConnectionBeforeConnect: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: 'Sender'; Direction: 1; DBXType: 37; TypeName: 'TObject')
  );

  TdsmClientes_Autenticacao: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'vAplicacao'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vSenha'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TJSONArray')
  );

  TdsmClientes_Autenticacao_Cache: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'vAplicacao'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vSenha'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TdsmClientes_GetClientes: array [0..7] of TDSRestParameterMetaData =
  (
    (Name: 'vTicket'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vIdClientes'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'vChaveEspecialidades'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'vNome'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vCPF'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vTipo'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vLogin'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TJSONArray')
  );

  TdsmClientes_GetClientes_Cache: array [0..7] of TDSRestParameterMetaData =
  (
    (Name: 'vTicket'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vIdClientes'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'vChaveEspecialidades'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'vNome'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vCPF'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vTipo'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vLogin'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TdsmClientes_InsertClientes: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'vTicket'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'NewClient'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TdsmClientes_DeleteClientes: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'vTicket'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'OldClient'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TdsmClientes_UpdateClientes: array [0..3] of TDSRestParameterMetaData =
  (
    (Name: 'vTicket'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'OldClient'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'NewClient'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TdsmChamadasEmEspera_FDConnectionBeforeConnect: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: 'Sender'; Direction: 1; DBXType: 37; TypeName: 'TObject')
  );

  TdsmChamadasEmEspera_Autenticacao: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'vAplicacao'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vSenha'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TJSONArray')
  );

  TdsmChamadasEmEspera_Autenticacao_Cache: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'vAplicacao'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vSenha'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TdsmChamadasEmEspera_GetChamadasEmEspera: array [0..11] of TDSRestParameterMetaData =
  (
    (Name: 'vTicket'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vEmEspera'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vIP_Origem'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vIP_Destino'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vChavePaciente'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'vChaveEspecialidades'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'vChamada'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: 'vEncerrada'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: 'vChaveMedico'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'vInicioDoAtendimento'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: 'vFimDoAtendimento'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TJSONArray')
  );

  TdsmChamadasEmEspera_GetChamadasEmEspera_Cache: array [0..11] of TDSRestParameterMetaData =
  (
    (Name: 'vTicket'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vEmEspera'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vIP_Origem'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vIP_Destino'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vChavePaciente'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'vChaveEspecialidades'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'vChamada'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: 'vEncerrada'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: 'vChaveMedico'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'vInicioDoAtendimento'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: 'vFimDoAtendimento'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TdsmChamadasEmEspera_InsertChamadasEmEspera: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'vTicket'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vObjJSON'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TdsmChamadasEmEspera_DeleteChamadasEmEspera: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'vTicket'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vObjJSON'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TdsmChamadasEmEspera_UpdateChamadasEmEspera: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'vTicket'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vObjJSON'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TdsmChamadasEmEspera_AtualizaChaveMedico: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'vTicket'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vObjJSON'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TdsmChamadasEmEspera_FinalizaAntendimento: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'vTicket'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vObjJSON'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TdsmChat_FDConnectionBeforeConnect: array [0..0] of TDSRestParameterMetaData =
  (
    (Name: 'Sender'; Direction: 1; DBXType: 37; TypeName: 'TObject')
  );

  TdsmChat_Autenticacao: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'vAplicacao'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vSenha'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TJSONArray')
  );

  TdsmChat_Autenticacao_Cache: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'vAplicacao'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vSenha'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TdsmChat_GetChat: array [0..7] of TDSRestParameterMetaData =
  (
    (Name: 'vTicket'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vJaLida'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vIdChat'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'vChaveChamada'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'vChavePaciente'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'vChaveMedico'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'vDataEnvio'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TJSONArray')
  );

  TdsmChat_GetChat_Cache: array [0..7] of TDSRestParameterMetaData =
  (
    (Name: 'vTicket'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vJaLida'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vIdChat'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'vChaveChamada'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'vChavePaciente'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'vChaveMedico'; Direction: 1; DBXType: 6; TypeName: 'Integer'),
    (Name: 'vDataEnvio'; Direction: 1; DBXType: 11; TypeName: 'TDateTime'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'String')
  );

  TdsmChat_InsertChat: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'vTicket'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vObjJSON'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TdsmChat_DeleteChat: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'vTicket'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vObjJSON'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

  TdsmChat_UpdateChat: array [0..2] of TDSRestParameterMetaData =
  (
    (Name: 'vTicket'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: 'vObjJSON'; Direction: 1; DBXType: 26; TypeName: 'string'),
    (Name: ''; Direction: 4; DBXType: 26; TypeName: 'string')
  );

implementation

function TServerMethods1Client.EchoString(Value: string; const ARequestFilter: string): string;
begin
  if FEchoStringCommand = nil then
  begin
    FEchoStringCommand := FConnection.CreateCommand;
    FEchoStringCommand.RequestType := 'GET';
    FEchoStringCommand.Text := 'TServerMethods1.EchoString';
    FEchoStringCommand.Prepare(TServerMethods1_EchoString);
  end;
  FEchoStringCommand.Parameters[0].Value.SetWideString(Value);
  FEchoStringCommand.Execute(ARequestFilter);
  Result := FEchoStringCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethods1Client.ReverseString(Value: string; const ARequestFilter: string): string;
begin
  if FReverseStringCommand = nil then
  begin
    FReverseStringCommand := FConnection.CreateCommand;
    FReverseStringCommand.RequestType := 'GET';
    FReverseStringCommand.Text := 'TServerMethods1.ReverseString';
    FReverseStringCommand.Prepare(TServerMethods1_ReverseString);
  end;
  FReverseStringCommand.Parameters[0].Value.SetWideString(Value);
  FReverseStringCommand.Execute(ARequestFilter);
  Result := FReverseStringCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethods1Client.Autenticacao(vAplicacao: string; vSenha: string; const ARequestFilter: string): TJSONArray;
begin
  if FAutenticacaoCommand = nil then
  begin
    FAutenticacaoCommand := FConnection.CreateCommand;
    FAutenticacaoCommand.RequestType := 'GET';
    FAutenticacaoCommand.Text := 'TServerMethods1.Autenticacao';
    FAutenticacaoCommand.Prepare(TServerMethods1_Autenticacao);
  end;
  FAutenticacaoCommand.Parameters[0].Value.SetWideString(vAplicacao);
  FAutenticacaoCommand.Parameters[1].Value.SetWideString(vSenha);
  FAutenticacaoCommand.Execute(ARequestFilter);
  Result := TJSONArray(FAutenticacaoCommand.Parameters[2].Value.GetJSONValue(FInstanceOwner));
end;

function TServerMethods1Client.Autenticacao_Cache(vAplicacao: string; vSenha: string; const ARequestFilter: string): IDSRestCachedJSONArray;
begin
  if FAutenticacaoCommand_Cache = nil then
  begin
    FAutenticacaoCommand_Cache := FConnection.CreateCommand;
    FAutenticacaoCommand_Cache.RequestType := 'GET';
    FAutenticacaoCommand_Cache.Text := 'TServerMethods1.Autenticacao';
    FAutenticacaoCommand_Cache.Prepare(TServerMethods1_Autenticacao_Cache);
  end;
  FAutenticacaoCommand_Cache.Parameters[0].Value.SetWideString(vAplicacao);
  FAutenticacaoCommand_Cache.Parameters[1].Value.SetWideString(vSenha);
  FAutenticacaoCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedJSONArray.Create(FAutenticacaoCommand_Cache.Parameters[2].Value.GetString);
end;

function TServerMethods1Client.GetClientes(vTicket: string; vIdClientes: Integer; vChaveEspecialidades: Integer; vNome: string; vCPF: string; vTipo: string; vLogin: string; const ARequestFilter: string): TJSONArray;
begin
  if FGetClientesCommand = nil then
  begin
    FGetClientesCommand := FConnection.CreateCommand;
    FGetClientesCommand.RequestType := 'GET';
    FGetClientesCommand.Text := 'TServerMethods1.GetClientes';
    FGetClientesCommand.Prepare(TServerMethods1_GetClientes);
  end;
  FGetClientesCommand.Parameters[0].Value.SetWideString(vTicket);
  FGetClientesCommand.Parameters[1].Value.SetInt32(vIdClientes);
  FGetClientesCommand.Parameters[2].Value.SetInt32(vChaveEspecialidades);
  FGetClientesCommand.Parameters[3].Value.SetWideString(vNome);
  FGetClientesCommand.Parameters[4].Value.SetWideString(vCPF);
  FGetClientesCommand.Parameters[5].Value.SetWideString(vTipo);
  FGetClientesCommand.Parameters[6].Value.SetWideString(vLogin);
  FGetClientesCommand.Execute(ARequestFilter);
  Result := TJSONArray(FGetClientesCommand.Parameters[7].Value.GetJSONValue(FInstanceOwner));
end;

function TServerMethods1Client.GetClientes_Cache(vTicket: string; vIdClientes: Integer; vChaveEspecialidades: Integer; vNome: string; vCPF: string; vTipo: string; vLogin: string; const ARequestFilter: string): IDSRestCachedJSONArray;
begin
  if FGetClientesCommand_Cache = nil then
  begin
    FGetClientesCommand_Cache := FConnection.CreateCommand;
    FGetClientesCommand_Cache.RequestType := 'GET';
    FGetClientesCommand_Cache.Text := 'TServerMethods1.GetClientes';
    FGetClientesCommand_Cache.Prepare(TServerMethods1_GetClientes_Cache);
  end;
  FGetClientesCommand_Cache.Parameters[0].Value.SetWideString(vTicket);
  FGetClientesCommand_Cache.Parameters[1].Value.SetInt32(vIdClientes);
  FGetClientesCommand_Cache.Parameters[2].Value.SetInt32(vChaveEspecialidades);
  FGetClientesCommand_Cache.Parameters[3].Value.SetWideString(vNome);
  FGetClientesCommand_Cache.Parameters[4].Value.SetWideString(vCPF);
  FGetClientesCommand_Cache.Parameters[5].Value.SetWideString(vTipo);
  FGetClientesCommand_Cache.Parameters[6].Value.SetWideString(vLogin);
  FGetClientesCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedJSONArray.Create(FGetClientesCommand_Cache.Parameters[7].Value.GetString);
end;

function TServerMethods1Client.InsertClientes(vTicket: string; NewCliente: string; const ARequestFilter: string): string;
begin
  if FInsertClientesCommand = nil then
  begin
    FInsertClientesCommand := FConnection.CreateCommand;
    FInsertClientesCommand.RequestType := 'GET';
    FInsertClientesCommand.Text := 'TServerMethods1.InsertClientes';
    FInsertClientesCommand.Prepare(TServerMethods1_InsertClientes);
  end;
  FInsertClientesCommand.Parameters[0].Value.SetWideString(vTicket);
  FInsertClientesCommand.Parameters[1].Value.SetWideString(NewCliente);
  FInsertClientesCommand.Execute(ARequestFilter);
  Result := FInsertClientesCommand.Parameters[2].Value.GetWideString;
end;

function TServerMethods1Client.DeleteClientes(vTicket: string; OldCliente: string; const ARequestFilter: string): string;
begin
  if FDeleteClientesCommand = nil then
  begin
    FDeleteClientesCommand := FConnection.CreateCommand;
    FDeleteClientesCommand.RequestType := 'GET';
    FDeleteClientesCommand.Text := 'TServerMethods1.DeleteClientes';
    FDeleteClientesCommand.Prepare(TServerMethods1_DeleteClientes);
  end;
  FDeleteClientesCommand.Parameters[0].Value.SetWideString(vTicket);
  FDeleteClientesCommand.Parameters[1].Value.SetWideString(OldCliente);
  FDeleteClientesCommand.Execute(ARequestFilter);
  Result := FDeleteClientesCommand.Parameters[2].Value.GetWideString;
end;

function TServerMethods1Client.UpdateClientes(vTicket: string; OldCliente: string; NewCliente: string; const ARequestFilter: string): string;
begin
  if FUpdateClientesCommand = nil then
  begin
    FUpdateClientesCommand := FConnection.CreateCommand;
    FUpdateClientesCommand.RequestType := 'GET';
    FUpdateClientesCommand.Text := 'TServerMethods1.UpdateClientes';
    FUpdateClientesCommand.Prepare(TServerMethods1_UpdateClientes);
  end;
  FUpdateClientesCommand.Parameters[0].Value.SetWideString(vTicket);
  FUpdateClientesCommand.Parameters[1].Value.SetWideString(OldCliente);
  FUpdateClientesCommand.Parameters[2].Value.SetWideString(NewCliente);
  FUpdateClientesCommand.Execute(ARequestFilter);
  Result := FUpdateClientesCommand.Parameters[3].Value.GetWideString;
end;

function TServerMethods1Client.GetChamadasEmEspera(vTicket: string; vEmEspera: string; vIP_Origem: string; vIP_Destino: string; vChavePaciente: Integer; vChaveEspecialidades: Integer; vChamada: TDateTime; vEncerrada: TDateTime; vChaveMedico: Integer; vInicioDoAtendimento: TDateTime; vFimDoAtendimento: TDateTime; const ARequestFilter: string): TJSONArray;
begin
  if FGetChamadasEmEsperaCommand = nil then
  begin
    FGetChamadasEmEsperaCommand := FConnection.CreateCommand;
    FGetChamadasEmEsperaCommand.RequestType := 'GET';
    FGetChamadasEmEsperaCommand.Text := 'TServerMethods1.GetChamadasEmEspera';
    FGetChamadasEmEsperaCommand.Prepare(TServerMethods1_GetChamadasEmEspera);
  end;
  FGetChamadasEmEsperaCommand.Parameters[0].Value.SetWideString(vTicket);
  FGetChamadasEmEsperaCommand.Parameters[1].Value.SetWideString(vEmEspera);
  FGetChamadasEmEsperaCommand.Parameters[2].Value.SetWideString(vIP_Origem);
  FGetChamadasEmEsperaCommand.Parameters[3].Value.SetWideString(vIP_Destino);
  FGetChamadasEmEsperaCommand.Parameters[4].Value.SetInt32(vChavePaciente);
  FGetChamadasEmEsperaCommand.Parameters[5].Value.SetInt32(vChaveEspecialidades);
  FGetChamadasEmEsperaCommand.Parameters[6].Value.AsDateTime := vChamada;
  FGetChamadasEmEsperaCommand.Parameters[7].Value.AsDateTime := vEncerrada;
  FGetChamadasEmEsperaCommand.Parameters[8].Value.SetInt32(vChaveMedico);
  FGetChamadasEmEsperaCommand.Parameters[9].Value.AsDateTime := vInicioDoAtendimento;
  FGetChamadasEmEsperaCommand.Parameters[10].Value.AsDateTime := vFimDoAtendimento;
  FGetChamadasEmEsperaCommand.Execute(ARequestFilter);
  Result := TJSONArray(FGetChamadasEmEsperaCommand.Parameters[11].Value.GetJSONValue(FInstanceOwner));
end;

function TServerMethods1Client.GetChamadasEmEspera_Cache(vTicket: string; vEmEspera: string; vIP_Origem: string; vIP_Destino: string; vChavePaciente: Integer; vChaveEspecialidades: Integer; vChamada: TDateTime; vEncerrada: TDateTime; vChaveMedico: Integer; vInicioDoAtendimento: TDateTime; vFimDoAtendimento: TDateTime; const ARequestFilter: string): IDSRestCachedJSONArray;
begin
  if FGetChamadasEmEsperaCommand_Cache = nil then
  begin
    FGetChamadasEmEsperaCommand_Cache := FConnection.CreateCommand;
    FGetChamadasEmEsperaCommand_Cache.RequestType := 'GET';
    FGetChamadasEmEsperaCommand_Cache.Text := 'TServerMethods1.GetChamadasEmEspera';
    FGetChamadasEmEsperaCommand_Cache.Prepare(TServerMethods1_GetChamadasEmEspera_Cache);
  end;
  FGetChamadasEmEsperaCommand_Cache.Parameters[0].Value.SetWideString(vTicket);
  FGetChamadasEmEsperaCommand_Cache.Parameters[1].Value.SetWideString(vEmEspera);
  FGetChamadasEmEsperaCommand_Cache.Parameters[2].Value.SetWideString(vIP_Origem);
  FGetChamadasEmEsperaCommand_Cache.Parameters[3].Value.SetWideString(vIP_Destino);
  FGetChamadasEmEsperaCommand_Cache.Parameters[4].Value.SetInt32(vChavePaciente);
  FGetChamadasEmEsperaCommand_Cache.Parameters[5].Value.SetInt32(vChaveEspecialidades);
  FGetChamadasEmEsperaCommand_Cache.Parameters[6].Value.AsDateTime := vChamada;
  FGetChamadasEmEsperaCommand_Cache.Parameters[7].Value.AsDateTime := vEncerrada;
  FGetChamadasEmEsperaCommand_Cache.Parameters[8].Value.SetInt32(vChaveMedico);
  FGetChamadasEmEsperaCommand_Cache.Parameters[9].Value.AsDateTime := vInicioDoAtendimento;
  FGetChamadasEmEsperaCommand_Cache.Parameters[10].Value.AsDateTime := vFimDoAtendimento;
  FGetChamadasEmEsperaCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedJSONArray.Create(FGetChamadasEmEsperaCommand_Cache.Parameters[11].Value.GetString);
end;

function TServerMethods1Client.InsertChamadasEmEspera(vTicket: string; vObjJSON: string; const ARequestFilter: string): string;
begin
  if FInsertChamadasEmEsperaCommand = nil then
  begin
    FInsertChamadasEmEsperaCommand := FConnection.CreateCommand;
    FInsertChamadasEmEsperaCommand.RequestType := 'GET';
    FInsertChamadasEmEsperaCommand.Text := 'TServerMethods1.InsertChamadasEmEspera';
    FInsertChamadasEmEsperaCommand.Prepare(TServerMethods1_InsertChamadasEmEspera);
  end;
  FInsertChamadasEmEsperaCommand.Parameters[0].Value.SetWideString(vTicket);
  FInsertChamadasEmEsperaCommand.Parameters[1].Value.SetWideString(vObjJSON);
  FInsertChamadasEmEsperaCommand.Execute(ARequestFilter);
  Result := FInsertChamadasEmEsperaCommand.Parameters[2].Value.GetWideString;
end;

function TServerMethods1Client.DeleteChamadasEmEspera(vTicket: string; vObjJSON: string; const ARequestFilter: string): string;
begin
  if FDeleteChamadasEmEsperaCommand = nil then
  begin
    FDeleteChamadasEmEsperaCommand := FConnection.CreateCommand;
    FDeleteChamadasEmEsperaCommand.RequestType := 'GET';
    FDeleteChamadasEmEsperaCommand.Text := 'TServerMethods1.DeleteChamadasEmEspera';
    FDeleteChamadasEmEsperaCommand.Prepare(TServerMethods1_DeleteChamadasEmEspera);
  end;
  FDeleteChamadasEmEsperaCommand.Parameters[0].Value.SetWideString(vTicket);
  FDeleteChamadasEmEsperaCommand.Parameters[1].Value.SetWideString(vObjJSON);
  FDeleteChamadasEmEsperaCommand.Execute(ARequestFilter);
  Result := FDeleteChamadasEmEsperaCommand.Parameters[2].Value.GetWideString;
end;

function TServerMethods1Client.UpdateChamadasEmEspera(vTicket: string; vObjJSON: string; const ARequestFilter: string): string;
begin
  if FUpdateChamadasEmEsperaCommand = nil then
  begin
    FUpdateChamadasEmEsperaCommand := FConnection.CreateCommand;
    FUpdateChamadasEmEsperaCommand.RequestType := 'GET';
    FUpdateChamadasEmEsperaCommand.Text := 'TServerMethods1.UpdateChamadasEmEspera';
    FUpdateChamadasEmEsperaCommand.Prepare(TServerMethods1_UpdateChamadasEmEspera);
  end;
  FUpdateChamadasEmEsperaCommand.Parameters[0].Value.SetWideString(vTicket);
  FUpdateChamadasEmEsperaCommand.Parameters[1].Value.SetWideString(vObjJSON);
  FUpdateChamadasEmEsperaCommand.Execute(ARequestFilter);
  Result := FUpdateChamadasEmEsperaCommand.Parameters[2].Value.GetWideString;
end;

function TServerMethods1Client.AtualizaChaveMedico(vTicket: string; vObjJSON: string; const ARequestFilter: string): string;
begin
  if FAtualizaChaveMedicoCommand = nil then
  begin
    FAtualizaChaveMedicoCommand := FConnection.CreateCommand;
    FAtualizaChaveMedicoCommand.RequestType := 'GET';
    FAtualizaChaveMedicoCommand.Text := 'TServerMethods1.AtualizaChaveMedico';
    FAtualizaChaveMedicoCommand.Prepare(TServerMethods1_AtualizaChaveMedico);
  end;
  FAtualizaChaveMedicoCommand.Parameters[0].Value.SetWideString(vTicket);
  FAtualizaChaveMedicoCommand.Parameters[1].Value.SetWideString(vObjJSON);
  FAtualizaChaveMedicoCommand.Execute(ARequestFilter);
  Result := FAtualizaChaveMedicoCommand.Parameters[2].Value.GetWideString;
end;

function TServerMethods1Client.FinalizaAntendimento(vTicket: string; vObjJSON: string; const ARequestFilter: string): string;
begin
  if FFinalizaAntendimentoCommand = nil then
  begin
    FFinalizaAntendimentoCommand := FConnection.CreateCommand;
    FFinalizaAntendimentoCommand.RequestType := 'GET';
    FFinalizaAntendimentoCommand.Text := 'TServerMethods1.FinalizaAntendimento';
    FFinalizaAntendimentoCommand.Prepare(TServerMethods1_FinalizaAntendimento);
  end;
  FFinalizaAntendimentoCommand.Parameters[0].Value.SetWideString(vTicket);
  FFinalizaAntendimentoCommand.Parameters[1].Value.SetWideString(vObjJSON);
  FFinalizaAntendimentoCommand.Execute(ARequestFilter);
  Result := FFinalizaAntendimentoCommand.Parameters[2].Value.GetWideString;
end;

function TServerMethods1Client.GetChat(vTicket: string; vJaLida: string; vIdChat: Integer; vChaveChamada: Integer; vChavePaciente: Integer; vChaveMedico: Integer; vDataEnvio: TDateTime; const ARequestFilter: string): TJSONArray;
begin
  if FGetChatCommand = nil then
  begin
    FGetChatCommand := FConnection.CreateCommand;
    FGetChatCommand.RequestType := 'GET';
    FGetChatCommand.Text := 'TServerMethods1.GetChat';
    FGetChatCommand.Prepare(TServerMethods1_GetChat);
  end;
  FGetChatCommand.Parameters[0].Value.SetWideString(vTicket);
  FGetChatCommand.Parameters[1].Value.SetWideString(vJaLida);
  FGetChatCommand.Parameters[2].Value.SetInt32(vIdChat);
  FGetChatCommand.Parameters[3].Value.SetInt32(vChaveChamada);
  FGetChatCommand.Parameters[4].Value.SetInt32(vChavePaciente);
  FGetChatCommand.Parameters[5].Value.SetInt32(vChaveMedico);
  FGetChatCommand.Parameters[6].Value.AsDateTime := vDataEnvio;
  FGetChatCommand.Execute(ARequestFilter);
  Result := TJSONArray(FGetChatCommand.Parameters[7].Value.GetJSONValue(FInstanceOwner));
end;

function TServerMethods1Client.GetChat_Cache(vTicket: string; vJaLida: string; vIdChat: Integer; vChaveChamada: Integer; vChavePaciente: Integer; vChaveMedico: Integer; vDataEnvio: TDateTime; const ARequestFilter: string): IDSRestCachedJSONArray;
begin
  if FGetChatCommand_Cache = nil then
  begin
    FGetChatCommand_Cache := FConnection.CreateCommand;
    FGetChatCommand_Cache.RequestType := 'GET';
    FGetChatCommand_Cache.Text := 'TServerMethods1.GetChat';
    FGetChatCommand_Cache.Prepare(TServerMethods1_GetChat_Cache);
  end;
  FGetChatCommand_Cache.Parameters[0].Value.SetWideString(vTicket);
  FGetChatCommand_Cache.Parameters[1].Value.SetWideString(vJaLida);
  FGetChatCommand_Cache.Parameters[2].Value.SetInt32(vIdChat);
  FGetChatCommand_Cache.Parameters[3].Value.SetInt32(vChaveChamada);
  FGetChatCommand_Cache.Parameters[4].Value.SetInt32(vChavePaciente);
  FGetChatCommand_Cache.Parameters[5].Value.SetInt32(vChaveMedico);
  FGetChatCommand_Cache.Parameters[6].Value.AsDateTime := vDataEnvio;
  FGetChatCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedJSONArray.Create(FGetChatCommand_Cache.Parameters[7].Value.GetString);
end;

function TServerMethods1Client.InsertChat(vTicket: string; vObjJSON: string; const ARequestFilter: string): string;
begin
  if FInsertChatCommand = nil then
  begin
    FInsertChatCommand := FConnection.CreateCommand;
    FInsertChatCommand.RequestType := 'GET';
    FInsertChatCommand.Text := 'TServerMethods1.InsertChat';
    FInsertChatCommand.Prepare(TServerMethods1_InsertChat);
  end;
  FInsertChatCommand.Parameters[0].Value.SetWideString(vTicket);
  FInsertChatCommand.Parameters[1].Value.SetWideString(vObjJSON);
  FInsertChatCommand.Execute(ARequestFilter);
  Result := FInsertChatCommand.Parameters[2].Value.GetWideString;
end;

function TServerMethods1Client.DeleteChat(vTicket: string; vObjJSON: string; const ARequestFilter: string): string;
begin
  if FDeleteChatCommand = nil then
  begin
    FDeleteChatCommand := FConnection.CreateCommand;
    FDeleteChatCommand.RequestType := 'GET';
    FDeleteChatCommand.Text := 'TServerMethods1.DeleteChat';
    FDeleteChatCommand.Prepare(TServerMethods1_DeleteChat);
  end;
  FDeleteChatCommand.Parameters[0].Value.SetWideString(vTicket);
  FDeleteChatCommand.Parameters[1].Value.SetWideString(vObjJSON);
  FDeleteChatCommand.Execute(ARequestFilter);
  Result := FDeleteChatCommand.Parameters[2].Value.GetWideString;
end;

function TServerMethods1Client.UpdateChat(vTicket: string; vObjJSON: string; const ARequestFilter: string): string;
begin
  if FUpdateChatCommand = nil then
  begin
    FUpdateChatCommand := FConnection.CreateCommand;
    FUpdateChatCommand.RequestType := 'GET';
    FUpdateChatCommand.Text := 'TServerMethods1.UpdateChat';
    FUpdateChatCommand.Prepare(TServerMethods1_UpdateChat);
  end;
  FUpdateChatCommand.Parameters[0].Value.SetWideString(vTicket);
  FUpdateChatCommand.Parameters[1].Value.SetWideString(vObjJSON);
  FUpdateChatCommand.Execute(ARequestFilter);
  Result := FUpdateChatCommand.Parameters[2].Value.GetWideString;
end;

constructor TServerMethods1Client.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TServerMethods1Client.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TServerMethods1Client.Destroy;
begin
  FEchoStringCommand.DisposeOf;
  FReverseStringCommand.DisposeOf;
  FAutenticacaoCommand.DisposeOf;
  FAutenticacaoCommand_Cache.DisposeOf;
  FGetClientesCommand.DisposeOf;
  FGetClientesCommand_Cache.DisposeOf;
  FInsertClientesCommand.DisposeOf;
  FDeleteClientesCommand.DisposeOf;
  FUpdateClientesCommand.DisposeOf;
  FGetChamadasEmEsperaCommand.DisposeOf;
  FGetChamadasEmEsperaCommand_Cache.DisposeOf;
  FInsertChamadasEmEsperaCommand.DisposeOf;
  FDeleteChamadasEmEsperaCommand.DisposeOf;
  FUpdateChamadasEmEsperaCommand.DisposeOf;
  FAtualizaChaveMedicoCommand.DisposeOf;
  FFinalizaAntendimentoCommand.DisposeOf;
  FGetChatCommand.DisposeOf;
  FGetChatCommand_Cache.DisposeOf;
  FInsertChatCommand.DisposeOf;
  FDeleteChatCommand.DisposeOf;
  FUpdateChatCommand.DisposeOf;
  inherited;
end;

procedure TdsmClientesClient.FDConnectionBeforeConnect(Sender: TObject);
begin
  if FFDConnectionBeforeConnectCommand = nil then
  begin
    FFDConnectionBeforeConnectCommand := FConnection.CreateCommand;
    FFDConnectionBeforeConnectCommand.RequestType := 'POST';
    FFDConnectionBeforeConnectCommand.Text := 'TdsmClientes."FDConnectionBeforeConnect"';
    FFDConnectionBeforeConnectCommand.Prepare(TdsmClientes_FDConnectionBeforeConnect);
  end;
  if not Assigned(Sender) then
    FFDConnectionBeforeConnectCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FFDConnectionBeforeConnectCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FFDConnectionBeforeConnectCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Sender), True);
      if FInstanceOwner then
        Sender.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FFDConnectionBeforeConnectCommand.Execute;
end;

function TdsmClientesClient.Autenticacao(vAplicacao: string; vSenha: string; const ARequestFilter: string): TJSONArray;
begin
  if FAutenticacaoCommand = nil then
  begin
    FAutenticacaoCommand := FConnection.CreateCommand;
    FAutenticacaoCommand.RequestType := 'GET';
    FAutenticacaoCommand.Text := 'TdsmClientes.Autenticacao';
    FAutenticacaoCommand.Prepare(TdsmClientes_Autenticacao);
  end;
  FAutenticacaoCommand.Parameters[0].Value.SetWideString(vAplicacao);
  FAutenticacaoCommand.Parameters[1].Value.SetWideString(vSenha);
  FAutenticacaoCommand.Execute(ARequestFilter);
  Result := TJSONArray(FAutenticacaoCommand.Parameters[2].Value.GetJSONValue(FInstanceOwner));
end;

function TdsmClientesClient.Autenticacao_Cache(vAplicacao: string; vSenha: string; const ARequestFilter: string): IDSRestCachedJSONArray;
begin
  if FAutenticacaoCommand_Cache = nil then
  begin
    FAutenticacaoCommand_Cache := FConnection.CreateCommand;
    FAutenticacaoCommand_Cache.RequestType := 'GET';
    FAutenticacaoCommand_Cache.Text := 'TdsmClientes.Autenticacao';
    FAutenticacaoCommand_Cache.Prepare(TdsmClientes_Autenticacao_Cache);
  end;
  FAutenticacaoCommand_Cache.Parameters[0].Value.SetWideString(vAplicacao);
  FAutenticacaoCommand_Cache.Parameters[1].Value.SetWideString(vSenha);
  FAutenticacaoCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedJSONArray.Create(FAutenticacaoCommand_Cache.Parameters[2].Value.GetString);
end;

function TdsmClientesClient.GetClientes(vTicket: string; vIdClientes: Integer; vChaveEspecialidades: Integer; vNome: string; vCPF: string; vTipo: string; vLogin: string; const ARequestFilter: string): TJSONArray;
begin
  if FGetClientesCommand = nil then
  begin
    FGetClientesCommand := FConnection.CreateCommand;
    FGetClientesCommand.RequestType := 'GET';
    FGetClientesCommand.Text := 'TdsmClientes.GetClientes';
    FGetClientesCommand.Prepare(TdsmClientes_GetClientes);
  end;
  FGetClientesCommand.Parameters[0].Value.SetWideString(vTicket);
  FGetClientesCommand.Parameters[1].Value.SetInt32(vIdClientes);
  FGetClientesCommand.Parameters[2].Value.SetInt32(vChaveEspecialidades);
  FGetClientesCommand.Parameters[3].Value.SetWideString(vNome);
  FGetClientesCommand.Parameters[4].Value.SetWideString(vCPF);
  FGetClientesCommand.Parameters[5].Value.SetWideString(vTipo);
  FGetClientesCommand.Parameters[6].Value.SetWideString(vLogin);
  FGetClientesCommand.Execute(ARequestFilter);
  Result := TJSONArray(FGetClientesCommand.Parameters[7].Value.GetJSONValue(FInstanceOwner));
end;

function TdsmClientesClient.GetClientes_Cache(vTicket: string; vIdClientes: Integer; vChaveEspecialidades: Integer; vNome: string; vCPF: string; vTipo: string; vLogin: string; const ARequestFilter: string): IDSRestCachedJSONArray;
begin
  if FGetClientesCommand_Cache = nil then
  begin
    FGetClientesCommand_Cache := FConnection.CreateCommand;
    FGetClientesCommand_Cache.RequestType := 'GET';
    FGetClientesCommand_Cache.Text := 'TdsmClientes.GetClientes';
    FGetClientesCommand_Cache.Prepare(TdsmClientes_GetClientes_Cache);
  end;
  FGetClientesCommand_Cache.Parameters[0].Value.SetWideString(vTicket);
  FGetClientesCommand_Cache.Parameters[1].Value.SetInt32(vIdClientes);
  FGetClientesCommand_Cache.Parameters[2].Value.SetInt32(vChaveEspecialidades);
  FGetClientesCommand_Cache.Parameters[3].Value.SetWideString(vNome);
  FGetClientesCommand_Cache.Parameters[4].Value.SetWideString(vCPF);
  FGetClientesCommand_Cache.Parameters[5].Value.SetWideString(vTipo);
  FGetClientesCommand_Cache.Parameters[6].Value.SetWideString(vLogin);
  FGetClientesCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedJSONArray.Create(FGetClientesCommand_Cache.Parameters[7].Value.GetString);
end;

function TdsmClientesClient.InsertClientes(vTicket: string; NewClient: string; const ARequestFilter: string): string;
begin
  if FInsertClientesCommand = nil then
  begin
    FInsertClientesCommand := FConnection.CreateCommand;
    FInsertClientesCommand.RequestType := 'GET';
    FInsertClientesCommand.Text := 'TdsmClientes.InsertClientes';
    FInsertClientesCommand.Prepare(TdsmClientes_InsertClientes);
  end;
  FInsertClientesCommand.Parameters[0].Value.SetWideString(vTicket);
  FInsertClientesCommand.Parameters[1].Value.SetWideString(NewClient);
  FInsertClientesCommand.Execute(ARequestFilter);
  Result := FInsertClientesCommand.Parameters[2].Value.GetWideString;
end;

function TdsmClientesClient.DeleteClientes(vTicket: string; OldClient: string; const ARequestFilter: string): string;
begin
  if FDeleteClientesCommand = nil then
  begin
    FDeleteClientesCommand := FConnection.CreateCommand;
    FDeleteClientesCommand.RequestType := 'GET';
    FDeleteClientesCommand.Text := 'TdsmClientes.DeleteClientes';
    FDeleteClientesCommand.Prepare(TdsmClientes_DeleteClientes);
  end;
  FDeleteClientesCommand.Parameters[0].Value.SetWideString(vTicket);
  FDeleteClientesCommand.Parameters[1].Value.SetWideString(OldClient);
  FDeleteClientesCommand.Execute(ARequestFilter);
  Result := FDeleteClientesCommand.Parameters[2].Value.GetWideString;
end;

function TdsmClientesClient.UpdateClientes(vTicket: string; OldClient: string; NewClient: string; const ARequestFilter: string): string;
begin
  if FUpdateClientesCommand = nil then
  begin
    FUpdateClientesCommand := FConnection.CreateCommand;
    FUpdateClientesCommand.RequestType := 'GET';
    FUpdateClientesCommand.Text := 'TdsmClientes.UpdateClientes';
    FUpdateClientesCommand.Prepare(TdsmClientes_UpdateClientes);
  end;
  FUpdateClientesCommand.Parameters[0].Value.SetWideString(vTicket);
  FUpdateClientesCommand.Parameters[1].Value.SetWideString(OldClient);
  FUpdateClientesCommand.Parameters[2].Value.SetWideString(NewClient);
  FUpdateClientesCommand.Execute(ARequestFilter);
  Result := FUpdateClientesCommand.Parameters[3].Value.GetWideString;
end;

constructor TdsmClientesClient.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TdsmClientesClient.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TdsmClientesClient.Destroy;
begin
  FFDConnectionBeforeConnectCommand.DisposeOf;
  FAutenticacaoCommand.DisposeOf;
  FAutenticacaoCommand_Cache.DisposeOf;
  FGetClientesCommand.DisposeOf;
  FGetClientesCommand_Cache.DisposeOf;
  FInsertClientesCommand.DisposeOf;
  FDeleteClientesCommand.DisposeOf;
  FUpdateClientesCommand.DisposeOf;
  inherited;
end;

procedure TdsmChamadasEmEsperaClient.FDConnectionBeforeConnect(Sender: TObject);
begin
  if FFDConnectionBeforeConnectCommand = nil then
  begin
    FFDConnectionBeforeConnectCommand := FConnection.CreateCommand;
    FFDConnectionBeforeConnectCommand.RequestType := 'POST';
    FFDConnectionBeforeConnectCommand.Text := 'TdsmChamadasEmEspera."FDConnectionBeforeConnect"';
    FFDConnectionBeforeConnectCommand.Prepare(TdsmChamadasEmEspera_FDConnectionBeforeConnect);
  end;
  if not Assigned(Sender) then
    FFDConnectionBeforeConnectCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FFDConnectionBeforeConnectCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FFDConnectionBeforeConnectCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Sender), True);
      if FInstanceOwner then
        Sender.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FFDConnectionBeforeConnectCommand.Execute;
end;

function TdsmChamadasEmEsperaClient.Autenticacao(vAplicacao: string; vSenha: string; const ARequestFilter: string): TJSONArray;
begin
  if FAutenticacaoCommand = nil then
  begin
    FAutenticacaoCommand := FConnection.CreateCommand;
    FAutenticacaoCommand.RequestType := 'GET';
    FAutenticacaoCommand.Text := 'TdsmChamadasEmEspera.Autenticacao';
    FAutenticacaoCommand.Prepare(TdsmChamadasEmEspera_Autenticacao);
  end;
  FAutenticacaoCommand.Parameters[0].Value.SetWideString(vAplicacao);
  FAutenticacaoCommand.Parameters[1].Value.SetWideString(vSenha);
  FAutenticacaoCommand.Execute(ARequestFilter);
  Result := TJSONArray(FAutenticacaoCommand.Parameters[2].Value.GetJSONValue(FInstanceOwner));
end;

function TdsmChamadasEmEsperaClient.Autenticacao_Cache(vAplicacao: string; vSenha: string; const ARequestFilter: string): IDSRestCachedJSONArray;
begin
  if FAutenticacaoCommand_Cache = nil then
  begin
    FAutenticacaoCommand_Cache := FConnection.CreateCommand;
    FAutenticacaoCommand_Cache.RequestType := 'GET';
    FAutenticacaoCommand_Cache.Text := 'TdsmChamadasEmEspera.Autenticacao';
    FAutenticacaoCommand_Cache.Prepare(TdsmChamadasEmEspera_Autenticacao_Cache);
  end;
  FAutenticacaoCommand_Cache.Parameters[0].Value.SetWideString(vAplicacao);
  FAutenticacaoCommand_Cache.Parameters[1].Value.SetWideString(vSenha);
  FAutenticacaoCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedJSONArray.Create(FAutenticacaoCommand_Cache.Parameters[2].Value.GetString);
end;

function TdsmChamadasEmEsperaClient.GetChamadasEmEspera(vTicket: string; vEmEspera: string; vIP_Origem: string; vIP_Destino: string; vChavePaciente: Integer; vChaveEspecialidades: Integer; vChamada: TDateTime; vEncerrada: TDateTime; vChaveMedico: Integer; vInicioDoAtendimento: TDateTime; vFimDoAtendimento: TDateTime; const ARequestFilter: string): TJSONArray;
begin
  if FGetChamadasEmEsperaCommand = nil then
  begin
    FGetChamadasEmEsperaCommand := FConnection.CreateCommand;
    FGetChamadasEmEsperaCommand.RequestType := 'GET';
    FGetChamadasEmEsperaCommand.Text := 'TdsmChamadasEmEspera.GetChamadasEmEspera';
    FGetChamadasEmEsperaCommand.Prepare(TdsmChamadasEmEspera_GetChamadasEmEspera);
  end;
  FGetChamadasEmEsperaCommand.Parameters[0].Value.SetWideString(vTicket);
  FGetChamadasEmEsperaCommand.Parameters[1].Value.SetWideString(vEmEspera);
  FGetChamadasEmEsperaCommand.Parameters[2].Value.SetWideString(vIP_Origem);
  FGetChamadasEmEsperaCommand.Parameters[3].Value.SetWideString(vIP_Destino);
  FGetChamadasEmEsperaCommand.Parameters[4].Value.SetInt32(vChavePaciente);
  FGetChamadasEmEsperaCommand.Parameters[5].Value.SetInt32(vChaveEspecialidades);
  FGetChamadasEmEsperaCommand.Parameters[6].Value.AsDateTime := vChamada;
  FGetChamadasEmEsperaCommand.Parameters[7].Value.AsDateTime := vEncerrada;
  FGetChamadasEmEsperaCommand.Parameters[8].Value.SetInt32(vChaveMedico);
  FGetChamadasEmEsperaCommand.Parameters[9].Value.AsDateTime := vInicioDoAtendimento;
  FGetChamadasEmEsperaCommand.Parameters[10].Value.AsDateTime := vFimDoAtendimento;
  FGetChamadasEmEsperaCommand.Execute(ARequestFilter);
  Result := TJSONArray(FGetChamadasEmEsperaCommand.Parameters[11].Value.GetJSONValue(FInstanceOwner));
end;

function TdsmChamadasEmEsperaClient.GetChamadasEmEspera_Cache(vTicket: string; vEmEspera: string; vIP_Origem: string; vIP_Destino: string; vChavePaciente: Integer; vChaveEspecialidades: Integer; vChamada: TDateTime; vEncerrada: TDateTime; vChaveMedico: Integer; vInicioDoAtendimento: TDateTime; vFimDoAtendimento: TDateTime; const ARequestFilter: string): IDSRestCachedJSONArray;
begin
  if FGetChamadasEmEsperaCommand_Cache = nil then
  begin
    FGetChamadasEmEsperaCommand_Cache := FConnection.CreateCommand;
    FGetChamadasEmEsperaCommand_Cache.RequestType := 'GET';
    FGetChamadasEmEsperaCommand_Cache.Text := 'TdsmChamadasEmEspera.GetChamadasEmEspera';
    FGetChamadasEmEsperaCommand_Cache.Prepare(TdsmChamadasEmEspera_GetChamadasEmEspera_Cache);
  end;
  FGetChamadasEmEsperaCommand_Cache.Parameters[0].Value.SetWideString(vTicket);
  FGetChamadasEmEsperaCommand_Cache.Parameters[1].Value.SetWideString(vEmEspera);
  FGetChamadasEmEsperaCommand_Cache.Parameters[2].Value.SetWideString(vIP_Origem);
  FGetChamadasEmEsperaCommand_Cache.Parameters[3].Value.SetWideString(vIP_Destino);
  FGetChamadasEmEsperaCommand_Cache.Parameters[4].Value.SetInt32(vChavePaciente);
  FGetChamadasEmEsperaCommand_Cache.Parameters[5].Value.SetInt32(vChaveEspecialidades);
  FGetChamadasEmEsperaCommand_Cache.Parameters[6].Value.AsDateTime := vChamada;
  FGetChamadasEmEsperaCommand_Cache.Parameters[7].Value.AsDateTime := vEncerrada;
  FGetChamadasEmEsperaCommand_Cache.Parameters[8].Value.SetInt32(vChaveMedico);
  FGetChamadasEmEsperaCommand_Cache.Parameters[9].Value.AsDateTime := vInicioDoAtendimento;
  FGetChamadasEmEsperaCommand_Cache.Parameters[10].Value.AsDateTime := vFimDoAtendimento;
  FGetChamadasEmEsperaCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedJSONArray.Create(FGetChamadasEmEsperaCommand_Cache.Parameters[11].Value.GetString);
end;

function TdsmChamadasEmEsperaClient.InsertChamadasEmEspera(vTicket: string; vObjJSON: string; const ARequestFilter: string): string;
begin
  if FInsertChamadasEmEsperaCommand = nil then
  begin
    FInsertChamadasEmEsperaCommand := FConnection.CreateCommand;
    FInsertChamadasEmEsperaCommand.RequestType := 'GET';
    FInsertChamadasEmEsperaCommand.Text := 'TdsmChamadasEmEspera.InsertChamadasEmEspera';
    FInsertChamadasEmEsperaCommand.Prepare(TdsmChamadasEmEspera_InsertChamadasEmEspera);
  end;
  FInsertChamadasEmEsperaCommand.Parameters[0].Value.SetWideString(vTicket);
  FInsertChamadasEmEsperaCommand.Parameters[1].Value.SetWideString(vObjJSON);
  FInsertChamadasEmEsperaCommand.Execute(ARequestFilter);
  Result := FInsertChamadasEmEsperaCommand.Parameters[2].Value.GetWideString;
end;

function TdsmChamadasEmEsperaClient.DeleteChamadasEmEspera(vTicket: string; vObjJSON: string; const ARequestFilter: string): string;
begin
  if FDeleteChamadasEmEsperaCommand = nil then
  begin
    FDeleteChamadasEmEsperaCommand := FConnection.CreateCommand;
    FDeleteChamadasEmEsperaCommand.RequestType := 'GET';
    FDeleteChamadasEmEsperaCommand.Text := 'TdsmChamadasEmEspera.DeleteChamadasEmEspera';
    FDeleteChamadasEmEsperaCommand.Prepare(TdsmChamadasEmEspera_DeleteChamadasEmEspera);
  end;
  FDeleteChamadasEmEsperaCommand.Parameters[0].Value.SetWideString(vTicket);
  FDeleteChamadasEmEsperaCommand.Parameters[1].Value.SetWideString(vObjJSON);
  FDeleteChamadasEmEsperaCommand.Execute(ARequestFilter);
  Result := FDeleteChamadasEmEsperaCommand.Parameters[2].Value.GetWideString;
end;

function TdsmChamadasEmEsperaClient.UpdateChamadasEmEspera(vTicket: string; vObjJSON: string; const ARequestFilter: string): string;
begin
  if FUpdateChamadasEmEsperaCommand = nil then
  begin
    FUpdateChamadasEmEsperaCommand := FConnection.CreateCommand;
    FUpdateChamadasEmEsperaCommand.RequestType := 'GET';
    FUpdateChamadasEmEsperaCommand.Text := 'TdsmChamadasEmEspera.UpdateChamadasEmEspera';
    FUpdateChamadasEmEsperaCommand.Prepare(TdsmChamadasEmEspera_UpdateChamadasEmEspera);
  end;
  FUpdateChamadasEmEsperaCommand.Parameters[0].Value.SetWideString(vTicket);
  FUpdateChamadasEmEsperaCommand.Parameters[1].Value.SetWideString(vObjJSON);
  FUpdateChamadasEmEsperaCommand.Execute(ARequestFilter);
  Result := FUpdateChamadasEmEsperaCommand.Parameters[2].Value.GetWideString;
end;

function TdsmChamadasEmEsperaClient.AtualizaChaveMedico(vTicket: string; vObjJSON: string; const ARequestFilter: string): string;
begin
  if FAtualizaChaveMedicoCommand = nil then
  begin
    FAtualizaChaveMedicoCommand := FConnection.CreateCommand;
    FAtualizaChaveMedicoCommand.RequestType := 'GET';
    FAtualizaChaveMedicoCommand.Text := 'TdsmChamadasEmEspera.AtualizaChaveMedico';
    FAtualizaChaveMedicoCommand.Prepare(TdsmChamadasEmEspera_AtualizaChaveMedico);
  end;
  FAtualizaChaveMedicoCommand.Parameters[0].Value.SetWideString(vTicket);
  FAtualizaChaveMedicoCommand.Parameters[1].Value.SetWideString(vObjJSON);
  FAtualizaChaveMedicoCommand.Execute(ARequestFilter);
  Result := FAtualizaChaveMedicoCommand.Parameters[2].Value.GetWideString;
end;

function TdsmChamadasEmEsperaClient.FinalizaAntendimento(vTicket: string; vObjJSON: string; const ARequestFilter: string): string;
begin
  if FFinalizaAntendimentoCommand = nil then
  begin
    FFinalizaAntendimentoCommand := FConnection.CreateCommand;
    FFinalizaAntendimentoCommand.RequestType := 'GET';
    FFinalizaAntendimentoCommand.Text := 'TdsmChamadasEmEspera.FinalizaAntendimento';
    FFinalizaAntendimentoCommand.Prepare(TdsmChamadasEmEspera_FinalizaAntendimento);
  end;
  FFinalizaAntendimentoCommand.Parameters[0].Value.SetWideString(vTicket);
  FFinalizaAntendimentoCommand.Parameters[1].Value.SetWideString(vObjJSON);
  FFinalizaAntendimentoCommand.Execute(ARequestFilter);
  Result := FFinalizaAntendimentoCommand.Parameters[2].Value.GetWideString;
end;

constructor TdsmChamadasEmEsperaClient.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TdsmChamadasEmEsperaClient.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TdsmChamadasEmEsperaClient.Destroy;
begin
  FFDConnectionBeforeConnectCommand.DisposeOf;
  FAutenticacaoCommand.DisposeOf;
  FAutenticacaoCommand_Cache.DisposeOf;
  FGetChamadasEmEsperaCommand.DisposeOf;
  FGetChamadasEmEsperaCommand_Cache.DisposeOf;
  FInsertChamadasEmEsperaCommand.DisposeOf;
  FDeleteChamadasEmEsperaCommand.DisposeOf;
  FUpdateChamadasEmEsperaCommand.DisposeOf;
  FAtualizaChaveMedicoCommand.DisposeOf;
  FFinalizaAntendimentoCommand.DisposeOf;
  inherited;
end;

procedure TdsmChatClient.FDConnectionBeforeConnect(Sender: TObject);
begin
  if FFDConnectionBeforeConnectCommand = nil then
  begin
    FFDConnectionBeforeConnectCommand := FConnection.CreateCommand;
    FFDConnectionBeforeConnectCommand.RequestType := 'POST';
    FFDConnectionBeforeConnectCommand.Text := 'TdsmChat."FDConnectionBeforeConnect"';
    FFDConnectionBeforeConnectCommand.Prepare(TdsmChat_FDConnectionBeforeConnect);
  end;
  if not Assigned(Sender) then
    FFDConnectionBeforeConnectCommand.Parameters[0].Value.SetNull
  else
  begin
    FMarshal := TDSRestCommand(FFDConnectionBeforeConnectCommand.Parameters[0].ConnectionHandler).GetJSONMarshaler;
    try
      FFDConnectionBeforeConnectCommand.Parameters[0].Value.SetJSONValue(FMarshal.Marshal(Sender), True);
      if FInstanceOwner then
        Sender.Free
    finally
      FreeAndNil(FMarshal)
    end
    end;
  FFDConnectionBeforeConnectCommand.Execute;
end;

function TdsmChatClient.Autenticacao(vAplicacao: string; vSenha: string; const ARequestFilter: string): TJSONArray;
begin
  if FAutenticacaoCommand = nil then
  begin
    FAutenticacaoCommand := FConnection.CreateCommand;
    FAutenticacaoCommand.RequestType := 'GET';
    FAutenticacaoCommand.Text := 'TdsmChat.Autenticacao';
    FAutenticacaoCommand.Prepare(TdsmChat_Autenticacao);
  end;
  FAutenticacaoCommand.Parameters[0].Value.SetWideString(vAplicacao);
  FAutenticacaoCommand.Parameters[1].Value.SetWideString(vSenha);
  FAutenticacaoCommand.Execute(ARequestFilter);
  Result := TJSONArray(FAutenticacaoCommand.Parameters[2].Value.GetJSONValue(FInstanceOwner));
end;

function TdsmChatClient.Autenticacao_Cache(vAplicacao: string; vSenha: string; const ARequestFilter: string): IDSRestCachedJSONArray;
begin
  if FAutenticacaoCommand_Cache = nil then
  begin
    FAutenticacaoCommand_Cache := FConnection.CreateCommand;
    FAutenticacaoCommand_Cache.RequestType := 'GET';
    FAutenticacaoCommand_Cache.Text := 'TdsmChat.Autenticacao';
    FAutenticacaoCommand_Cache.Prepare(TdsmChat_Autenticacao_Cache);
  end;
  FAutenticacaoCommand_Cache.Parameters[0].Value.SetWideString(vAplicacao);
  FAutenticacaoCommand_Cache.Parameters[1].Value.SetWideString(vSenha);
  FAutenticacaoCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedJSONArray.Create(FAutenticacaoCommand_Cache.Parameters[2].Value.GetString);
end;

function TdsmChatClient.GetChat(vTicket: string; vJaLida: string; vIdChat: Integer; vChaveChamada: Integer; vChavePaciente: Integer; vChaveMedico: Integer; vDataEnvio: TDateTime; const ARequestFilter: string): TJSONArray;
begin
  if FGetChatCommand = nil then
  begin
    FGetChatCommand := FConnection.CreateCommand;
    FGetChatCommand.RequestType := 'GET';
    FGetChatCommand.Text := 'TdsmChat.GetChat';
    FGetChatCommand.Prepare(TdsmChat_GetChat);
  end;
  FGetChatCommand.Parameters[0].Value.SetWideString(vTicket);
  FGetChatCommand.Parameters[1].Value.SetWideString(vJaLida);
  FGetChatCommand.Parameters[2].Value.SetInt32(vIdChat);
  FGetChatCommand.Parameters[3].Value.SetInt32(vChaveChamada);
  FGetChatCommand.Parameters[4].Value.SetInt32(vChavePaciente);
  FGetChatCommand.Parameters[5].Value.SetInt32(vChaveMedico);
  FGetChatCommand.Parameters[6].Value.AsDateTime := vDataEnvio;
  FGetChatCommand.Execute(ARequestFilter);
  Result := TJSONArray(FGetChatCommand.Parameters[7].Value.GetJSONValue(FInstanceOwner));
end;

function TdsmChatClient.GetChat_Cache(vTicket: string; vJaLida: string; vIdChat: Integer; vChaveChamada: Integer; vChavePaciente: Integer; vChaveMedico: Integer; vDataEnvio: TDateTime; const ARequestFilter: string): IDSRestCachedJSONArray;
begin
  if FGetChatCommand_Cache = nil then
  begin
    FGetChatCommand_Cache := FConnection.CreateCommand;
    FGetChatCommand_Cache.RequestType := 'GET';
    FGetChatCommand_Cache.Text := 'TdsmChat.GetChat';
    FGetChatCommand_Cache.Prepare(TdsmChat_GetChat_Cache);
  end;
  FGetChatCommand_Cache.Parameters[0].Value.SetWideString(vTicket);
  FGetChatCommand_Cache.Parameters[1].Value.SetWideString(vJaLida);
  FGetChatCommand_Cache.Parameters[2].Value.SetInt32(vIdChat);
  FGetChatCommand_Cache.Parameters[3].Value.SetInt32(vChaveChamada);
  FGetChatCommand_Cache.Parameters[4].Value.SetInt32(vChavePaciente);
  FGetChatCommand_Cache.Parameters[5].Value.SetInt32(vChaveMedico);
  FGetChatCommand_Cache.Parameters[6].Value.AsDateTime := vDataEnvio;
  FGetChatCommand_Cache.ExecuteCache(ARequestFilter);
  Result := TDSRestCachedJSONArray.Create(FGetChatCommand_Cache.Parameters[7].Value.GetString);
end;

function TdsmChatClient.InsertChat(vTicket: string; vObjJSON: string; const ARequestFilter: string): string;
begin
  if FInsertChatCommand = nil then
  begin
    FInsertChatCommand := FConnection.CreateCommand;
    FInsertChatCommand.RequestType := 'GET';
    FInsertChatCommand.Text := 'TdsmChat.InsertChat';
    FInsertChatCommand.Prepare(TdsmChat_InsertChat);
  end;
  FInsertChatCommand.Parameters[0].Value.SetWideString(vTicket);
  FInsertChatCommand.Parameters[1].Value.SetWideString(vObjJSON);
  FInsertChatCommand.Execute(ARequestFilter);
  Result := FInsertChatCommand.Parameters[2].Value.GetWideString;
end;

function TdsmChatClient.DeleteChat(vTicket: string; vObjJSON: string; const ARequestFilter: string): string;
begin
  if FDeleteChatCommand = nil then
  begin
    FDeleteChatCommand := FConnection.CreateCommand;
    FDeleteChatCommand.RequestType := 'GET';
    FDeleteChatCommand.Text := 'TdsmChat.DeleteChat';
    FDeleteChatCommand.Prepare(TdsmChat_DeleteChat);
  end;
  FDeleteChatCommand.Parameters[0].Value.SetWideString(vTicket);
  FDeleteChatCommand.Parameters[1].Value.SetWideString(vObjJSON);
  FDeleteChatCommand.Execute(ARequestFilter);
  Result := FDeleteChatCommand.Parameters[2].Value.GetWideString;
end;

function TdsmChatClient.UpdateChat(vTicket: string; vObjJSON: string; const ARequestFilter: string): string;
begin
  if FUpdateChatCommand = nil then
  begin
    FUpdateChatCommand := FConnection.CreateCommand;
    FUpdateChatCommand.RequestType := 'GET';
    FUpdateChatCommand.Text := 'TdsmChat.UpdateChat';
    FUpdateChatCommand.Prepare(TdsmChat_UpdateChat);
  end;
  FUpdateChatCommand.Parameters[0].Value.SetWideString(vTicket);
  FUpdateChatCommand.Parameters[1].Value.SetWideString(vObjJSON);
  FUpdateChatCommand.Execute(ARequestFilter);
  Result := FUpdateChatCommand.Parameters[2].Value.GetWideString;
end;

constructor TdsmChatClient.Create(ARestConnection: TDSRestConnection);
begin
  inherited Create(ARestConnection);
end;

constructor TdsmChatClient.Create(ARestConnection: TDSRestConnection; AInstanceOwner: Boolean);
begin
  inherited Create(ARestConnection, AInstanceOwner);
end;

destructor TdsmChatClient.Destroy;
begin
  FFDConnectionBeforeConnectCommand.DisposeOf;
  FAutenticacaoCommand.DisposeOf;
  FAutenticacaoCommand_Cache.DisposeOf;
  FGetChatCommand.DisposeOf;
  FGetChatCommand_Cache.DisposeOf;
  FInsertChatCommand.DisposeOf;
  FDeleteChatCommand.DisposeOf;
  FUpdateChatCommand.DisposeOf;
  inherited;
end;

end.

