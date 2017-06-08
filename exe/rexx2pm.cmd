/* REXX2PM: bind resource to REXX_PM.EXE */
Parse Source . . Source
helper = FileSpec('d', Source) || FileSpec('p', Source) || 'rexx2xx.cmd'
if Stream(helper, 'C', 'Query Exist') = '' then do
  Say 'FATAL: Helper "'helper'" is not found.'
  exit 1
end
Parse Arg Args
'@call' helper '@PM' Args
