DESTDIR := .

STL_FILES := \
	$(DESTDIR)/cloak_token.stl \
	$(DESTDIR)/critical_damage_token.stl \
	$(DESTDIR)/evade_token.stl \
	$(DESTDIR)/focus_token.stl \
	$(DESTDIR)/ion_token.stl \
	$(DESTDIR)/shield_token.stl \
	$(DESTDIR)/stress_token.stl

all: ${STL_FILES}

$(DESTDIR)/%.stl: %.scad common.scad
	openscad -o $@ $<

clean:
	rm -f *.stl

.PHONY: all clean

