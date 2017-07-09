program Sample;

uses
  Vcl.Forms,
  Main in 'Main.pas' {frmMain},
  DelphiLibSass in '..\Source\core\DelphiLibSass.pas',
  DelphiLibSassCommon in '..\Source\core\DelphiLibSassCommon.pas',
  DelphiLibSassLib in '..\Source\core\DelphiLibSassLib.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
