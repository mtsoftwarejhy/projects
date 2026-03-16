object frmComplexes: TfrmComplexes
  Left = 487
  Top = 229
  ActiveControl = dbgridComplexes
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'V'#253'b'#283'r provozu'
  ClientHeight = 556
  ClientWidth = 484
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object Panel2: TPanel
    Left = 0
    Top = 515
    Width = 484
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      484
      41)
    object btnOK: TButton
      Tag = 21
      Left = 316
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancel: TButton
      Tag = 24
      Left = 396
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = 'Storno'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object dbgridComplexes: TcxGrid
    Left = 0
    Top = 0
    Width = 484
    Height = 515
    Align = alClient
    PopupMenu = PopupMenu1
    TabOrder = 0
    OnContextPopup = dbgridComplexesContextPopup
    OnEnter = dbgridComplexesEnter
    LookAndFeel.Kind = lfFlat
    LookAndFeel.NativeStyle = False
    object dbgridComplexesDBTableView1: TcxGridDBTableView
      Navigator.Buttons.Insert.Visible = False
      Navigator.Buttons.Delete.Visible = False
      Navigator.Buttons.Edit.Visible = False
      Navigator.Buttons.Post.Visible = False
      Navigator.Buttons.Cancel.Visible = False
      Navigator.Buttons.Refresh.Visible = False
      Navigator.Visible = True
      OnCellDblClick = dbgridComplexesDBTableView1CellDblClick
      OnFocusedRecordChanged = dbgridComplexesDBTableView1FocusedRecordChanged
      DataController.DataSource = dsSwcx
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Column = dbgridComplexesDBTableView1wcx_s_name1
        end>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.IncSearch = True
      OptionsBehavior.NavigatorHints = True
      OptionsCustomize.ColumnHiding = True
      OptionsCustomize.DataRowSizing = True
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.Footer = True
      OptionsView.Indicator = True
      object dbgridComplexesDBTableView1wcx_s_name1: TcxGridDBColumn
        Caption = 'N'#225'zev'
        DataBinding.FieldName = 'wcx_s_name'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taLeftJustify
        Properties.ReadOnly = True
        HeaderAlignmentHorz = taCenter
        Width = 350
      end
      object dbgridComplexesDBTableView1wcx_s_code1: TcxGridDBColumn
        Caption = 'K'#243'd'
        DataBinding.FieldName = 'wcx_s_code'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.Alignment.Horz = taLeftJustify
        Properties.ReadOnly = True
        HeaderAlignmentHorz = taCenter
        Width = 150
      end
      object dbgridComplexesDBTableView1cmp_n_id: TcxGridDBColumn
        DataBinding.FieldName = 'cmp_n_id'
        Visible = False
        HeaderAlignmentHorz = taCenter
      end
      object dbgridComplexesDBTableView1wcx_n_id: TcxGridDBColumn
        DataBinding.FieldName = 'wcx_n_id'
        Visible = False
        HeaderAlignmentHorz = taCenter
      end
    end
    object dbgridComplexesLevel1: TcxGridLevel
      GridView = dbgridComplexesDBTableView1
    end
  end
  object dsSwcx: TDataSource
    AutoEdit = False
    DataSet = qrSwcx
    Left = 136
    Top = 120
  end
  object qrSwcx: TADODataSet
    Connection = dmCommon.cnSystemConnection
    CommandText = 
      'SELECT DISTINCT'#13#10'  cmp.cmp_n_id,'#13#10'  wcx.wcx_n_id,'#13#10'  wcx.wcx_s_c' +
      'ode,'#13#10'  wcx.wcx_s_name'#13#10'FROM  ws.t_wcx_work_complexes AS wcx'#13#10'IN' +
      'NER JOIN ws.t_cmp_computers AS cmp'#13#10'ON wcx.wcx_n_id = cmp.wcx_n_' +
      'id'#13#10'WHERE cmp.cmp_s_name = :cmp_s_name'#13#10
    Parameters = <
      item
        Name = 'cmp_s_name'
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 250
        Value = Null
      end>
    Left = 80
    Top = 120
    object qrSwcxcmp_n_id: TAutoIncField
      FieldName = 'cmp_n_id'
      ReadOnly = True
    end
    object qrSwcxwcx_n_id: TAutoIncField
      FieldName = 'wcx_n_id'
      ReadOnly = True
    end
    object qrSwcxwcx_s_code: TWideStringField
      FieldName = 'wcx_s_code'
      Size = 10
    end
    object qrSwcxwcx_s_name: TWideStringField
      FieldName = 'wcx_s_name'
      Size = 50
    end
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 296
    Top = 64
  end
  object cxGridPopupMenu1: TcxGridPopupMenu
    Grid = dbgridComplexes
    PopupMenus = <>
    Left = 192
    Top = 64
  end
end
