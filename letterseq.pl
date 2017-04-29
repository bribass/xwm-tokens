#!/usr/bin/env perl

if (not defined $ARGV[0]) {
	print "$0: missing operand\n";
	exit 1;
}
my $num = int $ARGV[0];
if ($num ne $ARGV[0]) {
	print "$0: invalid integer argument '" . $ARGV[0] . "'\n";
	exit 1;
}
if ($num < 1 or $num > (26 * 2)) {
	print "$0: out of range argument '$num'\n";
	exit 1;
}
my @LETTERS = "A".."Z";
for ($i = 0; $i < $num; $i++) {
	my $val = $i;
	my $times = 1;
	if ($val >= 26) {
		$val -= 26;
		$times = 2;
	}
	print $LETTERS[$val] x $times . "\n";
}

