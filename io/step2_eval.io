Importer FileImporter importPath( "printer.io")
Importer FileImporter importPath( "reader.io")

repl_env := Map with ("+", block(args, args at(0) + args at(1)),
                      "-", block(args, args at(0) - args at(1)),
                      "*", block(args, args at(0) * args at(1)),
                      "/", block(args, args at(0) / args at(1)))

eval_ast := method(ast, env,
  if(ast isKindOf(Sequence), env at(ast),
  if(ast isKindOf(List)    , ast map(a, EVAL(a, env)),
  ast))
)

READ   := method(str, readStr(str))

EVAL   := method(ast, env,
  if(ast isKindOf(List),
    el := eval_ast(ast, env)
    (el first) call(el rest),
    eval_ast(ast, env))
)

PRINT_ := method(exp, prStr(exp))

REP    := method(str,
  PRINT_(EVAL(READ(str), repl_env))
)

while ((input := ReadLine readLine("user> ")) != nil,
  e := try (
    if (input isEmpty,
      "" print,
      REP(input) println
      ReadLine addHistory(input)))

  e catch(EmptyTokenException, "" print)
  e catch(SyntaxError, e showStack))

"" println


