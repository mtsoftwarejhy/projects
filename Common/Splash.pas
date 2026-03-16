{-----------------------------------------------------------------------------------------------------------------------------------------------------
 Project:      WinFormula, WinProduction, WinStock, WinInsert, Expedièní systém, WinPackage, WinMixWeighing
 Module:       Spoleèná funkcionalita
 File name:    Splash.pas

 Description:  Zobrazení úvodní obrazovky pøi inicializaci aplikace

 Author:       Michal Èervenka
 Creation:     08.11.2004
 Change:
   16.03.2007 TV - Lokalizace
   18.05.2007 MÈ - Název aplikace se naèítá z promìnné gsModuleName
   08.06.2007 MÈ - Název aplikace se naèítá z promìnné gsEnglishModuleName
   17.02.2008 MÈ - EASTEUROPE_CHARSET
                 - Zmìna loga, obrázek používá jen 16 barev místo 256
   21.04.2009 HF - U imgMT vypnuto Stretch, protože 16ti barevné logo se pøi resizování (písmo 120 DPI) rozšmudlalo
   08.02.2011 MÈ - Zmìna písma na Segoe UI
   19.05.2021 MÈ - Implementation WinMixWeighing
-----------------------------------------------------------------------------------------------------------------------------------------------------}
unit Splash;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
  Common;

type
  TfrmSplash = class(TMultiLangForm)
    Panel1: TPanel;
    imgMT: TImage;
    lblAction: TLabel;
    lblProgram: TLabel;
    lblVer: TLabel;
    lblApplication: TLabel;
    lblVersion: TLabel;
    imgIcon: TImage;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ShowSplash;
    procedure HideSplash;
    procedure SetActionLabel(p_sCaption: String);
    procedure SetApplicationLabel(p_sApplication: String);
  end;

var
  frmSplash: TfrmSplash;

implementation

uses
  About;

{$R *.dfm}

procedure TfrmSplash.ShowSplash;
begin
  frmSplash.Show;
  Application.ProcessMessages;
end;

procedure TfrmSplash.HideSplash;
begin
  frmSplash.Hide;
  Screen.Cursor := crDefault;
end;

procedure TfrmSplash.FormShow(Sender: TObject);
var
  FileInfoArray: TFileInfo;
begin
  GetFileInfo(Application.ExeName, FileInfoArray);

  if Trim(gsModuleName) <> '' then
  begin
    lblApplication.Caption := gsModuleName;
  end else
  {$IFDEF MULTILANGUAGE}
  if Trim(gsEnglishModuleName) <> '' then
  begin
    lblApplication.Caption := gsEnglishModuleName;
  end else
  begin
    lblApplication.Caption := FileInfoArray[5]; // InternalName
  end;
  {$ELSE}
  begin
    lblApplication.Caption := FileInfoArray[3]; // FileDescription
  end;
  {$ENDIF}

  lblVersion.Caption := FileInfoArray[4];
  imgIcon.Picture.Icon := Application.Icon;
end;

procedure TfrmSplash.SetActionLabel(p_sCaption: String);
begin
  lblAction.Caption := p_sCaption;
  Application.ProcessMessages;
end;

procedure TfrmSplash.SetApplicationLabel(p_sApplication: String);
begin
  lblApplication.Caption := p_sApplication;
  Application.ProcessMessages;
end;

procedure TfrmSplash.FormCreate(Sender: TObject);
begin
  // Lokalizace
  inherited;

  {$IFDEF MULTILANGUAGE}
  lblAction.Caption := 'Starting application...';
  lblProgram.Caption := 'Application:';
  lblVer.Caption := 'Version:';
  {$ENDIF}

  InitTranslate('Common');
end;

end.
