STL_FILES := \
	cloak_token.stl \
	critical_damage_token.stl \
	evade_token.stl \
	focus_token.stl \
	ion_token.stl \
	shield_token.stl \
	stress_token.stl

all: ${STL_FILES}

%.stl: %.scad common.scad
	openscad -o $@ $<

clean:
	rm -f *.stl

.PHONY: all clean

