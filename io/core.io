ns := Map with ("+",        block(args, args at(0) + args at(1)),
                "-",        block(args, args at(0) - args at(1)),
                "*",        block(args, args at(0) * args at(1)),
                "/",        block(args, args at(0) / args at(1)),

                "list",     block(args, args),
                "list?",    block(args, args at(0) isKindOf(List)),
                "empty?",   block(args, args at(0) isEmpty),
                "count",    block(args, if(args at(0) == nil, 0, args at(0) size)),
                "=",        block(args, args at(0) == args at(1)),
                "<",        block(args, args at(0) <  args at(1)),
                "<=",       block(args, args at(0) <= args at(1)),
                ">",        block(args, args at(0) >  args at(1)),
                ">=",       block(args, args at(0) >= args at(1)))
