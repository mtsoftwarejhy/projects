{-----------------------------------------------------------------------------------------------------------------------------------------------------
 Project:      WinFormula, WinProduction, WinInsert
 Module:       Spoleèná funkcionalita
 File name:    Complexes.pas

 Description:  Formuláø pro výbìr provozu pøi spuštìní modulu

 Author:       Michal Èervenka
 Creation:     1.11.2004
 Change:
   27.10.2006 TV - pøevod komponenty TdbGrid -> TcxGrid
   07.12.2006 MÈ - zákaz mazání a vkládání záznamù v cxGridu
   21.12.2006 MÈ - výbìr navažovny doubleclickem
   16.03.2007 TV - lokalizace
   21.09.2007 MÈ - kód provozu lze pøedat v pøíkazové øádce i v projektu Vnášení
   20.04.2009 HF - Pøidání id sloupcù do cxGridu - (úprava 03 - Sdílené moduly)
   14.01.2010 MÈ - Oprava blikání kursoru pøi spuštìní modulu
   02.07.2010 MÈ - Zmìna písma na Segoe UI
   11.02.2016 MÈ - Funkce SwitchComplex
   27.04.2023 MÈ - Fixed grid header
-----------------------------------------------------------------------------------------------------------------------------------------------------}
unit Complexes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, DB, ADODB, Menus, ActnList,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData, cxTextEdit, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxControls, cxGridCustomView, cxClasses, cxGridLevel, cxGrid, cxGridCustomPopupMenu, cxGridPopupMenu, cxLookAndFeels,
  cxLookAndFeelPainters, cxNavigator,
  Common, Login, Parameters, Splash;

type
  TfrmComplexes = class(TMultiLangForm)
    dsSwcx: TDataSource;
    qrSwcx: TADODataSet;
    qrSwcxcmp_n_id: TAutoIncField;
    qrSwcxwcx_n_id: TAutoIncField;
    qrSwcxwcx_s_code: TWideStringField;
    qrSwcxwcx_s_name: TWideStringField;
    Panel2: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
    dbgridComplexes: TcxGrid;
    dbgridComplexesDBTableView1: TcxGridDBTableView;
    dbgridComplexesDBTableView1wcx_s_name1: TcxGridDBColumn;
    dbgridComplexesDBTableView1wcx_s_code1: TcxGridDBColumn;
    dbgridComplexesLevel1: TcxGridLevel;
    PopupMenu1: TPopupMenu;
    cxGridPopupMenu1: TcxGridPopupMenu;
    dbgridComplexesDBTableView1cmp_n_id: TcxGridDBColumn;
    dbgridComplexesDBTableView1wcx_n_id: TcxGridDBColumn;
    procedure dbgridComplexesDBTableView1FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure dbgridComplexesEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgridComplexesDBTableView1CellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
      AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure dbgridComplexesContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    class function GetComplexId: Integer;
    class function SwitchComplex: Boolean;
  end;

var
  frmComplexes: TfrmComplexes;

implementation

{$R *.dfm}

class function TfrmComplexes.GetComplexId: Integer;
var
  frmComplexes: TfrmComplexes;
begin
  Result := -1;
  frmComplexes := TfrmComplexes.Create(Application.MainForm);

  try
    // byl kód provozu pøedán v pøíkazové øádce?
    if ParameterExists(csParameterComplex) then
    begin
      gsComplexCode := ParamValue(csParameterComplex);
    end;

    frmComplexes.qrSwcx.Prepared;
    frmComplexes.qrSwcx.Parameters.ParamByName('cmp_s_name').Value := gsComputerName;

    if not MyOpenQuery(frmComplexes.qrSwcx, True, True, False) then
    begin
      Exit;
    end;

    if frmComplexes.qrSwcx.RecordCount > 0 then
    begin
      if frmComplexes.qrSwcx.RecordCount > 1 then
      // PC ve více provozech
      begin
        // najít záznam shodný s pøedaným parametrem
        if not frmComplexes.qrSwcx.Locate('wcx_s_code', gsComplexCode, [loCaseInsensitive]) then
        begin
          // kód provozu nenalezen => otevøít okno se seznamem provozù
          frmComplexes.qrSwcx.First;
          frmSplash.HideSplash;

          if frmComplexes.ShowModal <> mrOK then
          begin
            // konec aplikace
            Result := 0;
          end;

          frmSplash.ShowSplash;
        end;
      end;

      if Result <> 0 then
      begin
        // PC jen v jednom provozu nebo už uživatel jeden provoz vybral
        Result := frmComplexes.qrSwcx.FieldByName('wcx_n_id').AsInteger;
        gsComplexCode := frmComplexes.qrSwcx.FieldByName('wcx_s_code').AsString;
        gsComplexName := frmComplexes.qrSwcx.FieldByName('wcx_s_name').AsString;
        gnComputerId := frmComplexes.qrSwcx.FieldByName('cmp_n_id').AsInteger;
      end;
    end else
    begin
      // PC není v žádném provozu
      gsComplexCode := '';
    end;
  finally
    frmComplexes.Release;
  end;
