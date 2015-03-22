UndefinedVariableException := Exception clone

Env := Object clone
Env data  := nil
Env set   := method(sym, val,
  data atPut(sym, val)
  val
)
Env find  := method(sym,
  if (data at(sym) != nil,
      data,
      if (outer != nil,
          outer find(sym),
          nil)))

Env get   := method(sym,
  if ((d := find(sym)) != nil,
      d at(sym),
      UndefinedVariableException raise("'#{sym}' not found" interpolate)))

Env with := method(o,
  outer ::= o
  data  ::= Map clone
  self
)
