# DelphiLibSass

DelphiLibSass is Delphi wrapper around [libsass](https://github.com/sass/libsass) a C/C++ implementation of a Sass compiler.

Based on the version of `libsass 3.4.5` http://libsass.org 

## Support

- Delphi 2009 to Delphi 10.2

## Usage

DelphiLibSass API is simply composed of a main `TDelphiLibSass` class

`TDelphiLibSass.ConvertToCss` converts a `SCSS` string to a `CSS`

```
Try
  FDelphiLibSass := TDelphiLibSass.Create('libsass.dll');
  FDelphiLibSass.LoadDLL;

  FScssResult := FDelphiLibSass.ConvertToCss('$font-stack: Helvetica, sans-serif; body { font: 100% $font-stack; }');

  writeln(FScssResult.CSS);
Finally
  FScssResult.Free;
  FDelphiLibSass.Free; 
end;
```

`TDelphiLibSass.ConvertFileToCss` converts a `SCSS` file to a `CSS`

```
Try
  FDelphiLibSass := TDelphiLibSass.Create('libsass.dll');
  FDelphiLibSass.LoadDLL;

  FScssResult := FDelphiLibSass.ConvertFileToCss('test.scss');

  writeln(FScssResult.CSS);
Finally
  FScssResult.Free;
  FDelphiLibSass.Free; 
end;
```
## Sample

Basic example on how to use the Delphi wrapper

https://github.com/novuslogic/DelphiLibSass/tree/master/Sample

## Packages

- Support for Runtime Packages Delphi 2009 to Delphi 10.2

## Known Issues

- sass_context_get_included_files buffer overflows within Delphi.

## ToDo

- To add the TSass_Option class.


