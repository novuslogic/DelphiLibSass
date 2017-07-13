unit DelphiLibSass;

interface

uses DelphiLibSassCommon, DelphiLibSassLib, SysUtils, classes,
  System.Generics.Collections;

type
  TScssResult = class
  protected
  private
    fsCSS: string;
    fsMap: string;
    fIncludeFiles: TList<String>;
  public
    constructor Create;
    destructor Destroy; override;

    property CSS: string read fsCSS write fsCSS;

    property Map: string read fsMap write fsMap;

    property IncludeFiles: TList<String> read fIncludeFiles write fIncludeFiles;
  end;

  TDelphiLibSass = class(TDelphiLibSassLib)
  protected
  private
    procedure CheckStatus(Sass_Context: tSass_Context);
    function CompileScssToCss(const aSass_Context: tSass_Context;
      const aSass_Compiler: tSass_Compiler): TScssResult;
  public
    class function LoadInstance: TDelphiLibSass;

    function ConvertToCss(const aScss: string): TScssResult;
    function ConvertFileToCss(const aFilename: String): TScssResult;
  end;

implementation

class function TDelphiLibSass.LoadInstance: TDelphiLibSass;
begin
  Try
    Result := TDelphiLibSass.Create;
    Result.LoadDLL;
  Except
    if Assigned(Result) then
      begin
        Result.Free;
        Result := NIL;
      end;
  End;
end;

function TDelphiLibSass.ConvertToCss(const aScss: string): TScssResult;
Var
  fSass_Data_Context: TSass_Data_Context;
  fSass_Context: tSass_Context;
  fSass_Compiler: tSass_Compiler;
begin
  Result := NIL;

  if aScss = '' then
    Exit;

  fSass_Data_Context := sass_make_data_context(LibSassString(aScss));

  if fSass_Data_Context = 0 then
    raise EDelphiLibSassError.Create('sass_make_data_context failed');
  fSass_Context := fSass_Data_Context;

  Try
    fSass_Compiler := sass_make_data_compiler(fSass_Data_Context);

    Result := CompileScssToCss(fSass_Context, fSass_Compiler);

  Finally
    sass_delete_compiler(fSass_Compiler);

    sass_delete_data_context(fSass_Context);
  End;
end;

function TDelphiLibSass.CompileScssToCss(const aSass_Context: tSass_Context;
  const aSass_Compiler: tSass_Compiler): TScssResult;
var
  fsCSS: string;
  fsIncludeFile: string;
  fsMap: String;
  fifilesCount: Integer;
  fSass_included_files: TSass_included_files;
  I: Integer;
  fSass_IncludeFiles: PSass_IncludeFiles;
begin
  Try
    sass_compiler_parse(aSass_Compiler);
    CheckStatus(aSass_Context);

    sass_compiler_execute(aSass_Compiler);
    CheckStatus(aSass_Context);

    fsCSS := sass_context_get_output_string(aSass_Context);

    fsMap := '';
  Finally
    (*

      // Include Sass Option
      if (options != null && options.GenerateSourceMap)
      {
      lsMap = sass_context_get_source_map_string(context);
      }
    *)
    fifilesCount := sass_context_get_included_files_size(aSass_Context);

    Result := TScssResult.Create;
    Result.CSS := fsCSS;
    Result.Map := fsMap;

    if fifilesCount <> 0 then
    begin
      (*
      Length(fSass_IncludeFiles.IncludeFile, fifilesCount);

      fSass_IncludeFiles := sass_context_get_included_files(aSass_Context);  // Buffer overflow issue

      fSass_IncludeFiles.IncludeFile := NIL;

      for I := 0 to fifilesCount - 1 do
        Result.IncludeFiles.Add(fSass_IncludeFiles[I].IncludeFile);
      *)
    end;
  End;
end;

function TDelphiLibSass.ConvertFileToCss(const aFilename: String): TScssResult;
var
  fSass_File_Context: TSass_File_Context;
  fSass_Compiler: tSass_Compiler;
  fSass_Context: tSass_Context;
begin
  Result := NIL;

  if not FileExists(aFilename) then
    Exit;

  Try
    fSass_File_Context := sass_make_file_context(LibSassString(aFilename));

    if fSass_File_Context = 0 then
      raise EDelphiLibSassError.Create('sass_make_file_context failed');
    fSass_Context := fSass_File_Context;

    fSass_Compiler := sass_make_file_compiler(fSass_File_Context);

   if fSass_Compiler = 0 then
      raise EDelphiLibSassError.Create('sass_make_file_compiler failed');

    Result := CompileScssToCss(fSass_Context, fSass_Compiler);
  Finally
    sass_delete_compiler(fSass_Compiler);

    sass_delete_file_context(fSass_Context);
  End;

end;

procedure TDelphiLibSass.CheckStatus(Sass_Context: tSass_Context);
var
  filine, ficolumn, fiStatus: Integer;
  fserrorText, fsmessage, fsfile: String;
begin
  fiStatus := sass_context_get_error_status(Sass_Context);
  if (fiStatus <> 0) then
  begin
    ficolumn := sass_context_get_error_column(Sass_Context);
    filine := sass_context_get_error_line(Sass_Context);
    fsfile := sass_context_get_error_file(Sass_Context);
    fsmessage := sass_context_get_error_message(Sass_Context);
    fserrorText := sass_context_get_error_text(Sass_Context);

    raise EDelphiLibSassError.Create
      (format('column: %d line: %d file: %s message: %s errortext: %s',
      [ficolumn, filine, fsfile, fsmessage, fserrorText]));
  end;
end;

// TScssResult
constructor TScssResult.Create;
begin
  fIncludeFiles := TList<String>.Create;
end;

destructor TScssResult.Destroy;
begin
  if Assigned(fIncludeFiles) then
    fIncludeFiles.Free;
end;

end.
