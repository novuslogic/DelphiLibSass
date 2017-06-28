unit DelphiLibSassCommon;

interface

Uses System.SysUtils;


const
  cLibSassName = 'libsass.dll';

type
  TIntPtr = Pointer;

  TSass_File_Context = TIntPtr;
  TSass_Compiler = TIntPtr;
  TSass_Context = TIntPtr;
  TSass_included_files =  TIntPtr;

  PSass_AnsiString = ^PAnsiChar;
  PSass_AnsiStringArray = array of PSass_AnsiString;

  Tlibsass_version = function(): PAnsiChar; StdCall;
  Tlibsass_language_version = function(): PAnsiChar; StdCall;
  Tsass_make_file_context = function(input_path: PAnsiChar):  TSass_File_Context; StdCall;
  Tsass_make_file_compiler = function(Sass_File_Context: TSass_File_Context): TSass_Compiler; StdCall;
  Tsass_compiler_parse = function(Sass_Compiler: TSass_Compiler): integer; StdCall;
  Tsass_compiler_execute = function(Sass_Compiler: TSass_Compiler): integer; StdCall;
  Tsass_context_get_error_status = function(Sass_Context: tSass_Context): integer; StdCall;
  Tsass_context_get_error_column = function(Sass_Context: tSass_Context): integer; StdCall;
  Tsass_context_get_error_line = function(Sass_Context: tSass_Context): integer; StdCall;
  Tsass_context_get_error_file = function(Sass_Context: tSass_Context): PAnsiChar; StdCall;
  Tsass_context_get_error_message = function(Sass_Context: tSass_Context): PAnsiChar; StdCall;
  Tsass_context_get_error_text = function(Sass_Context: tSass_Context): PAnsiChar; StdCall;
  Tsass_context_get_output_string = function(Sass_Context: tSass_Context): PAnsiChar; StdCall;
  Tsass_context_get_included_files_size = function(Sass_Context: tSass_Context): integer; StdCall;
  Tsass_context_get_included_files = function(Sass_Context: tSass_Context): TSass_included_files; StdCall;
  Tsass_delete_compiler = procedure (Sass_Compiler: TSass_Compiler);
  Tsass_delete_file_context = procedure(Sass_File_Context: TSass_File_Context);

  TSassOutputStyle = (Nested, Expanded, Compact, Compressed);

  EDelphiLibSassError = class(Exception);

  function LibSassString(aString: String): PAnsiChar;


implementation

function LibSassString(aString: String): PAnsiChar;
begin
  Result := PAnsiChar(AnsiString(AString));
end;



end.
