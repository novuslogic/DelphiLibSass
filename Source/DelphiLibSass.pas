unit DelphiLibSass;

interface

uses DelphiLibSassCommon, DelphiLibSassLib, SysUtils, classes;



type
  TScssResult = class
  protected
  private
    fsCSS: string;
    fsMap: string;
    fIncludeFiles: tStrings;
  public
    constructor Create(const aCSS: string; const aMap: string; const aIncludeFiles: tStrings);
    destructor Destroy;

    property CSS: string
      read fsCSS;

    property Map: string
      read fsMap;

    property IncludeFiles: tStrings
      read fIncludeFiles;
  end;


  TDelphiLibSass = class(TDelphiLibSassLib)
  protected
  private
    procedure CheckStatus(Sass_Context: tSass_Context);
    function  GetIncludedFiles(Sass_Context: tSass_Context): TStrings;

  public
    class function LoadInstance: TDelphiLibSass;

    function ConvertFileToCss(aFilename: String): TScssResult;

  end;



implementation

class function TDelphiLibSass.LoadInstance: TDelphiLibSass;
begin
  Result := TDelphiLibSass.Create;
  Result.LoadDLL;
end;


function TDelphiLibSass.ConvertFileToCss(aFilename: String): TScssResult;
var
  FfileContext: TSass_File_Context;
  FCompiler: TSass_Compiler;
  FContext: TSass_Context;
  fscss: string;
  FincludedFiles: tStrings;
  fsmap: String;
begin
  Result := NIL;

  if not FileExists(aFilename) then Exit;

  Try
    FfileContext := sass_make_file_context(LibSassString(aFilename));
    if Not Assigned(FfileContext)  then
      raise EDelphiLibSassError.Create('sass_make_file_context failed');
    FContext := FfileContext;
    (*
    if (options.InputFile == null)
    {
    options.InputFile = fromStringOrFile;
    }
    tryImportHandle = MarshalOptions(fileContext, options);
    *)

    FCompiler := sass_make_file_compiler(FfileContext);
    if Not Assigned(FCompiler)  then
      raise EDelphiLibSassError.Create('sass_make_file_compiler failed');

    sass_compiler_parse(fcompiler);
    CheckStatus(fcontext);

    sass_compiler_execute(fcompiler);
    CheckStatus(fcontext);

    fscss := sass_context_get_output_string(fcontext);
    fsmap := '';


    (*
    if (options != null && options.GenerateSourceMap)
    {
       lsMap = LibSass.sass_context_get_source_map_string(context);
    }
    *)
    FincludedFiles := GetIncludedFiles(fcontext);
  Finally
    Result := TScssResult.Create(fsCss, fsMap, FincludedFiles);

    sass_delete_compiler(fcompiler);

    sass_delete_file_context(fcontext);
  End;

end;

procedure TDelphiLibSass.CheckStatus(Sass_Context: tSass_Context);
var
  filine,
  ficolumn,
  fiStatus: Integer;
  fserrorText,
  fsmessage,
  fsfile: String;
begin
  fiStatus := sass_context_get_error_status(Sass_Context);
  if (fiStatus <> 0) then
    begin
      ficolumn := sass_context_get_error_column(Sass_Context);
      filine := sass_context_get_error_line(Sass_Context);
      fsfile := sass_context_get_error_file(Sass_Context);
      fsmessage := sass_context_get_error_message(Sass_Context);
      fserrorText := sass_context_get_error_text(Sass_Context);

      raise EDelphiLibSassError.Create(format('column: %d line: %d file: %s message: %s errortext: %s', [ficolumn,filine,fsfile, fsmessage,fserrortext] ));
    end;
end;

function TDelphiLibSass.GetIncludedFiles(Sass_Context: tSass_Context): tStrings;
var
  fifilesCount: Integer;
  fSass_included_files: TSass_included_files;
  fSass_AnsiStringArray: PSass_AnsiStringArray ;
  I: integer;
begin
  Result := NIL;

  fifilesCount := sass_context_get_included_files_size(Sass_Context);

  if fifilesCount = 0 then Exit;

  SetLength(fSass_AnsiStringArray, fifilesCount);

  Result := tStringList.Create;

  fSass_AnsiStringArray := sass_context_get_included_files(Sass_Context);

  for I := 0 to fifilesCount-1 do
    Result.Add(PAnsiChar(fSass_AnsiStringArray[i]));

end;


// TScssResult
constructor TScssResult.Create(const aCSS: string; const aMap: string; const aIncludeFiles: tStrings);
begin
  fsCSS := aCSS;

  fsMap := aMap;

  fIncludeFiles := aIncludeFiles;
end;

destructor TScssResult.Destroy;
begin
  fIncludeFiles.Free;
end;


end.
