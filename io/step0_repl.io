READ   := method(str, str)
EVAL   := method(str, str)
PRINT_ := method(str, str)
REP    := method(str,
  PRINT_(EVAL(READ(str)))
)

while((input := ReadLine readLine("user> ")) != nil,
  if (input size == 0,
    "" print,
    REP(input) println
    ReadLine addHistory(input)
  )
)
"" println

