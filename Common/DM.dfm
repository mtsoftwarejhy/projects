object dmDM: TdmDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 150
  Width = 215
  object qrSmdl: TADODataSet
    Connection = dmCommon.cnOperatorConnection
    Parameters = <>
    Left = 24
    Top = 32
  end
  object qrExecute: TADOCommand
    Connection = dmCommon.cnOperatorConnection
    Parameters = <>
    Left = 96
    Top = 32
  end
end
