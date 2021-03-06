REBAR=$(shell which rebar || ./rebar)
SYNC_PATH = $(ERL_LIBS)/sync

all: deps compile

compile:
		@$(REBAR) compile

app:
		@$(REBAR) compile skip_deps=true

deps:
		@$(REBAR) get-deps

clean:
		@$(REBAR) clean

distclean: clean
		@$(REBAR) delete-deps

test: app
		@$(REBAR) eunit skip_deps=true

start:
		if test -d $(SYNC_PATH); \
		then exec erl -pa $(PWD)/ebin; \
		else exec erl -pa $(PWD)/ebin -s reloader; \
		fi
