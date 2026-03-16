{-----------------------------------------------------------------------------------------------------------------------------------------------------
 Project:      WinFormula, WinProduction
 Module:       Konfigurace provoz˘
 File name:    DM.pas

 Description:  DatovÈ zdroje

 Author:       Michal »ervenka
 Creation:     22.11.2006
 Change:
   01.01.2007 TV - nahrazenÌ transakcÌ komponentou TClientDataSet
   16.05.2007 TV - lokalizace
   31.10.2007 M» - oprava naËtenÌ resource string˘ pro log
   06.01.2008 M» - Funkce ExternalCodeExists
   23.03.2008 M» - Funkce InsertModuleComputerAllocation
   30.03.2008 M» - ⁄prava funkce InitTranslate
   25.04.2008 M» - ⁄prava procedury DataModuleCreate, odstranÏna funkce InitTranslate
   23.08.2008 HF - ⁄prava dotazu - pouûitÌ funkce MyQuotedStr
   24.06.2009 M» - P¯id·nÌ pole mdl_b_virtual p¯i p¯id·v·nÌ modulu
   15.09.2018 M» - ZmÏna n·zvu tabulky t_sst_simatic_statuses > t_tst_tank_statuses (URS 056)
   13.04.2025 M» - New functions DeleteKeysForComputer and ResetPrintKeysInWorksites (URS 649)
   16.11.2025 M» - New functions InsertUnweighedBatch and UpdateUnweighedBatch (URS 662)
-----------------------------------------------------------------------------------------------------------------------------------------------------}
unit DM;

interface

uses
  SysUtils, Classes, DB, ADODB, DBClient, IniFiles, Dialogs;

type
  TdmDM = class(TDataModule)
    qrSmdl: TADODataSet;
    qrExecute: TADOCommand;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    slResourceString: THashedStringList;
    slLogResourceString: THashedStringList;
    FModuleName: String;
  published
    { Public declarations }
    property ResourceStringList: THashedStringList read slResourceString write slResourceString;
    property LogResourceStringList: THashedStringList read slLogResourceString write slLogResourceString;
    property ModuleName: String read FModuleName write FModuleName;
    {$IFDEF MULTILANGUAGE}
    procedure TranslateResourceStrings;
   {$ENDIF}
  public
    { Public declarations }
    function DBMdlModuleExists(p_byOpen, p_bySqlName: byte; p_sName, p_sOldName: String): Boolean;
    function DBMcaModuleAllocationExists(p_nId: Integer): Boolean;
    function DBInsertMdl(p_cdSmdl: TClientDataSet): Integer;
    function DBUpdateMdl(p_cdSmdl: TClientDataSet; p_nMdlID: Integer): Integer;
    function InsertRca(p_nWcxId, p_nRptId, p_nRcaVersion: Integer): Boolean;
    function UpdateRca(p_nRcaId, p_nRcaVersion: Integer): Boolean;
    function UpdateKra(p_nKraId: Integer): Boolean;
    function UpdateAutoBatch(p_nAcbId: Integer; const p_sBatchCode: String): Boolean;
    function InsertKra(p_nRcaId: Integer; const p_sKraKey: String): Boolean;
    function InsertAutoBatch(p_nWcxId: Integer; const p_sBatchCode: String): Boolean;
    function ExternalCodeExists(p_sExternalCode: String): Integer;
    procedure WriteToLog(p_ResStringRec: PResStringRec; p_sResStringName: String; const Args: array of const);
    procedure GetLogResourceStrings;
    function InsertModuleComputerAllocation(p_nComputerId, p_nModuleId: Integer): Boolean;
    function DeleteTankStatus(p_nTstId: Integer): Boolean;
    function InsertTankStatus(p_nWcxId, p_nNumber: Integer; p_sName, p_sKind, p_sCode: String): Boolean;
    function UpdateTankStatus(p_nTstId, p_nNumber: Integer; p_sName, p_sKind, p_sCode: String): Boolean;
    function DeleteKeysForComputer(p_nCmpId: Integer): Boolean;
    function ResetPrintKeysInWorksites(p_nKcaId: Integer): Boolean;
    function InsertUnweighedBatch(p_nWcxId: Integer; const p_sBatchCode: String): Boolean;
    function UpdateUnweighedBatch(p_nUwbId: Integer; const p_sBatchCode: String): Boolean;
  end;

