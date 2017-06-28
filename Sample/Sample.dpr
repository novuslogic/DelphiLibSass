program Sample;

uses
  Vcl.Forms,
  Main in 'Main.pas' {frmMain},
  DelphiLibSass in '..\Source\DelphiLibSass.pas',
  DelphiLibSassCommon in '..\Source\DelphiLibSassCommon.pas',
  DelphiLibSassLib in '..\Source\DelphiLibSassLib.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
