object dmCommon: TdmCommon
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 364
  Width = 550
  object cnSystemConnection: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=relttem;Persist Security Info=True;' +
      'User ID=ws;Initial Catalog=db_winformula_zentiva;Data Source=PC1' +
      '\MSSQL2008;Application Name=aaaa'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    AfterConnect = cnOperatorConnectionAfterConnect
    Left = 192
    Top = 24
  end
  object cnOperatorConnection: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=relttem;Persist Security Info=True;' +
      'User ID=ws;Initial Catalog=db_winformula_zentiva;Data Source=PC1' +
      '\MSSQL2019;Use Procedure for Prepare=1;Auto Translate=True;Packe' +
      't Size=4096;Application Name=an;Workstation ID=PC1;Use Encryptio' +
      'n for Data=False;Tag with column collation when possible=False'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    AfterConnect = cnOperatorConnectionAfterConnect
    Left = 56
    Top = 24
  end
  object qrSusr: TADODataSet
    Connection = cnSystemConnection
    CommandText = 
      'SELECT usr_n_id'#13#10'FROM ids.t_usr_users'#13#10'WHERE usr_s_login = :usr_' +
      's_login'#13#10'AND usr_b_history = 0'
    Parameters = <
      item
        Name = 'usr_s_login'
        DataType = ftString
        Size = -1
        Value = Null
      end>
    Left = 32
    Top = 96
  end
  object qrDrecord: TADOCommand
    Connection = cnOperatorConnection
    Parameters = <>
    Left = 32
    Top = 224
  end
  object qrSurh: TADODataSet
    Connection = cnOperatorConnection
    CommandText = 
      'SELECT DISTINCT urh.urh_n_id'#13#10'FROM ws.t_urh_user_rights AS urh'#13#10 +
      'INNER JOIN ws.t_grh_right_group_allocation AS grh'#13#10'ON grh.urh_n_' +
      'id = urh.urh_n_id'#13#10'INNER JOIN ws.t_uga_user_group_allocation AS ' +
      'uga'#13#10'ON uga.ugr_n_id = grh.ugr_n_id'#13#10'AND uga.usr_n_id = :usr_n_i' +
      'd'#13#10'WHERE LOWER(urh.urh_s_code) = LOWER(:urh_s_code)'#13#10
    Parameters = <
      item
        Name = 'usr_n_id'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'urh_s_code'
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 10
        Value = Null
      end>
    Left = 96
    Top = 96
  end
  object qrSmdlM: TADODataSet
    Connection = cnOperatorConnection
    CommandText = 
      'SELECT mdl.mdl_b_multiple_run '#13#10'FROM  ws.t_mdl_modules mdl'#13#10'WHER' +
      'E RTRIM(mdl.mdl_s_exe_name) = :mdl_s_exe_name'
    CommandTimeout = 15
    Parameters = <
      item
        Name = 'mdl_s_exe_name'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 50
        Value = Null
      end>
    Left = 136
    Top = 160
  end
  object qrSmdl: TADODataSet
    Connection = cnSystemConnection
    CommandText = 
      'SELECT'#13#10'  mdl.mdl_n_id,'#13#10'  mdl.mdl_s_name,'#13#10'  mdl.mdl_s_code,'#13#10' ' +
      ' mdl.mdl_b_independent,'#13#10'  btt.btt_s_text AS btt_mdl_s_name'#13#10'FRO' +
      'M ws.t_mdl_modules AS mdl'#13#10'INNER JOIN ws.t_btt_base_tables_texts' +
      ' AS btt'#13#10'ON mdl.mdl_s_code = btt.btt_s_text_code'#13#10'AND btt.btt_s_' +
      'base_table_name = '#39't_mdl_modules'#39#13#10'AND btt.btt_s_field_name = '#39'm' +
      'dl_s_name'#39#13#10'INNER JOIN ws.t_lng_languages AS lng'#13#10'ON btt.lng_n_i' +
      'd = lng.lng_n_id'#13#10'AND UPPER(lng.lng_s_code) = UPPER(:lng_s_code)' +
      #13#10'WHERE UPPER(mdl.mdl_s_exe_name) = UPPER(:mdl_s_exe_name)'#13#10
    CommandTimeout = 15
    Parameters = <
      item
        Name = 'lng_s_code'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 3
        Value = Null
      end
      item
        Name = 'mdl_s_exe_name'
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 50
        Value = Null
      end>
    Left = 32
    Top = 160
  end
  object spDold_rmd: TADOStoredProc
    Connection = cnOperatorConnection
    ProcedureName = 'ws.sp_d_old_running_modules'
    Parameters = <>
    Left = 136
    Top = 224
  end
  object spScheck_rmd: TADODataSet
    Connection = cnSystemConnection
    CommandText = 
      'SELECT ws.fn_b_check_running_modules'#13#10'('#13#10':mdl_s_code,'#13#10':wcx_n_id' +
      ','#13#10'GETDATE()'#13#10')'#13#10'AS n_result'
    CommandTimeout = 15
    Parameters = <
      item
        Name = 'mdl_s_code'
        DataType = ftString
        Size = 3
        Value = Null
      end
      item
        Name = 'wcx_n_id'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    Left = 272
    Top = 160
  end
  object fnBmodule_state: TADOStoredProc
    Connection = cnOperatorConnection
    ProcedureName = 'ws.fn_b_module_state'
    Parameters = <>
    Left = 232
    Top = 224
  end
  object fnImail_send: TADOStoredProc
    Connection = cnOperatorConnection
    ProcedureName = 'ws.sp_i_mail_send'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@p_n_wcx_id'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@p_n_recipient_type'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@p_n_recipient_id'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@p_n_sender_type'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@p_n_sender_id'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@p_n_mail_type'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@p_s_subject'
        Attributes = [paNullable]
        DataType = ftWideString
        Size = 500
        Value = Null
      end
      item
        Name = '@p_s_body'
        Attributes = [paNullable]
        DataType = ftWideString
        Size = 500
        Value = Null
      end>
    Left = 256
    Top = 280
  end
  object tmrApplicationTerminate: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = tmrApplicationTerminateTimer
    Left = 352
    Top = 24
  end
  object qrSdcf: TADODataSet
    Connection = cnSystemConnection
    CommandText = 'SELECT COUNT(*)'#13#10'FROM ws.t_dcf_database_configuration'#13#10
    Parameters = <>
    Left = 320
    Top = 96
  end
  object sdExportToFile: TSaveDialog
    Title = 'Export do souboru'
    OnCanClose = sdExportToFileCanClose
    Left = 376
    Top = 160
  end
  object alGrid: TActionList
    Left = 464
    Top = 24
    object aExportToXML: TAction
      Category = 'File'
      Caption = '&XML'
      Hint = 'Prov'#233'st export dat do souboru typu XML'
      OnExecute = aExportToXMLExecute
    end
    object aExportToCSV: TAction
      Category = 'File'
      Caption = '&CSV'
      Hint = 'Prov'#233'st export dat do souboru typu CSV'
      OnExecute = aExportToCSVExecute
    end
    object aExportToXLS: TAction
      Category = 'File'
      Caption = 'XL&S'
      Hint = 'Prov'#233'st export dat do souboru Excel'
      OnExecute = aExportToXLSExecute
    end
    object aDefaultSettings: TAction
      Category = 'Report'
      Caption = '&V'#253'choz'#237' nastaven'#237
      Hint = 'Obnovit standardn'#237' nastaven'#237' vzhledu'
      OnExecute = aDefaultSettingsExecute
    end
    object aShowHideColumns: TAction
      Category = 'Report'
      Caption = '&Zobrazit/skr'#253't sloupce'
      Hint = 'Zobrazit/skr'#253't sloupce'
      OnExecute = aShowHideColumnsExecute
    end
  end
  object PopupMenu: TPopupMenu
    Left = 384
    Top = 96
    object N2: TMenuItem
      Caption = '-'
    end
    object miExportToFile: TMenuItem
      Caption = '&Export do souboru'
      Hint = 'Export do souboru'
      object miCVS: TMenuItem
        Action = aExportToCSV
      end
      object miXML: TMenuItem
        Action = aExportToXML
      end
      object miExcel: TMenuItem
        Action = aExportToXLS
      end
    end
    object miShowHideColumns: TMenuItem
      Caption = '&Zobrazit/skr'#253't sloupce'
      Hint = 'Zobrazit/skr'#253't sloupce'
      OnClick = aShowHideColumnsExecute
    end
    object miDefaultSettings: TMenuItem
      Action = aDefaultSettings
    end
  end
  object qrSlng: TADODataSet
    Connection = cnSystemConnection
    CommandText = 
      'SELECT'#13#10'  lng_n_id,'#13#10'  lng_s_code,'#13#10'  lng_s_name'#13#10'FROM ws.t_lng_' +
      'languages'#13#10'ORDER BY lng_s_name'
    Parameters = <>
    Left = 272
    Top = 96
    object qrSlnglng_n_id: TAutoIncField
      FieldName = 'lng_n_id'
      ReadOnly = True
    end
    object qrSlnglng_s_code: TWideStringField
      FieldName = 'lng_s_code'
      Size = 3
    end
    object qrSlnglng_s_name: TWideStringField
      FieldName = 'lng_s_name'
      Size = 50
    end
  end
  object ilFlags: TImageList
    ImageType = itMask
    Left = 336
    Top = 280
    Bitmap = {
      494C010103000500040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A531210052106B000000C6000000
      CE000808CE001818DE002929EF004242F7004A4AFF005252F7004242E7003131
      D6003131C6002929BD002121AD001818A500C6C6D6006363BD00524A9C007B4A
      4A007329080073291800B5948C007373E7007B73E700CEADA5008C5242007B42
      31009C736B00B5B5AD008484AD004A4A94008C421800842908007B2100008421
      00007B39180021C6D60029DEEF0042E7FF004AEFFF0052E7FF0042CEEF00314A
      CE003139C6002931B5002129AD0018219C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BD4A3900AD291800731031001800
      A5000000D6001010D6002121DE003131EF004242F7005252FF004A4AF7004242
      E7003131CE002929C6002929B5002121AD00AD847300C6BDBD008C8CC6004A42
      B500735A7B007B392100A58473006B63D600736BE700C6ADA500A56B5A00CEBD
      AD00BDBDCE007373BD00635A9400735252009C5A39008C3918007B2900007B21
      00007B31100010B5CE0021CEE70031DEF70042E7FF0052EFFF004ADEF700425A
      DE003139CE002939BD002931B5002129A5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6635200AD423100A52110009410
      0800420873000000CE001010DE002121E7003939EF004A4AFF005252FF004A4A
      EF003939DE003131CE002929C6002121B500A56B520094635200BDAD9C00BDBD
      CE006363BD0073639C00BDADAD005A52C600635AD600E7DED600F7EFE700D6D6
      EF00847BCE0094849C008C634A0073422900B56B52009C523100843110008421
      00007331100008ADC60010C6DE0021CEEF0039DEF7004AEFFF0052E7FF004A63
      EF00394AD6003139C6002939BD002131AD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D6736300C65A4A00AD3921009C18
      08009C100000731031002908A5001818DE002929E7003939F7004A4AFF005252
      F7004A4AEF003939D6003131CE002929BD00DED6EF00C6BDD600ADA5C600ADA5
      C600A5A5C6009494C600A5A5CE004239B5004A42BD00CECEF700DEDEFF00CECE
      EF00C6C6E700BDB5C600A59CB5009C9CB500C6846300AD6B4A00944A21008431
      08007331100008ADC60008BDD60018C6DE0029D6EF0039E7FF004AE7FF00526B
      F7004A52E7003942CE003139C6002931B5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D6736300D66B5A00BD524200A531
      18009C180800A51000009410000052106B002929DE003939EF004A4AF7005A5A
      FF005A5AF7004A4AE7003939D6003939C6007B73D600736BD600524AC6003129
      AD0021109C0018109C0018109C002118A5003129B5004239C6005A4ACE00635A
      D600635AD6005A52C6004A42B5004239AD00BD846300BD7B5A00A56342009442
      18007B39100000ADC60000B5CE0008BDD60018C6E70029DEEF0042DEFF004A63
      F700525AEF004252DE003142CE003139C6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A5423900DE7B6B00CE635200B54A
      3900A5291800940800009C210800BD847B00CECEDE00DEDEE700E7E7F700F7F7
      FF00F7F7FF00EFEFF700DEDEE700CECED6004A42A5007B73DE006B63D6004A42
      BD003121A50018109C0018089C0018109C002918AD003929B5004A42C6005A52
      D600635AD600635ACE00524AC6004A42AD0094523900C6846B00BD735200A552
      39008442210008ADC60000B5CE0000B5D60010BDDE0021CEE70031D6F700425A
      F700525AF7004A5AEF00424ADE003142CE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000084292100B5524200DE736B00C65A
      5200AD393100AD5A4A00C6B5B500CECECE00D6D6D600DEDEDE00EFEFEF00F7F7
      F700FFFFFF00FFFFFF00F7F7F700DEE7E70084849400B5ADC600DEDEEF00C6C6
      E700A5A5CE00ADADCE00A5A5C60029219C002921A500ADA5D600ADADDE00CECE
      EF00DEDEF700D6CEE700C6C6DE00BDB5CE00733921009C634200C6846B00B56B
      5200945A390018B5C60000B5CE0000B5CE0000B5D60010C6DE0021C6E7003952
      EF004A52F700525AF7004A5AE700394AD6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006B1008008C312900C65A5A00DE84
      7300DEB5AD00DED6D600CECECE00CECECE00CECECE00D6D6D600DEDEDE00EFEF
      EF00FFFFFF00FFFFFF00FFFFFF00EFEFEF004A2108007B5A4200B5A5B500A59C
      E700C6C6E700D6CEC600B5AD9C003129A5003129A500B5A5A5007B73AD008484
      DE00E7E7F700F7E7D600BD8C73009C634A005A2108007B422900B5735A00C67B
      6300A56B520029BDCE0008B5CE0000B5CE0000B5CE0008BDD60018BDDE002942
      DE00394AEF004A5AF700525AF7004A52E7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005A08000073181000A56B6300F7EF
      E700FFFFFF00E7E7E700D6D6D600CECECE00CECECE00CECECE00D6D6D600E7E7
      E700EFEFEF00FFFFFF00FFFFFF00FFFFFF004A2929004A4273006B6BAD00E7E7
      F700E7D6CE00946352009C736B003939B5003129AD00946B630073312100846B
      8C007373D600BDBDF700F7EFEF00C69C8C004A18000063291000844A3100C684
      6300B5846B0042CEDE0018BDD60008B5CE0000B5CE0000B5CE0008B5D6001831
      D6002939E7004252EF004A5AF700525AEF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000063100800735252009C9C9C00C6C6
      C600FFFFFF00F7F7F700E7E7E700D6D6D600CECECE00CECECE00D6D6D600DEDE
      DE00E7E7E700F7F7F700FFFFFF00FFFFFF0029296B0052527B00949494009C7B
      7300AD7B6B009C635200AD948C004A42BD003129AD00946B6B005A1000007331
      1000946B6300847BC6009C94EF00EFEFFF004A1800004A1800006B3118009452
      3900BD8C73005ADEEF0039CEE70018BDD60000B5CE0000B5CE0000ADCE001029
      CE002129D6003142E7004252F700525AF7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFF0000FFFFFFFFFFFF0000
      FFFFFFFFFFFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FFFFFFFFFFFF0000
      FFFFFFFFFFFF0000FFFFFFFFFFFF000000000000000000000000000000000000
      000000000000}
  end
  object qrADODataSet: TADODataSet
    Parameters = <>
    Left = 392
    Top = 216
  end
  object qrSpar: TADODataSet
    Connection = cnOperatorConnection
    CommandText = 
      'SELECT par.par_s_code, mcf.mcf_s_value '#13#10'FROM ws.t_mcf_modules_c' +
      'onfiguration AS mcf'#13#10'INNER JOIN ws.t_par_parameters AS par'#13#10'ON m' +
      'cf.par_n_id = par.par_n_id'#13#10'INNER JOIN ws.t_mca_module_computer_' +
      'allocation AS mca'#13#10'ON mcf.mca_n_id = mca.mca_n_id'#13#10'AND mca.cmp_n' +
      '_id = :cmp_n_id'#13#10'AND mca.mdl_n_id = :mdl_n_id'#13#10'LEFT JOIN ws.t_pg' +
      'r_parameter_groups AS pgr'#13#10'ON mca.mdl_n_id = pgr.mdl_n_id'#13#10
    Parameters = <
      item
        Name = 'cmp_n_id'
        Size = -1
        Value = Null
      end
      item
        Name = 'mdl_n_id'
        Size = -1
        Value = Null
      end>
    Left = 200
    Top = 160
  end
  object fnSget_usr_lang: TADOStoredProc
    Connection = cnOperatorConnection
    ProcedureName = 'ws.fn_s_get_usr_language'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        Attributes = [paNullable]
        DataType = ftWideString
        Direction = pdReturnValue
        Size = 250
        Value = Null
      end
      item
        Name = '@p_n_user_id'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 160
    Top = 280
  end
end
