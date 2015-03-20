Importer FileImporter importPath( "printer.io")
Importer FileImporter importPath( "reader.io")

read   := method(str, readStr(str))
eval   := method(str, str)
print_ := method(str, prStr(str))
rep    := method(str,
  print_(eval(read(str)))
)

while ((input := ReadLine readLine("user> ")) != nil,
  e := try (
    if (input isEmpty,
      "" print,
      rep(input) println
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

