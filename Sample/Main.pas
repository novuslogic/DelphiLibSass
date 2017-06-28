unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, DelphiLibSass;

type
  TfrmMain = class(TForm)
    btnLibVersion: TButton;
    Button1: TButton;
    btnsasstocss1: TButton;
    SaSSOpenDialog: TOpenDialog;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnLibVersionClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnsasstocss1Click(Sender: TObject);
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

// https://github.com/sass/libsass/blob/master/docs/api-doc.md
procedure TfrmMain.btnLibVersionClick(Sender: TObject);
begin
   Showmessage(FDelphiLibSass.libsass_version);
end;

procedure TfrmMain.btnsasstocss1Click(Sender: TObject);
begin
//  FDelphiLibSass.

  if SASSOpenDialog.Execute then
    begin
      FDelphiLibSass.ConvertFileToCss(SASSOpenDialog.Filename);







    end;



end;

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  Showmessage(FDelphiLibSass.libsass_language_version);
end;

// https://github.com/sass/libsass/blob/master/docs/api-context-example.md


procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FDelphiLibSass);
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  FDelphiLibSass := tDelphiLibSass.LoadInstance;
end;

end.
