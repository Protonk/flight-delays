

# dumb script to remove quotes (because I can just specify qupted strings as
# characters when importing) and trailing commas


while(<STDIN>) {
	my($line) = $_;
	$line =~ s/,+$//g;
	$line =~ s/\"*//g;
	print $line;
}
