{$ifdef CompilerVersion}
  {$IF CompilerVersion >= 21}
    {$DEFINE CompilerVersion_g21}
  {$ELSE}
    {$DEFINE CompilerVersion_l21}  
  {$IFEND}
  {$IF CompilerVersion >= 19} // From Tiburon / Delphi 2009 has support generic collection
    {$DEFINE GEN_SUPPORT}
    {$DEFINE YES_SCOPEDENUMS}

  {$ELSE}
    {$DEFINE GEN_NOSUPPORT} //No support Generic
    {$DEFINE NO_TStringBuilder}//No Support TStringBuilder
    {$DEFINE NO_SCOPEDENUMS}//No Support TStringBuilder

  {$IFEND}
{$else}
  {$DEFINE GEN_NOSUPPORT}
  {$DEFINE NO_TStringBuilder}
  {$DEFINE NO_SCOPEDENUMS}
  {$DEFINE CompilerVersion_l21}  
{$endif}