const
  cnInsert = 1;
  cnUpdate = 2;

resourcestring
  resDM_ChybaPriZjisOvaniExistenceModulu = 'Chyba p¯i zjiöùov·nÌ existence modulu! %s';

var
  dmDM: TdmDM;

implementation

uses
  Common;

{$R *.dfm}

function TdmDM.DBMdlModuleExists(p_byOpen, p_bySqlName: byte; p_sName, p_sOldName: String): Boolean;
// zkontroluje, jestli kÛd, n·zev nebo n·zev exe souboru modulu jiû exituje
var
  lsSqlName: String;
begin
  Result := False;

  case p_bySqlName of
    1: lsSqlName := 'mdl_s_code';
    2: lsSqlName := 'mdl_s_name';
    3: lsSqlName := 'mdl_s_exe_name';
  end;

  try
    try
      qrSmdl.Close;
      qrSmdl.CommandText :=
        'SELECT mdl_s_code ' +
        'FROM ws.t_mdl_modules ' +
        'WHERE ' + lsSqlName + ' = ' + MyQuotedStr(p_sName) + ' ';

      if p_byOpen = cnUpdate then
      begin
        qrSmdl.CommandText := qrSmdl.CommandText +
          'AND ' + lsSqlName + ' <> ' + MyQuotedStr(p_sOldName) + ' ';
      end;

      if not MyOpenQuery(qrSmdl) then
      begin
        Exit;
      end;

      Result := not qrSmdl.IsEmpty;
    finally
      qrSmdl.Close;
    end;
  except
    on E: Exception do
    begin
      // Chyba p¯i zjiöùov·nÌ existence modulu!
      WriteToLog(PResStringRec(@resDM_ChybaPriZjisOvaniExistenceModulu), 'resDM_ChybaPriZjisOvaniExistenceModulu', ['(' + E.Message + ')']);
      MyMessageBox(Format(resDM_ChybaPriZjisOvaniExistenceModulu, [#13#13 + E.Message]), mtError);
    end;
  end;
end;

function TdmDM.DBMcaModuleAllocationExists(p_nId: Integer): Boolean;
// zkontroluje, jestli je modul jiû p¯i¯azen k nÏjakÈmu poËitaËi
begin
  Result := False;

  try
    try
      qrSmdl.Close;
      qrSmdl.CommandText :=
        'SELECT mdl.mdl_n_id ' +
        'FROM ws.t_mca_module_computer_allocation AS mca ' +
        'INNER JOIN ws.t_mdl_modules AS mdl ' +
        'ON  mca.mdl_n_id = mdl.mdl_n_id ' +
        'WHERE mdl.mdl_n_id = ' + IntToStr(p_nId);

      if not MyOpenQuery(qrSmdl) then
      begin
        Exit;
      end;

      Result := not qrSmdl.IsEmpty;
    finally
      qrSmdl.Close;
    end;
  except
    on E: Exception do
    begin
      // Chyba p¯i zjiöùov·nÌ existence modulu!
      WriteToLog(PResStringRec(@resDM_ChybaPriZjisOvaniExistenceModulu), 'resDM_ChybaPriZjisOvaniExistenceModulu', ['(' + E.Message + ')']);
      MyMessageBox(Format(resDM_ChybaPriZjisOvaniExistenceModulu, [#13#13 + E.Message]), mtError);
    end;
  end;
end;

function TdmDM.DBInsertMdl(p_cdSmdl: TClientDataSet): Integer;
begin
  qrExecute.CommandText :=
    'INSERT ws.t_mdl_modules ' +
    '  ( ' +
    '  mdl_s_code, ' +
    '  mdl_s_name, ' +
    '  mdl_s_exe_name, ' +
    '  mdl_s_description, ' +
    '  mdl_b_multiple_run, ' +
    '  mdl_n_max_running, ' +
    '  mdl_b_system, ' +
    '  mdl_b_virtual, ' +
    '  created_by, ' +
    '  changed_by ' +
    '  ) ' +
    'VALUES ' +
    '  (' +
       MyQuotedStr(Trim(p_cdSmdl.FieldByName('mdl_s_code').AsString)) + ', ' +
       MyQuotedStr(Trim(p_cdSmdl.FieldByName('mdl_s_name').AsString)) + ', ' +
       MyQuotedStr(Trim(p_cdSmdl.FieldByName('mdl_s_exe_name').AsString)) + ', ' +
       CheckNULL(p_cdSmdl.FieldByName('mdl_s_description').AsString) +
       BoolToStr(p_cdSmdl.FieldByName('mdl_b_multiple_run').AsBoolean) + ', ' +
       IntToStr(-1) + ', ' +
       BoolToStr(p_cdSmdl.FieldByName('mdl_b_system').AsBoolean) + ', ' +
       BoolToStr(p_cdSmdl.FieldByName('mdl_b_virtual').AsBoolean) + ', ' +
       IntToStr(gnUserID) + ', ' +
       IntToStr(gnUserID) +
    '  )';

    if MyExecuteQuery(qrExecute, True, True, False) then
    begin
      Result := dmCommon.GetLastID('ws.t_mdl_modules', 'mdl_n_id');
    end else
    begin
      Result := -1;
    end;
end;

function TdmDM.DBUpdateMdl(p_cdSmdl: TClientDataSet; p_nMdlID: Integer): Integer;
begin
  qrExecute.CommandText :=
    'UPDATE ws.t_mdl_modules ' +
    'SET mdl_s_code = ' + MyQuotedStr(Trim(p_cdSmdl.FieldByName('mdl_s_code').AsString)) + ', ' +
    '  mdl_s_name = ' + MyQuotedStr(Trim(p_cdSmdl.FieldByName('mdl_s_name').AsString)) + ', ' +
    '  mdl_s_exe_name = ' +
      MyQuotedStr(Trim(p_cdSmdl.FieldByName('mdl_s_exe_name').AsString)) + ', ' +
    '  mdl_s_description = ' + CheckNULL(p_cdSmdl.FieldByName('mdl_s_description').AsString) +
    '  mdl_b_multiple_run = ' +
      BoolToStr(p_cdSmdl.FieldByName('mdl_b_multiple_run').AsBoolean) + ', ' +
    '  changed_by = ' + IntToStr(gnUserID) + ', ' +
    '  changed_dt = GETDATE() ' +
    'WHERE mdl_n_id = ' + IntToStr(p_nMdlID);

  if MyExecuteQuery(qrExecute, True, True, False) then
  begin
    Result := p_nMdlID;
  end else
  begin
    Result := -1;
  end;
end;

function TdmDM.InsertRca(p_nWcxId, p_nRptId, p_nRcaVersion: Integer): Boolean;
begin
  qrExecute.CommandText :=
    'INSERT ws.t_rca_report_work_complex_allocation ' +
    '  ( ' +
    '  wcx_n_id, ' +
    '  rpt_n_id, ' +
    '  rca_n_version, ' +
    '  created_by, ' +
    '  changed_by ' +
    '  ) ' +
    'VALUES ' +
    '  ( ' +
       IntToStr(p_nWcxId) + ', ' +
       IntToStr(p_nRptId) + ', ' +
       IntToStr(p_nRcaVersion) + ', ' +
       IntToStr(gnUserId) + ', ' +
       IntToStr(gnUserId) +
    '  ) ';

  Result := MyExecuteQuery(qrExecute, True, True, False);
end;

function TdmDM.UpdateRca(p_nRcaId, p_nRcaVersion: Integer): Boolean;
begin
  qrExecute.CommandText :=
    'UPDATE ws.t_rca_report_work_complex_allocation ' +
    'SET rca_n_version = ' + IntToStr(p_nRcaVersion) + ', ' +
    '  changed_by = ' + IntToStr(gnUserId) + ', ' +
    '  changed_dt = GETDATE() ' +
    'WHERE rca_n_id = ' +  IntToStr(p_nRcaId);

  Result := MyExecuteQuery(qrExecute, True, True, False);
end;

function TdmDM.UpdateKra(p_nKraId: Integer): Boolean;
begin
  qrExecute.CommandText :=
    'UPDATE ws.t_kra_key_report_allocation ' +
    'SET changed_by = ' + IntToStr(gnUserId) + ', ' +
    '  changed_dt = GETDATE() ' +
    'WHERE kra_n_id = ' +  IntToStr(p_nKraId);

  Result := MyExecuteQuery(qrExecute, True, True, False);
end;

function TdmDM.InsertKra(p_nRcaId: Integer; const p_sKraKey: String): Boolean;
begin
  qrExecute.CommandText :=
    'INSERT ws.t_kra_key_report_allocation ' +
    '  ( ' +
    '  rca_n_id, ' +
    '  kra_s_key, ' +
    '  created_by, ' +
    '  changed_by ' +
    '  ) ' +
    'VALUES ' +
    '  ( ' +
       IntToStr(p_nRcaId) + ', ' +
       MyQuotedStr(p_sKraKey) + ', ' +
       IntToStr(gnUserId) + ', ' +
       IntToStr(gnUserId) +
    '  ) ';

    Result := MyExecuteQuery(qrExecute, True, True, False);
end;

function TdmDM.InsertAutoBatch(p_nWcxId: Integer; const p_sBatchCode: String): Boolean;
begin
  qrExecute.CommandText :=
    'INSERT ws.t_acb_auto_completed_batches ' +
    '  ( ' +
    '  wcx_n_id, ' +
    '  acb_s_batch_code, ' +
    '  created_by, ' +
    '  changed_by ' +
    '  ) ' +
    'VALUES ' +
    '  ( ' +
       IntToStr(p_nWcxId) + ', ' +
       MyQuotedStr(p_sBatchCode) + ', ' +
       IntToStr(gnUserId) + ', ' +
       IntToStr(gnUserId) +
    '  ) ';

  Result := MyExecuteQuery(qrExecute, True, True, False);
end;

function TdmDM.UpdateAutoBatch(p_nAcbId: Integer; const p_sBatchCode: String): Boolean;
begin
  qrExecute.CommandText :=
    'UPDATE ws.t_acb_auto_completed_batches ' +
    'SET acb_s_batch_code = ' + MyQuotedStr(p_sBatchCode) + ', ' +
    '  changed_by = ' + IntToStr(gnUserId) + ', ' +
    '  changed_dt = GETDATE() ' +
    'WHERE acb_n_id = ' +  IntToStr(p_nAcbId);

  Result := MyExecuteQuery(qrExecute, True, True, False);
end;

procedure TdmDM.DataModuleCreate(Sender: TObject);
begin
  gsEnglishModuleName := 'Work complexes configuration';

  {$IFDEF MULTILANGUAGE}
  slResourceString := THashedStringList.Create;
  slLogResourceString := THashedStringList.Create;
  ModuleName := gsEnglishModuleName;
  {$ENDIF}
end;

procedure TdmDM.DataModuleDestroy(Sender: TObject);
begin
  {$IFDEF MULTILANGUAGE}
  slResourceString.Free;
  slLogResourceString.Free;
  {$ENDIF}
end;

procedure TdmDM.WriteToLog(p_ResStringRec: PResStringRec; p_sResStringName: String; const Args: array of const);
// ZapÌöe do logu
var
  lsResourceString: String;
begin
  {$IFNDEF MULTILANGUAGE}
  lsResourceString := LoadResString(p_ResStringRec);
  {$ELSE}
  lsResourceString := dmCommon.Languages.GetResourceStringValue(p_sResStringName, slLogResourceString);
  {$ENDIF}

  DoWriteToLog(Format(lsResourceString, Args));
end;

procedure TdmDm.GetLogResourceStrings;
begin
  {$IFDEF MULTILANGUAGE}
  dmCommon.Languages.GetResourcestringStringList(slLogResourceString, ModuleName, Self.Name, gsLogLanguageCode);
  {$ENDIF}
end;

function TdmDM.ExternalCodeExists(p_sExternalCode: String): Integer;
// existuje identifik·tor provozu v nad¯ÌzenÈm systÈmu?
// 0 = neexistuje, 1 = existuje, -1 = chyba
var
  qrSwcx: TADODataSet;
begin
  Result := -1;

  if Trim(p_sExternalCode) = '' then
  begin
    Result := 0;
    Exit;
  end;

  qrSwcx := TADODataSet.Create(self);

  try
    qrSwcx.Connection := dmCommon.cnSystemConnection;
    qrSwcx.Close;
    qrSwcx.CommandText :=
      'SELECT COUNT(*) AS n_count ' +
      'FROM ws.t_wcx_work_complexes ' +
      'WHERE UPPER(wcx_s_external_code) = UPPER(' + MyQuotedStr(p_sExternalCode) + ')';

    if not MyOpenQuery(qrSwcx) then
    begin
      Exit;
    end;

    Result := 0;
    
    if qrSwcx.FieldByName('n_count').AsInteger > 0 then
    begin
      Result := 1;
    end;

    qrSwcx.Close;
  finally
    qrSwcx.Free;
  end;
end;

function TdmDM.InsertModuleComputerAllocation(p_nComputerId, p_nModuleId: Integer): Boolean;
// VloûÌ z·znam do tabulky p¯i¯azenÌ modul˘ poËÌtaË˘m
var
  qrImca: TADOCommand;
begin
  qrImca := TADOCommand.Create(self);

  try
    qrImca.Connection := dmCommon.cnOperatorConnection;
    qrImca.CommandText :=
      'INSERT ws.t_mca_module_computer_allocation ' +
      '  ( ' +
      '  cmp_n_id, ' +
      '  mdl_n_id, ' +
      '  created_by, ' +
      '  changed_by ' +
      '  ) ' +
      'VALUES ' +
      '  ( ' +
         IntToStr(p_nComputerId) + ', ' +
         IntToStr(p_nModuleId) + ', ' +
         IntToStr(gnUserId) + ', ' +
         IntToStr(gnUserId) +
      '  ) ';

    Result := MyExecuteQuery(qrImca, True, True, False);
  finally
    qrImca.Free;
  end;
end;

function TdmDM.DeleteTankStatus(p_nTstId: Integer): Boolean;
// Smaûe stav kotle se zadan˝m id
var
  spDtst: TADOStoredProc;
  lnReturn: Integer;
begin
  Result := False;
  spDtst := TADOStoredProc.Create(self);

  try
    spDtst.Name := 'spDtst';
    spDtst.Connection := dmCommon.cnOperatorConnection;
    spDtst.ProcedureName := 'ps.sp_d_tst';
    spDtst.Parameters.CreateParameter('@RETURN_VALUE', ftInteger, pdReturnValue, SizeOf(Integer), varNull);
    // Id stavu kotle
    spDtst.Parameters.CreateParameter('@p_n_tst_id', ftInteger, pdInput, SizeOf(Integer), p_nTstId);

    if not MyExecProc(spDtst) then
    begin
      Exit;
    end;

    lnReturn := spDtst.Parameters.ParamValues['@RETURN_VALUE'];
    Result := lnReturn = 1;

    if lnReturn < 1 then
    begin
      // Chyba Ë. %s p¯i vol·nÌ uloûenÈ procedry %s!
      MyMessageBox(Format(resStoredProcedureError, [IntToStr(lnReturn), 'sp_d_tst']), mtError);
      Exit;
    end;
  finally
    spDtst.Free;
  end;
end;

function TdmDM.InsertTankStatus(p_nWcxId, p_nNumber: Integer; p_sName, p_sKind, p_sCode: String): Boolean;
// VloûÌ nov˝ z·znam do tabulky stav˘ kotle
var
  spItst: TADOStoredProc;
  lnReturn: Integer;
begin
  Result := False;
  spItst := TADOStoredProc.Create(self);

  try
    spItst.Name := 'spItst';
    spItst.Connection := dmCommon.cnOperatorConnection;
    spItst.ProcedureName := 'ps.sp_i_tst';
    spItst.Parameters.CreateParameter('@RETURN_VALUE', ftInteger, pdReturnValue, SizeOf(Integer), varNull);
    // id provozu
    spItst.Parameters.CreateParameter('@p_n_tst_id', ftInteger, pdInput, SizeOf(Integer), p_nWcxId);
    // ËÌslo stavu kotle
    spItst.Parameters.CreateParameter('@p_n_number', ftInteger, pdInput, SizeOf(Integer), p_nNumber);
    // n·zev stavu kotle
    spItst.Parameters.CreateParameter('@p_s_name', ftString, pdInput, 50, p_sName);
    // druh stavu kotle
    spItst.Parameters.CreateParameter('@p_s_kind', ftString, pdInput, 2, p_sKind);
    // kÛd stavu kotle
    spItst.Parameters.CreateParameter('@p_s_code', ftString, pdInput, 20, p_sCode);

    if not MyExecProc(spItst) then
    begin
      Exit;
    end;

    lnReturn := spItst.Parameters.ParamValues['@RETURN_VALUE'];
    Result := lnReturn > 0;

    if lnReturn < 1 then
    begin
      // Chyba Ë. %s p¯i vol·nÌ uloûenÈ procedry %s!
      MyMessageBox(Format(resStoredProcedureError, [IntToStr(lnReturn), 'sp_i_tst']), mtError);
      Exit;
    end;
  finally
    spItst.Free;
  end;
end;

function TdmDM.UpdateTankStatus(p_nTstId, p_nNumber: Integer; p_sName, p_sKind, p_sCode: String): Boolean;
// ZmÏna z·znamu v tabulce stav˘ kotle
var
  spUtst: TADOStoredProc;
  lnReturn: Integer;
begin
  Result := False;
  spUtst := TADOStoredProc.Create(self);

  try
    spUtst.Name := 'spUtst';
    spUtst.Connection := dmCommon.cnOperatorConnection;
    spUtst.ProcedureName := 'ps.sp_u_tst';
    spUtst.Parameters.CreateParameter('@RETURN_VALUE', ftInteger, pdReturnValue, SizeOf(Integer), varNull);
    // Id stavu kotle
    spUtst.Parameters.CreateParameter('@p_n_tst_id', ftInteger, pdInput, SizeOf(Integer), p_nTstId);
    // »Ìslo stavu kotle
    spUtst.Parameters.CreateParameter('@p_n_number', ftInteger, pdInput, SizeOf(Integer), p_nNumber);
    // N·zev stavu kotle
    spUtst.Parameters.CreateParameter('@p_s_name', ftString, pdInput, 50, p_sName);
    // Druh stavu kotle
    spUtst.Parameters.CreateParameter('@p_s_kind', ftString, pdInput, 2, p_sKind);
    // KÛd stavu kotle
    spUtst.Parameters.CreateParameter('@p_s_code', ftString, pdInput, 20, p_sCode);

    if not MyExecProc(spUtst) then
    begin
      Exit;
    end;

    lnReturn := spUtst.Parameters.ParamValues['@RETURN_VALUE'];
    Result := lnReturn = 1;

    if lnReturn < 1 then
    begin
      // Chyba Ë. %s p¯i vol·nÌ uloûenÈ procedry %s!
      MyMessageBox(Format(resStoredProcedureError, [IntToStr(lnReturn), 'sp_u_tst']), mtError);
      Exit;
    end;
  finally
    spUtst.Free;
  end;
end;

function TdmDM.DeleteKeysForComputer(p_nCmpId: Integer): Boolean;
// OdstranÌ vöechny tiskovÈ klÌËe p¯i¯azenÈ zadanÈmu poËÌtaËi a dalöÌ z·znamy v propojen˝ch tabulk·ch
var
  spDkca_for_cmp: TADOStoredProc;
  lnResult: Integer;
begin
  Result := False;
  lnResult := -100;
  spDkca_for_cmp := TADOStoredProc.Create(Self);

  try
    spDkca_for_cmp.Name := 'spDkca_for_cmp';
    spDkca_for_cmp.Connection := dmCommon.cnOperatorConnection;
    spDkca_for_cmp.ProcedureName := 'ws.sp_d_kca_for_cmp';
    spDkca_for_cmp.Parameters.CreateParameter('@RETURN_VALUE', ftInteger, pdReturnValue, SizeOf(Integer), lnResult);
    // Id poËÌtaËe
    spDkca_for_cmp.Parameters.CreateParameter('@p_n_cmp_id', ftInteger, pdInput, SizeOf(Integer), p_nCmpId);

    if not MyExecProc(spDkca_for_cmp) then
    begin
      Exit;
    end;

    lnResult := spDkca_for_cmp.Parameters.ParamValues['@RETURN_VALUE'];
    Result := lnResult = 1;

    if lnResult < 1 then
    begin
      // Chyba Ë. %s p¯i vol·nÌ uloûenÈ procedry %s!
      MyMessageBox(Format(resStoredProcedureError, [IntToStr(lnResult), 'sp_d_kca_for_cmp']), mtError);
      Exit;
    end;
  finally
    spDkca_for_cmp.Free;
  end;
end;

function TdmDM.ResetPrintKeysInWorksites(p_nKcaId: Integer): Boolean;
// P¯ed smaz·nÌm tiskovÈho klÌËe p¯i¯azenÈho k poËÌtaËi vynuluje odpovÌdajÌcÌ tiskovÈ klÌËe p¯i¯azenÈ pracoviötÌm
var
  spUwst_kca: TADOStoredProc;
  lnResult: Integer;
begin
  Result := False;
  lnResult := -100;
  spUwst_kca := TADOStoredProc.Create(Self);

  try
    spUwst_kca.Name := 'spUwst_kca';
    spUwst_kca.Connection := dmCommon.cnOperatorConnection;
    spUwst_kca.ProcedureName := 'ws.sp_u_wst_kca';
    spUwst_kca.Parameters.CreateParameter('@RETURN_VALUE', ftInteger, pdReturnValue, SizeOf(Integer), lnResult);
    // Id tiskovÈho klÌËe p¯i¯azenÈho poËÌtaËi
    spUwst_kca.Parameters.CreateParameter('@p_n_kca_id', ftInteger, pdInput, SizeOf(Integer), p_nKcaId);

    if not MyExecProc(spUwst_kca) then
    begin
      Exit;
    end;

    lnResult := spUwst_kca.Parameters.ParamValues['@RETURN_VALUE'];
    Result := lnResult = 1;

    if lnResult < 1 then
    begin
      // Chyba Ë. %s p¯i vol·nÌ uloûenÈ procedry %s!
      MyMessageBox(Format(resStoredProcedureError, [IntToStr(lnResult), 'sp_u_wst_kca']), mtError);
      Exit;
    end;
  finally
    spUwst_kca.Free;
  end;
end;

function TdmDM.InsertUnweighedBatch(p_nWcxId: Integer; const p_sBatchCode: String): Boolean;
// VloûÌ nov˝ z·znam do tabulky d·vek, kterÈ se nenavaûujÌ ve WinFormula
var
  spIuwb: TADOStoredProc;
  lnReturn: Integer;
begin
  Result := False;
  spIuwb := TADOStoredProc.Create(Self);

  try
    spIuwb.Name := 'spIuwb';
    spIuwb.Connection := dmCommon.cnOperatorConnection;
    spIuwb.ProcedureName := 'ws.sp_i_uwb';
    spIuwb.Parameters.CreateParameter('@RETURN_VALUE', ftInteger, pdReturnValue, SizeOf(Integer), varNull);
    // Id provozu
    spIuwb.Parameters.CreateParameter('@p_n_wcx_id', ftInteger, pdInput, SizeOf(Integer), p_nWcxId);
    // KÛd d·vky
    spIuwb.Parameters.CreateParameter('@p_s_batch_code', ftString, pdInput, 20, p_sBatchCode);

    if not MyExecProc(spIuwb) then
    begin
      Exit;
    end;

    lnReturn := spIuwb.Parameters.ParamValues['@RETURN_VALUE'];
    Result := lnReturn > 0;

    if lnReturn < 1 then
    begin
      // Chyba Ë. %s p¯i vol·nÌ uloûenÈ procedry %s!
      MyMessageBox(Format(resStoredProcedureError, [IntToStr(lnReturn), 'sp_i_uwb']), mtError);
      Exit;
    end;
  finally
    spIuwb.Free;
  end;
end;

function TdmDM.UpdateUnweighedBatch(p_nUwbId: Integer; const p_sBatchCode: String): Boolean;
// ZmÏna z·znamu v tabulce d·vek, kterÈ se nenavaûujÌ ve WinFormula
var
  spUuwb: TADOStoredProc;
  lnReturn: Integer;
begin
  Result := False;
  spUuwb := TADOStoredProc.Create(Self);

  try
    spUuwb.Name := 'spUuwb';
    spUuwb.Connection := dmCommon.cnOperatorConnection;
    spUuwb.ProcedureName := 'ws.sp_u_uwb';
    spUuwb.Parameters.CreateParameter('@RETURN_VALUE', ftInteger, pdReturnValue, SizeOf(Integer), varNull);
    // Unweighed batch ID
    spUuwb.Parameters.CreateParameter('@p_n_uwb_id', ftInteger, pdInput, SizeOf(Integer), p_nUwbId);
    // Batch code
    spUuwb.Parameters.CreateParameter('@p_s_batch_code', ftString, pdInput, 20, p_sBatchCode);

    if not MyExecProc(spUuwb) then
    begin
      Exit;
    end;

    lnReturn := spUuwb.Parameters.ParamValues['@RETURN_VALUE'];
    Result := lnReturn = 1;

    if lnReturn < 1 then
    begin
      // Chyba Ë. %s p¯i vol·nÌ uloûenÈ procedry %s!
      MyMessageBox(Format(resStoredProcedureError, [IntToStr(lnReturn), 'sp_u_uwb']), mtError);
      Exit;
    end;
  finally
    spUuwb.Free;
  end;
end;

{$IFDEF MULTILANGUAGE}
procedure TdmDM.TranslateResourceStrings;
begin
  dmCommon.Languages.DoTranslateResourceStrings(pResStringRec(@resDM_ChybaPriZjisOvaniExistenceModulu),
    dmCommon.Languages.GetResourceStringValue('resDM_ChybaPriZjisOvaniExistenceModulu', slResourceString));
end;
{$ENDIF}


end.

