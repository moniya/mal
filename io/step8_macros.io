Importer FileImporter importPath("printer.io")
Importer FileImporter importPath("reader.io")
Importer FileImporter importPath("env.io")
Importer FileImporter importPath("core.io")

READ   := method(str, readStr(str))

EVAL   := method(ast, env,
    loop(
        if (ast isKindOf(List),
            ast = macroexpand(ast, env)
            if (ast isKindOf(List) not, return ast)

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
                    if (a0 == "quote",
                        return a1,
                        if (a0 == "quasiquote",
                            ast = quasiquote(a1),
                            if (a0 == "defmacro!",
                                fnct := EVAL(a2, env)
                                fnct isMacro := true
                                return env set(a1, fnct),
                                if (a0 == "macroexpand",
                                    return macroexpand(a1, env),
                                    if (a0 == "do",
                                        eval_ast(ast slice(1, -1), env)
                                        ast = ast last,
                                        if (a0 == "if",
                                            if (EVAL(a1, env), ast = a2, ast = a3),
                                            if (a0 == "fn*",
                                                return Function clone with (a2, env, a1, block(args, EVAL(a2, Env clone with(env, a1, args)))),
                                                el := eval_ast(ast, env)
                                                f := el first
                                                if (f type == "Function",
                                                    ast = f ast
                                                    env = f gen_env(el rest),
                                                    return f call(el rest))))))))))),
        return eval_ast(ast, env))))

eval_ast := method(ast, env,
    if (ast isKindOf(List), ast map(a, EVAL(a, env)),
    if (ast isKindOf(Sequence),
        if (ast isSymbol,
            env get(ast),
            ast),
        ast)))

is_pair := method(x, return x isKindOf(List) and (x isNotEmpty))

quasiquote := method(ast,
    if (is_pair(ast) not, return list("quote", ast),
    if (ast first == "unquote", return ast at(1),
    if (is_pair(ast first) and (ast first first == "splice-unquote"),
        return list("concat", ast at(0) at(1), quasiquote(ast rest)),
    return list("cons", quasiquote(ast first), quasiquote(ast rest))))))

isMacroCall := method(ast, env,
    return  ast isKindOf(List)      and(
            ast first isSymbol      and(
            env find(ast first)     and(
            env get(ast first) isKindOf(Function) and(
            env get(ast first) isMacro)))))

macroexpand := method(ast, env,
    while (isMacroCall(ast, env),
        macro := env get(ast first)
        ast := macro call(ast rest)
    )
    return ast)

Function := Object clone
Function env := nil
Function params := nil
Function ast := nil
Function isMacro := false
Function with := method(_ast, _env, _params, _block, _isMacro,
    ast ::= _ast
    params ::= _params
    blk ::= _block
    env ::= _env
    isMacro ::= if(_isMacro isNil not, _isMacro)
    self)
Function gen_env := method(args,
    return Env clone with(env, params, args))
Function call := method(args, return blk call(args))


PRINT_ := method(exp, prStr(exp, true))

repl_env := Env clone with(nil, list(), list())
ns foreach(k, v, repl_env set(k, v))
REP := method(str, PRINT_(EVAL(READ(str), repl_env)))

repl_env set("eval", block(ast, EVAL(ast first, repl_env)))
lf := "(def! load-file (fn* (f) (eval (read-string (str \"(do \" (slurp f) \")\")))))"
nt := "(def! not (fn* (a) (if a false true)))"

EVAL(READ(lf), repl_env)
EVAL(READ(nt), repl_env)


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

