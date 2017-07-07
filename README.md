# DelphiLibSass

DelphiLibSass is Delphi wrapper around [libsass](https://github.com/sass/libsass) a C/C++ implementation of a Sass compiler.

Based on the version of `libsass 3.4` http://libsass.org 

## Usage

DelphiLibSass API is simply composed of a main `TDelphiLibSass` class

`TDelphiLibSass.ConvertToCss` converts a `SCSS` string to a `CSS`

```
Try
  FDelphiLibSass := TDelphiLibSass.Create('libsass.dll');

  FScssResult = FDelphiLibSass.ConvertToCss('div {color: #FFF;}');

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

  FScssResult = FDelphiLibSass.ConvertFileToCss('test.scss');

  writeln(FScssResult.CSS);
Finally
  FScssResult.Free;
  FDelphiLibSass.Free; 
end;
```



