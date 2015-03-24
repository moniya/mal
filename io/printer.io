prStr := method(obj,
    if (obj type != "List",
        obj asString,
        obj map(o, prStr(o)) join (" ") asMutable prependSeq("(") appendSeq(")")))
