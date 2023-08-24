#!/usr/bin/env perl
use v5.30;
use warnings;
use utf8;
use open qw(:std :utf8);

=pod

=encoding UTF-8

=head1

Инструкция по содержанию домашних животных

=cut

use lib './';
use Cat;

say "О каких животных хотете узнать?\n1 - Коты\n2 - Слоны\n3 - Собаки\n";
print 'выберите номер: ';
chomp(my $input = <STDIN>);

if ($input eq 1) {
    my $obj = Cat->new();

    say 'Кормление: ' . $obj->feed;
    say 'Воспитание: ' . $obj->educate;
}
elsif ($input eq 2) {
    say "Может, не надо?";
}
elsif ($input eq 3) {
    say 'Гав';
}
else {
    say 'Данных нет';
}
