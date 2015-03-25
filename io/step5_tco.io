Importer FileImporter importPath("printer.io")
Importer FileImporter importPath("reader.io")
Importer FileImporter importPath("env.io")
Importer FileImporter importPath("core.io")

eval_ast := method(ast, env,
    if (ast isKindOf(List), ast map(a, EVAL(a, env)),
    if (ast isKindOf(Sequence),
        if (ast isSymbol,
            env get(ast),
            ast),
        ast)))

READ   := method(str, readStr(str))

EVAL   := method(ast, env,
    loop(
        if (ast isKindOf(List),
            a0 := ast at(0); a1 := ast at(1); a2 := ast at(2); a3 := ast at(3)
            if (a0 == "def!",

                return env set(a1, EVAL(a2, env)),
                if (a0 == "let*",
                    letEnv := Env clone with(env, list(), list())
                    i := 0
                    while(i < a1 size,
                        letEnv set(a1 at(i), EVAL(a1 at(i+1), letEnv))
                        i := i + 2
                    )
                    ast=a2; env=letEnv,
                    if (a0 == "do",
                        eval_ast(ast slice(1, -1), env)
                        ast = ast last,
                        if (a0 == "if",
                            if (EVAL(a1, env), ast = a2, ast = a3),
                            if (a0 == "fn*",
                                fnct := Function clone with (a2, env, a1)
                                return fnct,
                                el := eval_ast(ast, env)
                                f := el first
                                if (f type == "Function",
                                    ast = f ast
                                    env = f gen_env(el rest),
                                    return f call(el rest))))))),
        return eval_ast(ast, env))
    ))

Function := Object clone
Function env := nil
Function params := nil
Function ast := nil
Function with := method(_ast, _env, _params,
    ast ::= _ast
    params ::= _params
    env ::= _env
    self)
Function gen_env := method(args,
    return Env clone with(env, params, args)
)


PRINT_ := method(exp, prStr(exp))


repl_env := Env clone with(nil, list(), list())
ns foreach(k, v, repl_env set(k, v))
REP := method(str, PRINT_(EVAL(READ(str), repl_env)))

while ((input := ReadLine readLine("user> ")) != nil,
  e := try (
    if (input isEmpty,
      "" print,
      REP(input) println
      ReadLine addHistory(input)))

  e catch(EmptyTokenException, "" print)
  e catch(SyntaxError, e showStack)
  e catch(UndefinedVariableException, e showStack))


"" println

