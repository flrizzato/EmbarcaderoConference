object DM_ModuloEnvio: TDM_ModuloEnvio
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 150
  Width = 215
  object TetheringAppProfile1: TTetheringAppProfile
    Manager = TetheringManager1
    Text = 'TetheringAppProfile1'
    Group = 'nfce'
    Actions = <>
    Resources = <>
    Left = 40
    Top = 32
  end
  object TetheringManager1: TTetheringManager
    OnEndManagersDiscovery = TetheringManager1EndManagersDiscovery
    OnRequestManagerPassword = TetheringManager1RequestManagerPassword
    Text = 'ServidorTether'
    AllowedAdapters = 'Network'
    Left = 40
    Top = 88
  end
end
