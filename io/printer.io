prStr := method(obj,
  if (obj isKindOf(Sequence), obj,
  if (obj isKindOf(Number)  , obj asString,
  if (obj isKindOf(List)    , obj map(o, prStr(o)) join (" ") asMutable prependSeq("(") appendSeq(")")))))
