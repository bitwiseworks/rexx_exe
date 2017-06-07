/* REXX2PM: bind resource to REXX_PM.EXE */

rexx2exe = 'rexx2pm'     /* own name */
rexx_exe = 'rexx_pm.exe' /* loader   */

call RxFuncAdd 'SysSearchPath', 'RexxUtil', 'SysSearchPath'

Parse Arg FileName ExeName

FileName = TRANSLATE( FileName, '\', '/')
ExeName = TRANSLATE( ExeName, '\', '/')

if FileName = '' then
  do
    Say 'Usage: 'Translate(rexx2exe)' <sourcefile> [<exefile>]'
    Return 1
  end

if Stream(FileName, 'C', 'Query Exist') == '' then
  do
    Say 'File "'FileName'" does not exist!'
    Return 1
  end

Parse Value FileSpec('name', FileName) With Fname '.' Fext
if ExeName = '' then
  do
    ExeName = FileSpec('drive', FileName)||FileSpec('path', FileName)||Fname||'.exe'
  end

Parse Source operatingSystem commandType sourceFileName
rexx_exe = FileSpec('drive', sourceFileName) || FileSpec('path', sourceFileName) || rexx_exe
if Stream(rexx_exe, 'C', 'Query Exist') == '' then
  do
    rexx_exe = SysSearchPath('PATH', rexx_exe)
    if Stream(rexx_exe, 'C', 'Query Exist') == '' then
      do
        Say 'File "'rexx_exe'" is required, but does not exist!'
        Return 1
      end
  end

'@copy' rexx_exe ExeName
'@echo RESOURCE 17746 1' FileName ' > %tmp%\'Fname'.rc'
'@rc.exe -n -x2 %tmp%\'Fname'.rc' ExeName
'@del %tmp%\'Fname'.rc %tmp%\'Fname'.res'
Return 0
