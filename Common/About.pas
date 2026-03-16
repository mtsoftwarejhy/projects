{-----------------------------------------------------------------------------------------------------------------------------------------------------
 Project:      WinFormula, WinProduction, WinStock, WinInsert, Expedièní systém, WinPackage, WinMixWeighing
 Module:       Spoleèná funkcionalita
 File name:    About.pas

 Description:  Informaèní okno "O aplikaci"

 Author:       Michal Èervenka
 Creation:     08.11.2004
 Change:
   02.04.2007 TV - Z formuláøe smazány texty, které se naplòují dynamicky (aby se nepøekládaly pøi lokalizaci)
   18.05.2007 MÈ - název aplikace se naèítá z promìnné gsModuleName
   24.09.2007 MÈ - zrušeno ètení konstant ze souboru VersionInfo.inc
   17.02.2008 MÈ - zmìna loga, obrázek používá jen 16 barev místo 256
   11.05.2011 MÈ - Zmìna názvu konstanty csImplementationBUCZ -> csImplementationWinStock
   14.12.2012 MÈ - Zmìna tel. èísla MT
   09.02.2016 MÈ - Rozdìlení implementace csImplementationWinStock na csImplementationWiStBUCZ a csImplementationWiStAcerostar
   05.07.2020 MÈ - Implementace WinPackage
   24.10.2020 MÈ - Procedura GetFileInfo pøesunuta do Common.pas
   19.05.2021 MÈ - Implementation WinMixWeighing
-----------------------------------------------------------------------------------------------------------------------------------------------------}
unit About;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, ShellAPI,
  Common;

const
  // Datum - konec, spoleèný pro všechny implementace
  csEndDate = '6.12.2025';

type
  TfrmAbout = class(TMultiLangForm)
    btnExit: TBitBtn;
    pnlMain: TPanel;
    imgIcon: TImage;
    Label3d6: TLabel;
    lblApplication: TLabel;
    Label3d8: TLabel;
    lblVersion: TLabel;
    lblDate: TLabel;
    Label3d12: TLabel;
    lblTel: TLabel;
    lblWWW: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Bevel1: TBevel;
    imgMT: TImage;
    lblEmail1: TLabel;
    lblEmail2: TLabel;
    lblCompany: TLabel;
    procedure btnExitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lblWWWClick(Sender: TObject);
    procedure lblEmail2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation

{$R *.DFM}

procedure TfrmAbout.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmAbout.FormShow(Sender: TObject);
var
  FileInfoArray: TFileInfo;
begin
  GetFileInfo(Application.ExeName, FileInfoArray);

  // Datum pro WinFormula Zentiva
  lblDate.Caption := '1.6.2004 - ' + csEndDate;
  lblTel.Caption := '+420 226 808 163';
  lblWWW.Caption := 'www.mt.com';
  lblEmail2.Caption := '';
  lblCompany.Caption := FileInfoArray[2];

  // Datum pro WinInsert
  if gsImplementationCode = csImplementationWinInsert then
  begin
    lblDate.Caption := '23.11.2004 - ' + csEndDate;
  end;

  // Datum pro WinStock
  if (gsImplementationCode = csImplementationWiStBUCZ) or (gsImplementationCode = csImplementationWiStAcerostar) then
  begin
    lblDate.Caption := '5.11.2007 - ' + csEndDate;
  end;

  // Datum pro WinProduction
  if gsImplementationCode = csImplementationWiPrZentiva then
  begin
    lblDate.Caption := '23.4.2009 - ' + csEndDate;
  end;

  // Datum pro WinPackage
  {$IFDEF WINPACKAGE}
  lblDate.Caption := '5.7.2020 - ' + csEndDate;
  {$ENDIF}

  // Datum pro WinMixWeighing
  if gsImplementationCode = csImplementationWinMixWeighing then
  begin
    lblDate.Caption := '19.5.2021 - ' + csEndDate;
  end;

  if Trim(gsModuleName) <> '' then
  begin
    lblApplication.Caption := gsModuleName
  end else
  if Trim(gsEnglishModuleName) <> '' then
  begin
    lblApplication.Caption := gsEnglishModuleName;
  end else
  begin
    lblApplication.Caption := FileInfoArray[5];
  end;

  lblVersion.Caption := FileInfoArray[4];

  imgIcon.Picture.Icon := Application.Icon;

  if Trim(lblEmail2.Caption) = '' then
  begin
    lblEmail1.Visible := False;
    lblEmail2.Visible := False;
  end;
end;

procedure TfrmAbout.lblWWWClick(Sender: TObject);
begin
  ShellExecute(Application.Handle, nil, PChar('http://' + lblWWW.Caption), nil, nil, SW_SHOWNOACTIVATE);
end;

procedure TfrmAbout.lblEmail2Click(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', PChar('mailto:' + lblEmail2.Caption), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmAbout.FormCreate(Sender: TObject);
begin
  inherited;
  InitTranslate('Common');
end;

end.

