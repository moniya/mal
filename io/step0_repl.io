read   := method(str, str)
eval   := method(str, str)
print_ := method(str, str)
rep    := method(str,
  print_(eval(read(str)))
)

while((input := ReadLine readLine("user> ")) != nil,
  if (input size == 0,
    "" print,
    rep(input) println
    ReadLine addHistory(input)
  )
)
"" println

