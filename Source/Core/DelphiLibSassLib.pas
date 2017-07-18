unit DelphiLibSassLib;

interface

Uses DelphiLibSassCommon, Wintypes, WinProcs, System.SysUtils;

type
   tDelphiLibSassLib = class
   private
     fsLibraryFilename: String;
     fbDLLLoaded: boolean;
     fDLLHandle: THandle;
   protected
   public
     constructor Create(aLibraryFilename: String = '');
     destructor Destroy;

     procedure LoadDll;
     procedure UnloadDll;

     function libsass_version: String;
     function libsass_language_version: string;

     function sass_make_file_context(input_path: PAnsiChar): TSass_File_Context;
     function sass_make_file_compiler(sass_file_context: TSass_File_Context): TSass_Compiler;
     function sass_compiler_parse(Sass_Compiler: TSass_Compiler): integer;
     function sass_compiler_execute(Sass_Compiler: TSass_Compiler): integer;
     function sass_context_get_error_status(Sass_Context: tSass_Context): integer;
     function sass_context_get_error_column(Sass_Context: tSass_Context): integer;
     function sass_context_get_error_line(Sass_Context: tSass_Context): integer;
     function sass_context_get_included_files_size(Sass_Context: tSass_Context): integer;
     function sass_context_get_included_files(Sass_Context: tSass_Context): TSass_included_files;
     function sass_context_get_error_file(Sass_Context: tSass_Context): string;
     function sass_context_get_error_message(Sass_Context: tSass_Context): string;
     function sass_context_get_error_text(Sass_Context: tSass_Context): string;
     function sass_context_get_output_string(Sass_Context: tSass_Context): string;
     procedure sass_delete_compiler(Sass_Compiler: TSass_Compiler);
     procedure sass_delete_file_context(Sass_File_Context: TSass_File_Context);
     procedure sass_delete_data_context(Sass_Data_Context: TSass_Data_Context);
     function sass_make_data_context(source_string: PAnsiChar): TSass_Data_Context;
     function sass_make_data_compiler(Sass_Data_Context: TSass_Data_Context): TSass_Compiler;

     property DLLLoaded: boolean
      read fbDLLLoaded;
   end;

implementation

constructor TDelphiLibSassLib.Create(aLibraryFilename: String = '');
begin
  fsLibraryFilename := aLibraryFilename;
end;

destructor TDelphiLibSassLib.Destroy;
begin
  UnloadDll;
end;

procedure TDelphiLibSassLib.LoadDLL;
begin
  if DLLLoaded then Exit;

  fbDLLLoaded := false;

  if fsLibraryFilename = '' then
    fsLibraryFilename := cLibSassName;


  fDLLHandle := SafeLoadLibrary(fsLibraryFilename);
  if fDLLHandle =0 then
    raise EDelphiLibSassError.Create('Unable to Load DLL');

  fbDllLoaded := true;
end;

procedure TDelphiLibSassLib.UnloadDll;
begin
  if not fbDLLLoaded then Exit;

  Try
    FreeLibrary(fDLLHandle);
  Finally
    fbDLLLoaded := false;
  End;
end;

function TDelphiLibSassLib.libsass_version: String;
Var
  Flibsass_version: Tlibsass_version;
begin
  if fbDllLoaded  = false then
    raise EDelphiLibSassError.Create('DLL not loaded');

  @Flibsass_version := GetProcAddress(fDLLHandle, 'libsass_version');
  if (@Flibsass_version = nil) then
    raise EDelphiLibSassError.Create('GetProcAddress cannot find libsass_version');

  Result := Flibsass_version;
end;

function TDelphiLibSassLib.libsass_language_version: String;
Var
  Flibsass_language_version: Tlibsass_language_version;
begin
  if fbDllLoaded  = false then
    raise EDelphiLibSassError.Create('DLL not loaded');

  @Flibsass_language_version := GetProcAddress(fDLLHandle, 'libsass_language_version');
  if (@Flibsass_language_version = nil) then
    raise EDelphiLibSassError.Create('GetProcAddress cannot find libsass_language_version');

  Result := Flibsass_language_version;
end;

function TDelphiLibSassLib.sass_make_file_context(input_path: PAnsiChar): TSass_File_Context;
var
  fsass_make_file_context: Tsass_make_file_context;
begin
  if fbDllLoaded  = false then
    raise EDelphiLibSassError.Create('DLL not loaded');

  @fsass_make_file_context := GetProcAddress(fDLLHandle, 'sass_make_file_context');
  if (@fsass_make_file_context = nil) then
    raise EDelphiLibSassError.Create('GetProcAddress cannot find sass_make_file_context');

  Result := fsass_make_file_context(input_path);
end;

function TDelphiLibSassLib.sass_make_file_compiler(sass_file_context: TSass_File_Context): TSass_Compiler;
var
  fsass_make_file_compiler: Tsass_make_file_compiler;
