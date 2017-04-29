DESTDIR := .

MAX_NUMERIC = 12
MAX_TARGETLOCK = 12
STL_FILES := \
	$(DESTDIR)/cloak_token.stl \
	$(DESTDIR)/critical_damage_token.stl \
	$(DESTDIR)/evade_token.stl \
	$(DESTDIR)/focus_token.stl \
	$(DESTDIR)/ion_token.stl \
	$(patsubst %,$(DESTDIR)/numeric_token_%.stl,$(shell seq 1 $(MAX_NUMERIC))) \
	$(DESTDIR)/shield_token.stl \
	$(DESTDIR)/stress_token.stl \
	$(patsubst %,$(DESTDIR)/target_lock_token_%.stl,$(shell ./letterseq.pl $(MAX_TARGETLOCK)))

all: ${STL_FILES}

$(DESTDIR)/%.stl: %.scad common.scad
	openscad -o $@ $<

$(DESTDIR)/numeric_token_%.stl: numeric_token.scad common.scad
	openscad -D 'NUMBER="$*"' -o $@ $<

$(DESTDIR)/target_lock_token_%.stl: target_lock_token.scad common.scad
	openscad -D 'LETTER="$*"' -o $@ $<

clean:
	rm -f *.stl

.PHONY: all clean

