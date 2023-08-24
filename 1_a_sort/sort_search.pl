#!/usr/bin/env perl
use v5.30;
use warnings;
use utf8;
use open qw(:std :utf8);

=pod

=encoding UTF-8

=head1 DESCRIPTION

Скрипт выполняет пузырьковую сортировку массива чисел и бинарный поиск числа, введенного пользователем

=cut


my @unsorted = ( qw/ 7 1 3 4 2 4 6 5 5 / );

my @sorted = _bubble(\@unsorted)->@*;
say 'Пузырьковая сортировка вернула: (' . join(', ', @sorted) . ')';

my $input = '';
while($input !~ /^\-?\d+$/) {
    print 'Введите искомый элемент(целое число): ';
    chomp($input = <STDIN>);
}

say _binary_search($input, \@sorted) ? 'MATCH' : 'NOT_MATCH';


=head2 _bubble

Пузырьковая сортировка.
Принимает ссылку на массив чисел и возвращает ссылку на массив чисел.

=cut

sub _bubble {
    my $arr = shift;
	for (my $n = $#$arr; $n > 1; $n--) {
		for (my $i = 0; $i < $n; $i++) {
			($arr->[$i], $arr->[$i + 1]) = ($arr->[$i + 1], $arr->[$i]) if $arr->[$i] > $arr->[$i + 1];
		}
	}
	$arr;
}


=head2 _binary_search

Бинарный поиск числа.
Функция принимает искомое число и список чисел, возвращает true или false

=cut

sub _binary_search {
    my ($num, $arr) = @_;
 
    my $min = 0;
    my $max = $#$arr;
    
    while ($min <= $max) {
        my $middle = int(($max + $min) / 2);

        if ($num < $arr->[$middle]) {
            $max = $middle - 1;
            next;
        }
        if ($num > $arr->[$middle]) {
            $min = $middle + 1;
            next;
        }
        return 1;
    }
 
    return;
}