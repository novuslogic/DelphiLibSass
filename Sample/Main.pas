unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, DelphiLibSass,
  Vcl.ComCtrls;

type
  TfrmMain = class(TForm)
    SaSSOpenDialog: TOpenDialog;
    PageControl: TPageControl;
    TSConvertFileToCss: TTabSheet;
    memoCCS1: TMemo;
    btnsasstocss1: TButton;
    ConvertToCss: TTabSheet;
    btnsasstocss2: TButton;
    memoSCSS: TMemo;
    btnConvertCSS: TButton;
    memoCCS2: TMemo;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnsasstocss1Click(Sender: TObject);
    procedure btnsasstocss2Click(Sender: TObject);
    procedure btnConvertCSSClick(Sender: TObject);
  private
    { Private declarations }
    FDelphiLibSass: TDelphiLibSass;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}


procedure TfrmMain.btnConvertCSSClick(Sender: TObject);
Var
  FScssResult: TScssResult;
begin
  FScssResult := FDelphiLibSass.ConvertToCss(memoSCSS.Lines.Text);
  if Assigned(FScssResult) then
    begin
      memoCCS2.Text := FScssResult.CSS;

      FScssResult.Free;
    end;
end;

procedure TfrmMain.btnsasstocss1Click(Sender: TObject);
Var
  FScssResult: TScssResult;
begin
  if SASSOpenDialog.Execute then
    begin
      FScssResult := FDelphiLibSass.ConvertFileToCss(SASSOpenDialog.Filename);
      if Assigned(FScssResult) then
        begin
          memoCCS1.Text := FScssResult.CSS;

          FScssResult.Free;
        end;
    end;
end;

procedure TfrmMain.btnsasstocss2Click(Sender: TObject);
begin
  if SASSOpenDialog.Execute then
    memoSCSS.Lines.LoadFromFile(SASSOpenDialog.Filename);
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FDelphiLibSass);
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  FDelphiLibSass := tDelphiLibSass.LoadInstance;
end;

end.
