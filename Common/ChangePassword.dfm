object frmChangePassword: TfrmChangePassword
  Left = 849
  Top = 131
  ActiveControl = edtOldPassword
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Zm'#283'na hesla'
  ClientHeight = 176
  ClientWidth = 394
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 17
  object Label1: TLabel
    Left = 16
    Top = 84
    Width = 123
    Height = 16
    AutoSize = False
    Caption = '&Potvrzen'#237' hesla:'
    FocusControl = edtConfirmation
  end
  object Label2: TLabel
    Left = 16
    Top = 52
    Width = 123
    Height = 16
    AutoSize = False
    Caption = '&Heslo:'
    FocusControl = edtPassword
  end
  object Label3: TLabel
    Left = 16
    Top = 20
    Width = 123
    Height = 16
    AutoSize = False
    Caption = 'P'#367'&vodn'#237' heslo:'
    FocusControl = edtOldPassword
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 157
    Width = 394
    Height = 19
    Panels = <>
  end
  object edtConfirmation: TEdit
    Left = 160
    Top = 80
    Width = 209
    Height = 25
    PasswordChar = '*'
    TabOrder = 2
  end
  object edtPassword: TEdit
    Left = 160
    Top = 48
    Width = 209
    Height = 25
    PasswordChar = '*'
    TabOrder = 1
  end
  object btnOk: TBitBtn
    Tag = 95
    Left = 216
    Top = 120
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    DoubleBuffered = True
    NumGlyphs = 2
    ParentDoubleBuffered = False
    TabOrder = 3
    OnClick = btnOkClick
  end
  object btnCancel: TBitBtn
    Tag = 95
    Left = 296
    Top = 120
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Storno'
    DoubleBuffered = True
    ModalResult = 2
    NumGlyphs = 2
    ParentDoubleBuffered = False
    TabOrder = 4
  end
  object edtOldPassword: TEdit
    Left = 160
    Top = 16
    Width = 209
    Height = 25
    PasswordChar = '*'
    TabOrder = 0
  end
  object spUusr_password: TADOStoredProc
    Connection = dmCommon.cnOperatorConnection
    ProcedureName = 'ws.sp_u_user_password;1'
    Parameters = <>
    Left = 248
    Top = 32
  end
end
