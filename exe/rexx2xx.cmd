/* REXX2XX: bind resource to stub (loader) */

call RxFuncAdd 'SysSearchPath', 'RexxUtil', 'SysSearchPath'

Parse Arg Type FileName ExeName

Type = Translate(Type)
FileName = Translate(FileName, '\', '/')
ExeName = Translate(ExeName, '\', '/')

IsLauncher = Left(Type, 1) = '@'
Type = Substr(Type, 2)

if WordPos(Type, 'VIO PM') = 0 | FileName = '' then
  do
    if IsLauncher then
      Say 'Usage: REXX2'Type' <sourcefile> [<exefile>]'
    else
      do
        Say 'Usage: REXX2XX <type> <sourcefile> [<exefile>]'
        Say '<type> - VIO or PM'
      end
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

rc_exe = SysSearchPath('PATH', 'RC.EXE')
if rc_exe = '' then
  do
    Say 'Resource compiler RC.EXE is not found in PATH!'
    Return 1
  end

rexx_exe = 'rexx_'Type'.exe' /* loader   */

Parse Source operatingSystem commandType sourceFileName
rexx_exe = FileSpec('drive', sourceFileName) || FileSpec('path', sourceFileName) || rexx_exe
if Stream(rexx_exe, 'C', 'Query Exist') == '' then
  do
    Say 'File "'rexx_exe'" is required, but does not exist!'
    Return 1
  end

'@copy' rexx_exe ExeName
'@echo RESOURCE 17746 1' FileName ' > %tmp%\'Fname'.rc'
'@'rc_exe' -n -x2 %tmp%\'Fname'.rc' ExeName
'@del %tmp%\'Fname'.rc %tmp%\'Fname'.res'
Return 0