begin
  if fbDllLoaded  = false then
    raise EDelphiLibSassError.Create('DLL not loaded');

  @fsass_make_file_compiler := GetProcAddress(fDLLHandle, 'sass_make_file_compiler');
  if (@fsass_make_file_compiler = nil) then
    raise EDelphiLibSassError.Create('GetProcAddress cannot find sass_make_file_compiler');

  Result := fsass_make_file_compiler(sass_file_context);
end;

function TDelphiLibSassLib.sass_compiler_parse(Sass_Compiler: TSass_Compiler): integer;
var
  fsass_compiler_parse: Tsass_compiler_parse;
begin
  if fbDllLoaded  = false then
    raise EDelphiLibSassError.Create('DLL not loaded');

  @fsass_compiler_parse := GetProcAddress(fDLLHandle, 'sass_compiler_parse');
  if (@fsass_compiler_parse = nil) then
    raise EDelphiLibSassError.Create('GetProcAddress cannot find sass_compiler_parse');

  Result := fsass_compiler_parse(Sass_Compiler);
end;

function TDelphiLibSassLib.sass_compiler_execute(Sass_Compiler: TSass_Compiler): integer;
var
  fsass_compiler_execute: Tsass_compiler_execute;
begin
  if fbDllLoaded  = false then
    raise EDelphiLibSassError.Create('DLL not loaded');

  @fsass_compiler_execute := GetProcAddress(fDLLHandle, 'sass_compiler_execute');
  if (@fsass_compiler_execute = nil) then
    raise EDelphiLibSassError.Create('GetProcAddress cannot find sass_compiler_execute');

  Result := fsass_compiler_execute(Sass_Compiler);
end;

function TDelphiLibSassLib.sass_context_get_error_status(Sass_Context: tSass_Context): integer;
var
  fsass_context_get_error_status: Tsass_context_get_error_status;
begin
  if fbDllLoaded  = false then
    raise EDelphiLibSassError.Create('DLL not loaded');

  @fsass_context_get_error_status := GetProcAddress(fDLLHandle, 'sass_context_get_error_status');
  if (@fsass_context_get_error_status = nil) then
    raise EDelphiLibSassError.Create('GetProcAddress cannot find sass_context_get_error_status');

  Result := fsass_context_get_error_status(Sass_Context);
end;

function TDelphiLibSassLib.sass_context_get_error_column(Sass_Context: tSass_Context): integer;
var
  fsass_context_get_error_column: Tsass_context_get_error_column;
begin
  if fbDllLoaded  = false then
    raise EDelphiLibSassError.Create('DLL not loaded');

  @fsass_context_get_error_column := GetProcAddress(fDLLHandle, 'sass_context_get_error_column');
  if (@fsass_context_get_error_column = nil) then
    raise EDelphiLibSassError.Create('GetProcAddress cannot find sass_context_get_error_column');

  Result := fsass_context_get_error_column(Sass_Context);
end;


function TDelphiLibSassLib.sass_context_get_error_line(Sass_Context: tSass_Context): integer;
var
  fsass_context_get_error_line: Tsass_context_get_error_line;
begin
  if fbDllLoaded  = false then
    raise EDelphiLibSassError.Create('DLL not loaded');

  @fsass_context_get_error_line := GetProcAddress(fDLLHandle, 'sass_context_get_error_line');
  if (@fsass_context_get_error_line = nil) then
    raise EDelphiLibSassError.Create('GetProcAddress cannot find sass_context_get_error_line');

  Result := fsass_context_get_error_line(Sass_Context);
end;

function TDelphiLibSassLib.sass_context_get_included_files_size(Sass_Context: tSass_Context): integer;
var
  fsass_context_get_included_files_size: Tsass_context_get_included_files_size;
begin
  if fbDllLoaded  = false then
    raise EDelphiLibSassError.Create('DLL not loaded');

  @fsass_context_get_included_files_size := GetProcAddress(fDLLHandle, 'sass_context_get_included_files_size');
  if (@fsass_context_get_included_files_size = nil) then
    raise EDelphiLibSassError.Create('GetProcAddress cannot find sass_context_get_included_files_size');

  Result := fsass_context_get_included_files_size(Sass_Context);
end;

function TDelphiLibSassLib.sass_context_get_included_files(Sass_Context: tSass_Context): TSass_included_files;
var
  fsass_context_get_included_files: Tsass_context_get_included_files;
begin
  if fbDllLoaded  = false then
    raise EDelphiLibSassError.Create('DLL not loaded');

  @fsass_context_get_included_files := GetProcAddress(fDLLHandle, 'sass_context_get_included_files');
  if (@fsass_context_get_included_files = nil) then
    raise EDelphiLibSassError.Create('GetProcAddress cannot find sass_context_get_included_files');

  Result := fsass_context_get_included_files(Sass_Context);
end;



function TDelphiLibSassLib.sass_context_get_error_file(Sass_Context: tSass_Context): String;
var
  fsass_context_get_error_file: Tsass_context_get_error_file;
begin
  if fbDllLoaded  = false then
    raise EDelphiLibSassError.Create('DLL not loaded');

  @fsass_context_get_error_file := GetProcAddress(fDLLHandle, 'sass_context_get_error_file');
  if (@fsass_context_get_error_file = nil) then
    raise EDelphiLibSassError.Create('GetProcAddress cannot find sass_context_get_error_file');

  Result := fsass_context_get_error_file(Sass_Context);
