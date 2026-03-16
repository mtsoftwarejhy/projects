object frmLogin: TfrmLogin
  Left = 535
  Top = 423
  ActiveControl = edtJmeno
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'P'#345'ihl'#225#353'en'#237
  ClientHeight = 201
  ClientWidth = 492
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object Label1: TLabel
    Left = 16
    Top = 20
    Width = 169
    Height = 16
    AutoSize = False
    Caption = '&K'#243'd:'
    FocusControl = edtJmeno
  end
  object Label2: TLabel
    Left = 16
    Top = 52
    Width = 169
    Height = 16
    AutoSize = False
    Caption = '&Heslo:'
    FocusControl = edtHeslo
  end
  object lblDefaultLanguage: TLabel
    Left = 16
    Top = 116
    Width = 169
    Height = 16
    AutoSize = False
    Caption = '&Jazyk:'
  end
  object edtJmeno: TEdit
    Left = 192
    Top = 16
    Width = 281
    Height = 25
    TabOrder = 0
  end
  object edtHeslo: TEdit
    Left = 192
    Top = 48
    Width = 281
    Height = 25
    PasswordChar = '*'
    TabOrder = 1
  end
  object cbChangeLang: TCheckBox
    Left = 192
    Top = 84
    Width = 281
    Height = 21
    Caption = 'Zm'#283'nit v'#253'choz'#237' jazyk u'#382'ivatele'
    TabOrder = 2
    OnClick = cbChangeLangClick
  end
  object cbDefaultLanguage: TDBLookupComboBox
    Left = 192
    Top = 112
    Width = 281
    Height = 25
    Enabled = False
    KeyField = 'lng_s_code'
    ListField = 'lng_s_name'
    ListSource = dsLng
    TabOrder = 3
    OnClick = cbDefaultLanguageClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 140
    Width = 492
    Height = 42
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 5
    object btnOk: TBitBtn
      Left = 320
      Top = 8
      Width = 75
      Height = 25
      Caption = 'OK'
      Default = True
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnOkClick
    end
    object btnCancel: TBitBtn
      Left = 400
      Top = 8
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Storno'
      ModalResult = 2
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 182
    Width = 492
    Height = 19
    Panels = <>
  end
  object dsLng: TDataSource
    DataSet = dmCommon.qrSlng
    Left = 96
    Top = 108
  end
end
