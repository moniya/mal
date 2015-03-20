TESTS =

SOURCES_BASE = mal_readline.io types.io reader.io printer.io
SOURCES_LISP = env.io core.io stepA_mal.io
SOURCES = $(SOURCES_BASE) $(SOURCES_LISP)

#all: mal.io

.PHONY: stats tests $(TESTS)

stats: $(SOURCES)
	@wc $^
stats-lisp: $(SOURCES_LISP)
	@wc $^

tests: $(TESTS)

$(TESTS):
	@echo "Running $@"; \
	io $@ || exit 1; \
