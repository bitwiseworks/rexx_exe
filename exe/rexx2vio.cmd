/* REXX2VIO: bind resource to REXX_VIO.EXE */

rexx2exe = 'rexx2vio'     /* own name */
rexx_exe = 'rexx_vio.exe' /* loader   */

Parse Arg FileName ExeName

if FileName = '' then
  do
    Say 'Usage: '+Translate(rexx2exe)+' <sourcefile> [<exefile>]'
    Return 1
  end

if Stream(FileName, 'C', 'Query Exist') == '' then
  do
    Say 'File "'FileName'" does not exist!'
    Return 1
  end

if ExeName = '' then
  do
    Parse Value FileSpec('name', FileName) With Fname '.' Fext
    ExeName = FileSpec('drive', FileName)||FileSpec('path', FileName)||Fname||'.exe'
  end

Parse Source operatingSystem commandType sourceFileName
rexx_exe = FileSpec('drive', sourceFileName) || FileSpec('path', sourceFileName) || rexx_exe
if Stream(rexx_exe, 'C', 'Query Exist') == '' then
  do
    Say 'File "'rexx_exe'" is required, but does not exist!'
    Return 1
  end


'@copy' rexx_exe ExeName
'@echo RESOURCE 17746 1' FileName ' > %tmp%\'rexx2exe'.rc'
'@rc.exe -n -x2 %tmp%\'rexx2exe'.rc' ExeName
'@del %tmp%\'rexx2exe'.rc %tmp%\'rexx2exe'.res'
Return 0
