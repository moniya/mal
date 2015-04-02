Importer FileImporter importPath("reader.io")

ns := Map with ("+",            block(a, a at(0) + a at(1)),
                "-",            block(a, a at(0) - a at(1)),
                "*",            block(a, a at(0) * a at(1)),
                "/",            block(a, a at(0) / a at(1)),

                "pr-str",       block(a, a map(e, prStr(e, true)) join(" ")),
                "str",          block(a, a map(e, prStr(e)) join),
                "prn",          block(a, writeln(a map(e, prStr(e, true)) join(" "))),
                "println",      block(a, writeln(a map(e, prStr(e)) join(" "))),

                "list",         block(a, a),
                "list?",        block(a, a at(0) isKindOf(List)),
                "empty?",       block(a, a at(0) isEmpty),
                "count",        block(a, if(a at(0) == nil, 0, a at(0) size)),
                "=",            block(a, a at(0) == a at(1)),
                "<",            block(a, a at(0) <  a at(1)),
                "<=",           block(a, a at(0) <= a at(1)),
                ">",            block(a, a at(0) >  a at(1)),
                ">=",           block(a, a at(0) >= a at(1)),

                "cons",         block(a, ls, ls prepend (a)),
                "concat",       block(xs, xs reduce(acc, x, acc appendSeq(x)))
                "read-string",  block(a, readStr(a first)),
                "slurp",        block(a, File with(a first) openForReading contents))
