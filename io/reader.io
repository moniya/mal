EmptyTokenException := Exception clone
SyntaxError := Exception clone

Reader := Object clone
Reader position ::= 0
Reader tokens := list()
Reader next := method(
  position ::= position + 1
  tokens at(position-1))
Reader peek := method(tokens at(position))

re := Regex with("[\\s ,]*(~@|[\\[\\]{}()'`~@]|\"(?:[\\\\].|[^\\\\\"])*\"|;.*|[^\\s \\[\\]{}()'\"`~@,;]*)")
tokenizer := method(str,
  str allMatchesOfRegex(re) map(captures at(1)) select(t, t at(0) != 59))

readStr := method(str,
  rdr := Reader clone
  if ((tks := tokenizer(str)) isEmpty,
    EmptyTokenException raise,
    rdr tokens := tks
    readForm(rdr)))

readForm := method(rdr,
  token := rdr peek
  if (token == "(", readList(rdr),
  if (token == ")", SyntaxError raise("unexpected ')'"),
  readAtom(rdr))))

readList := method(rdr,
  ast := list()
  if(rdr next != "(",
    SyntaxError raise("expected '(', got EOF"))

  while((token := rdr peek) != ")",
    if(token,
      ast append(readForm(rdr)),
      SyntaxError raise("expected ')', got EOF")))

  rdr next
  ast)

parseStr := method(str, str exSlice(1, -1) asMutable replaceSeq("\\\"", "\""))

readAtom := method(rdr,
  token := rdr next
  if (token hasMatchOfRegex("^-?[0-9]+$"), token asNumber,
  if (token hasMatchOfRegex("^\".*\""), parseStr(token) asMutable,
  if (token == "true", true,
  if (token == "false", false,
  if (token == "nil", nil,
  token))))))
