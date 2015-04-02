Importer FileImporter importPath( "printer.io")
Importer FileImporter importPath( "reader.io")

READ   := method(str, readStr(str))
EVAL   := method(ast, ast)
PRINT_ := method(exp, prStr(exp, true))
REP    := method(str,
  PRINT_(EVAL(READ(str)))
)

while ((input := ReadLine readLine("user> ")) != nil,
  e := try (
    if (input isEmpty,
      "" print,
      REP(input) println
      ReadLine addHistory(input)
    )
  )
  e catch(EmptyTokenException,
    "" print
  )
  e catch(SyntaxError,
    e showStack
  )
)
"" println

