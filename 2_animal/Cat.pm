package Cat;
use strict;
use utf8;

use parent 'Animal';

sub new {
	my ($self) = @_;
	my $class = bless {}, $self;
	return $class;
}

sub educate {
    my $class = shift;

    return 'Если хотите быть поцарапанными и покусанными ' . Animal->educate;
}
1;