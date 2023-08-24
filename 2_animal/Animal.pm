package Animal;
use strict;
use utf8;

sub new {
	my ($self) = @_;
	my $class = bless {}, $self;

	return $class;
}

sub feed {
    my $class = shift;

    return "Корм 'Best Dinner' - рекомендую!";
}

sub educate {
    my $class = shift;

    return "воспитывать кнутом и пряником!";
}

1;