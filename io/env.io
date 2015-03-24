UndefinedVariableException := Exception clone

Env := Object clone
Env data := nil
Env set := method(sym, val,
  data atPut(sym, val)
  val)

Env find := method(sym,
  if (data at(sym) != nil,
      data,
      if (outer != nil,
          outer find(sym),
          nil)))

Env get := method(sym,
  if ((d := find(sym)) != nil,
      d at(sym),
      UndefinedVariableException raise("'#{sym}' not found" interpolate)))

Env with := method(out, binds, exprs,
  outer ::= out
  data  ::= if (binds isEmpty, Map clone, zip(binds, exprs) asMap)
  self)

zip := method(l1, l2,
    if (l1 isEmpty(),
        list(),
        if (l2 isEmpty,
            list(),
            zip(l1 rest, l2 rest) prepend(list(l1 first, l2 first)))))
