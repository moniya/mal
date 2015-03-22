Importer FileImporter importPath("printer.io")
Importer FileImporter importPath("reader.io")
Importer FileImporter importPath( "env.io")

repl_env := Env clone with(nil)
repl_env set("+", block(args, args at(0) + args at(1)))
repl_env set("-", block(args, args at(0) - args at(1)))
repl_env set("*", block(args, args at(0) * args at(1)))
repl_env set("/", block(args, args at(0) / args at(1)))

eval_ast := method(ast, env,
  if(ast isKindOf(Sequence), env get(ast),
  if(ast isKindOf(List)    , ast map(a, EVAL(a, env)),
  ast))
)

READ   := method(str, readStr(str))

EVAL   := method(ast, env,
  if (ast isKindOf(List),
     a0 := ast at(0); a1 := ast at(1); a2 := ast at(2)
     if (a0 == "def!",
        env set(a1, EVAL(a2, env)),
        if (a0 == "let*",
           letEnv := Env clone with(env)
           i := 0
           while(i < a1 size,
             letEnv set(a1 at(i), EVAL(a1 at(i+1), letEnv))
             i := i + 2
           )
           EVAL(a2, letEnv),

             el := eval_ast(ast, env)
             (el first) call(el rest))),


     eval_ast(ast, env)))

PRINT_ := method(exp, prStr(exp))

REP    := method(str, PRINT_(EVAL(READ(str), repl_env)))

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

