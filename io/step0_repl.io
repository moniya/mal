READ   := method(str, str)
EVAL   := method(str, str)
PRINT_ := method(str, str)
REP    := method(str,
  PRINT_(EVAL(READ(str)))
)

while((input := ReadLine readLine("user> ")) != nil,
  if (input isEmpty,
    "" print,
    REP(input) println
    ReadLine addHistory(input)
  )
)
"" println

