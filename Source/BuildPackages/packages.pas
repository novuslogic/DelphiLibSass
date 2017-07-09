{********************************************************************}
{                                                                    }
{           packages.pas                                             }
{                                                                    }
{           Apache License                                           }
{           Version 2.0, January 2004                                }
{           License at http://www.apache.org/licenses/               }
{                                                                    }
{                                                                    }
{           Copyright (c) 2017 Novuslogic Software                   }
{           http://www.novuslogic.com                                }
{                                                                    }
{********************************************************************} 

Uses Zcodegen, Delphi;

procedure BuldDelphiPackages(aDelphiVersion: TDelphiVersion);
begin
  if Zcodegen('packages.zcproject', 'packages.zcconfig', Format('DELPHIVER="%s";LIBSUFFIX="%s"', [GetDelphiCompilerVersion(aDelphiVersion), GetDelphiPackageVersion(aDelphiVersion)]), wd, '') <> 0 then
     RaiseException(erCustomError, 'failed.');  
end;

procedure BuildDelphiPackages;
Var 
  I: Integer;
begin
  Output.log('Build Delphi Packages ...');
  
  for I := 4 to DelphiVersionMax do 
     BuldDelphiPackages(TDelphiVersion(i));
end;  


begin
  Output.log('Building Delphi Packages ...');

  Output.log('Working Directory: '+wd);

   with Task.AddTask('BuildDelphiPackages') do
    begin
      Criteria.Failed.Abort := True;
     
      
    end;

 
  if not Task.RunTarget('BuildDelphiPackages') then 
    RaiseException(erCustomError, 'missing procedure.'); 

 
  
  
end.
