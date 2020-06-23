CWD		= $(CURDIR)
MODULE	= $(notdir $(CWD))

NOW = $(shell date +%d%m%y)
REL = $(shell git rev-parse --short=4 HEAD)



.PHONY: all
all: $(MODULE) $(MODULE).ini
	./$^

.PHONY: docs
docs:
	cd $@ ; find ../src -type f -regex .+.nim$$ | xargs -n1 -P0 nim doc

SRC = src/$(MODULE).nim

$(MODULE): $(SRC) $(MODULE).nimble Makefile
	find src -type f -regex .+.nim$$ | xargs -n1 -P0 nimpretty --indent:2
	nimble build



.PHONY: install update
install update: debian

.PHONY: debian
debian:
	sudo apt update
	sudo apt install -u `cat apt.txt`



.PHONY: master shadow release zip

MERGE  = Makefile README.md .gitignore .vscode apt.txt
MERGE += src $(MODULE).nimble

master:
	git checkout $@
	git checkout shadow -- $(MERGE)

shadow:
	git checkout $@

release:
	git tag $(NOW)-$(REL)
	git push -v && git push -v --tags
	git checkout shadow

zip:
	git archive --format zip --output $(MODULE)_src_$(NOW)_$(REL).zip HEAD
