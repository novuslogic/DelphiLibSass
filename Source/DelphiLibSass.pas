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

    function ConvertToCss(const aScss: string): TScssResult;
    function ConvertFileToCss(const aFilename: String): TScssResult;
    function CompileScssToCss(const aSass_Context: tSass_Context; const aSass_Compiler: tSass_Compiler): TScssResult;

  end;



implementation

class function TDelphiLibSass.LoadInstance: TDelphiLibSass;
begin
  Result := TDelphiLibSass.Create;
  Result.LoadDLL;
end;

function TDelphiLibSass.ConvertToCss(const aScss: string): TScssResult;
Var
  fSass_Data_Context: TSass_Data_Context;
  fSass_Context: TSass_Context;
  fSass_Compiler: TSass_Compiler;
begin
  Result := NIL;

  if aScss = '' then Exit;

  fSass_Data_Context := sass_make_data_context(LibSassString(aScss));
  if Not Assigned(fSass_Data_Context)  then
      raise EDelphiLibSassError.Create('sass_make_data_context failed');
  fSass_Context := fSass_Data_Context;

  Try
    fSass_Compiler := sass_make_data_compiler(fSass_Data_Context);

    Result := CompileScssToCss(fSass_Context,fSass_Compiler);

  Finally
    //sass_delete_compiler(fSass_Compiler);  Pointer issue ??

    sass_delete_data_context(fSass_Context);
  End;
end;

function TDelphiLibSass.CompileScssToCss(const aSass_Context: tSass_Context; const aSass_Compiler: tSass_Compiler): TScssResult;
var
  fscss: string;
  FincludedFiles: tStrings;
  fsmap: String;
begin
  Try
    sass_compiler_parse(aSass_Compiler);
    CheckStatus(aSass_Context);

    sass_compiler_execute(aSass_Compiler);
    CheckStatus(aSass_Context);

    fscss := sass_context_get_output_string(aSass_Context);
  Finally
    (*
    fsmap := '';

    if (options != null && options.GenerateSourceMap)
    {
       lsMap = LibSass.sass_context_get_source_map_string(context);
    }
    *)
    FincludedFiles := GetIncludedFiles(aSass_Context);

    Result := TScssResult.Create(fsCss, fsMap, FincludedFiles);
  End;
end;


function TDelphiLibSass.ConvertFileToCss(const aFilename: String): TScssResult;
var
  fSass_File_Context: TSass_File_Context;
  fSass_Compiler: TSass_Compiler;
  fSass_Context: TSass_Context;
begin
  Result := NIL;

  if not FileExists(aFilename) then Exit;

  Try
    fSass_File_Context := sass_make_file_context(LibSassString(aFilename));
    if Not Assigned(fSass_File_Context)  then
      raise EDelphiLibSassError.Create('sass_make_file_context failed');
    fSass_Context := fSass_File_Context;
    (*
    if (options.InputFile == null)
    {
    options.InputFile = fromStringOrFile;
    }
    tryImportHandle = MarshalOptions(fileContext, options);
    *)

    fSass_Compiler := sass_make_file_compiler(fSass_File_Context);
    if Not Assigned(fSass_Compiler)  then
      raise EDelphiLibSassError.Create('sass_make_file_compiler failed');

    Result := CompileScssToCss(fSass_Context,fSass_Compiler);
  Finally
    sass_delete_compiler(fSass_Compiler);

    sass_delete_file_context(fSass_Context);
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
  if Assigned(fIncludeFiles) then fIncludeFiles.Free;
end;


end.
