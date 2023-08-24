#!/usr/bin/env perl
use v5.30;
use warnings;
use utf8;
use open qw(:std :utf8);

=pod

=encoding UTF-8

=head1

Проверяет и раскладывает введенную пользователем дату на две части

=cut

print "Введите дату: ";
chomp(my $input = <STDIN>);

# с валидацией чисел
if ($input =~ /^(\d{4}-(?:0\d|1[0-2])-(?:[0-2]\d|3[01]))\s((?:[01]\d|2[0-3]):(?:[0-5]\d):(?:[0-5]\d))$/) {
    my ($date, $time) = ($1, $2);
    say "Дата(valid): $date";
    say "Время(valid): $time";
}
# без валидации чисел
elsif ($input =~ /^(\d{4}-\d{2}-\d{2})\s(\d{2}:\d{2}:\d{2})$/) {
    my ($date, $time) = ($1, $2);
    say "Дата: $date";
    say "Время: $time";
}