end;

procedure TfrmComplexes.dbgridComplexesDBTableView1FocusedRecordChanged(Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  dmCommon.dbgridTableViewFocusedRecordChanged(dbgridComplexesDBTableView1, Sender, AFocusedRecord);
end;

procedure TfrmComplexes.FormCreate(Sender: TObject);
begin
  inherited;
  dmCommon.SaveDefaultSettings(dbgridComplexesDBTableView1);
  dmCommon.LoadColumnSettings(dbgridComplexesDBTableView1);
  dmCommon.CreatePopupMenu(PopupMenu1);

  // lokalizace
  InitTranslate('Common');
end;

procedure TfrmComplexes.FormDestroy(Sender: TObject);
begin
  dmCommon.SaveColumnSettings(dbgridComplexesDBTableView1);
  inherited;
end;

procedure TfrmComplexes.PopupMenu1Popup(Sender: TObject);
begin
  dmCommon.aShowHideColumnsExecute(Sender);
end;

procedure TfrmComplexes.dbgridComplexesEnter(Sender: TObject);
begin
  dmCommon.dbgridTableView := dbgridComplexesDBTableView1;
  dmCommon.qrADODataSet := qrSwcx;
end;

procedure TfrmComplexes.FormShow(Sender: TObject);
begin
  dmCommon.GoFirstRow(dbgridComplexesDBTableView1);
end;

procedure TfrmComplexes.dbgridComplexesDBTableView1CellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  ModalResult := mrOK;
end;

procedure TfrmComplexes.dbgridComplexesContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin
  dbgridComplexesEnter(Sender);
end;

class function TfrmComplexes.SwitchComplex: Boolean;
// Pøepnout na jiný provoz
var
  frmComplexes: TfrmComplexes;
begin
  Result := False;
  frmComplexes := TfrmComplexes.Create(Application.MainForm);

  try
    frmComplexes.qrSwcx.CommandText :=
      'SELECT DISTINCT ' +
      '  cmp.cmp_n_id, ' +
      '  wcx.wcx_n_id, ' +
      '  wcx.wcx_s_code, ' +
      '  wcx.wcx_s_name ' +
      'FROM  ws.t_wcx_work_complexes AS wcx ' +
      'INNER JOIN ws.t_cmp_computers AS cmp ' +
      'ON wcx.wcx_n_id = cmp.wcx_n_id ' +
      'INNER JOIN ws.t_mca_module_computer_allocation AS mca ' +
      'ON mca.cmp_n_id = cmp.cmp_n_id ' +
      'INNER JOIN ws.t_mdl_modules AS mdl ' +
      'ON mdl.mdl_n_id = mca.mdl_n_id ' +
      'AND UPPER(mdl.mdl_s_code) = ' + MyQuotedStr(AnsiUpperCase(gsModuleCode)) + ' ' +
      // název aktuálního poèítaèe
      'WHERE UPPER(cmp.cmp_s_name) = ' + MyQuotedStr(AnsiUpperCase(gsComputerName)) + ' ' +
      // id aktuálního provozu - nebude se zobrazovat v seznamu
      'AND wcx.wcx_n_id <> ' + IntToStr(gnComplexId);

    if not MyOpenQuery(frmComplexes.qrSwcx) then
    begin
      Exit;
    end;

    if frmComplexes.qrSwcx.RecordCount = 0 then
    begin
      // poèítaè je jen v jednom provozu
      MyMessageBox('Tento poèítaè a modul jsou v konfiguraci pøiøazeny pouze do jednoho provozu.',
        mtInformation);
    end else
    begin
      // otevøít okno se seznamem provozù
      frmComplexes.qrSwcx.First;

      if frmComplexes.ShowModal = mrOK then
      begin
        // uživatel vybral jiný provoz => pøepnout
        gnComplexId := frmComplexes.qrSwcx.FieldByName('wcx_n_id').AsInteger;
        gsComplexCode := frmComplexes.qrSwcx.FieldByName('wcx_s_code').AsString;
        gsComplexName := frmComplexes.qrSwcx.FieldByName('wcx_s_name').AsString;
        gnComputerId := frmComplexes.qrSwcx.FieldByName('cmp_n_id').AsInteger;

        // Zmìna v ConnectionString
        if not dmCommon.UpdateConnectionString(dmCommon.cnOperatorConnection) then
        begin
          Exit;
        end;

        Result := True;
      end;
    end;
  finally
    frmComplexes.Free;
  end;
end;

end.

