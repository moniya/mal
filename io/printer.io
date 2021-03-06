prStr := method(obj, printReadably,
    if (obj isKindOf(Sequence),
        if  (obj isSymbol,
            obj asString,
            if  (printReadably,
                obj asString asMutable escape prependSeq("\"") appendSeq("\""),
                obj asString)),
        if (obj isKindOf(List),
            obj map(o, prStr(o, printReadably)) join (" ") asMutable prependSeq("(") appendSeq(")"),
            obj asString)))