end;

function TDelphiLibSassLib.sass_context_get_error_message(Sass_Context: tSass_Context): String;
var
  fsass_context_get_error_message: Tsass_context_get_error_message;
begin
  if fbDllLoaded  = false then
    raise EDelphiLibSassError.Create('DLL not loaded');

  @fsass_context_get_error_message := GetProcAddress(fDLLHandle, 'sass_context_get_error_message');
  if (@fsass_context_get_error_message = nil) then
    raise EDelphiLibSassError.Create('GetProcAddress cannot find sass_context_get_error_message');

  Result := fsass_context_get_error_message(Sass_Context);
end;

function TDelphiLibSassLib.sass_context_get_error_text(Sass_Context: tSass_Context): String;
var
  fsass_context_get_error_text: Tsass_context_get_error_text;
begin
  if fbDllLoaded  = false then
    raise EDelphiLibSassError.Create('DLL not loaded');

  @fsass_context_get_error_text := GetProcAddress(fDLLHandle, 'sass_context_get_error_text');
  if (@fsass_context_get_error_text = nil) then
    raise EDelphiLibSassError.Create('GetProcAddress cannot find sass_context_get_error_text');

  Result := fsass_context_get_error_text(Sass_Context);
end;

function TDelphiLibSassLib.sass_context_get_output_string(Sass_Context: tSass_Context): String;
var
  fsass_context_get_output_string: Tsass_context_get_output_string;
begin
  if fbDllLoaded  = false then
    raise EDelphiLibSassError.Create('DLL not loaded');

  @fsass_context_get_output_string := GetProcAddress(fDLLHandle, 'sass_context_get_output_string');
  if (@fsass_context_get_output_string = nil) then
    raise EDelphiLibSassError.Create('GetProcAddress cannot find sass_context_get_output_string');

  Result := fsass_context_get_output_string(Sass_Context);
end;


procedure TDelphiLibSassLib.sass_delete_compiler(Sass_Compiler: TSass_Compiler);
var
  fsass_delete_compiler: Tsass_delete_compiler;
begin
  if fbDllLoaded  = false then
    raise EDelphiLibSassError.Create('DLL not loaded');

  @fsass_delete_compiler := GetProcAddress(fDLLHandle, 'sass_delete_compiler');
  if (@fsass_delete_compiler = nil) then
    raise EDelphiLibSassError.Create('GetProcAddress cannot find sass_delete_compiler');

  fsass_delete_compiler(Sass_Compiler);
end;


procedure TDelphiLibSassLib.sass_delete_file_context(Sass_File_Context: TSass_File_Context);
var
  fsass_delete_file_context: Tsass_delete_file_context;
begin
  if fbDllLoaded  = false then
    raise EDelphiLibSassError.Create('DLL not loaded');

  @fsass_delete_file_context := GetProcAddress(fDLLHandle, 'sass_delete_file_context');
  if (@fsass_delete_file_context = nil) then
    raise EDelphiLibSassError.Create('GetProcAddress cannot find sass_delete_file_context');

  fsass_delete_file_context(Sass_File_Context);
end;


procedure TDelphiLibSassLib.sass_delete_data_context(Sass_Data_Context: TSass_Data_Context);
var
  fsass_delete_data_context: Tsass_delete_data_context;
begin
  if fbDllLoaded  = false then
    raise EDelphiLibSassError.Create('DLL not loaded');

  @fsass_delete_data_context := GetProcAddress(fDLLHandle, 'sass_delete_data_context');
  if (@fsass_delete_data_context = nil) then
    raise EDelphiLibSassError.Create('GetProcAddress cannot find sass_delete_data_context');

  fsass_delete_data_context(Sass_Data_Context);
end;

function TDelphiLibSassLib.sass_make_data_context(source_string: PAnsiChar): TSass_Data_Context;
var
  fsass_make_data_context: Tsass_make_data_context;
begin
  if fbDllLoaded  = false then
    raise EDelphiLibSassError.Create('DLL not loaded');

  @fsass_make_data_context := GetProcAddress(fDLLHandle, 'sass_make_data_context');
  if (@fsass_make_data_context = nil) then
    raise EDelphiLibSassError.Create('GetProcAddress cannot find sass_make_data_context');

  result := fsass_make_data_context(source_string);
end;


function TDelphiLibSassLib.sass_make_data_compiler(Sass_Data_Context: TSass_Data_Context): TSass_Compiler;
var
  fsass_make_data_compiler: Tsass_make_data_compiler;
begin
  if fbDllLoaded  = false then
    raise EDelphiLibSassError.Create('DLL not loaded');

  @fsass_make_data_compiler := GetProcAddress(fDLLHandle, 'sass_make_data_compiler');
  if (@fsass_make_data_compiler = nil) then
    raise EDelphiLibSassError.Create('GetProcAddress cannot find sass_make_data_compiler');

  result := fsass_make_data_compiler(Sass_Data_Context);
end;

end.
