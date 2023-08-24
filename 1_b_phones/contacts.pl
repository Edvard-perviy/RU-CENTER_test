#!/usr/bin/env perl
use v5.30;
use warnings;
use utf8;
use open qw(:std :utf8);

use DBI;

=pod

=encoding UTF-8

=head1 DESCRIPTION

Скрипт выполняет позволяет воспользоваться замечательной телефонной книжкой

=cut

# данные для подключение к базе mysql
my $db = 'TEL_BOOK';
my $user = 'user_tel';
my $password = 'M3BA1Po%as1Kse8Jt!aC';

my $dbh = DBI->connect("DBI:mysql:$db", $user, $password) or die "Error DBI connect: $!";
$dbh->{mysql_enable_utf8} = 1;

print "Вас приветствует 'Замечательная телефонная книжка'!

Перечень замечательных функций:
    1 - показать все контакты
    2 - добавить контакт
    3 - удалить контакт
    4 - изменить контакт
    
Пожалуйста, введите номер желаемой функции.
Для выхода введите пустую строчку.
    
Номер замечательной функции: ";

chomp(my $num_func = <STDIN>);

if ($num_func eq 1) {
    my $contacts = _select() || 'Контактов нет';
    say $contacts;
}
elsif ($num_func eq 2) {
    print "Введите Имя: ";
    chomp(my $name = <STDIN>);
    print "Введите Номер: ";
    chomp(my $number = <STDIN>);
    if ($name && $number) {
        say 'контакт добавлен' if _insert($name, $number);
    }
}
elsif ($num_func eq 3) {
    if (my $contacts = _select()) {
        say "Имеющиеся контакты:\n$contacts";
        print "Введите ID контакта для удаления: ";
        chomp(my $id = <STDIN>);
        say "контакт удалён" if _delete($id);
    }
    else {
        say "Контактов нет";
    }
}
elsif ($num_func eq 4) {
    if (my $contacts = _select()) {
        say "Имеющиеся контакты:\n$contacts";
        print "Введите ID контакта для изменения: ";
        chomp(my $id = <STDIN>);
        print "Введите Имя: ";
        chomp(my $name = <STDIN>);
        print "Введите Номер: ";
        chomp(my $number = <STDIN>);
        if ($id && ($name || $number)) {
            say 'контакт изменен' if _update($id, $name, $number);
        }
    }
    else {
        say "Контактов нет";
    }
}
else {
    say "Функция `$num_func` не найдена";
}


sub _select {
    my $contacts = $dbh->selectall_arrayref("SELECT * FROM phones");
    return @$contacts ? join("\n", map {join("\t", @$_)} @$contacts) : '';
}

sub _insert {
    $dbh->do("INSERT INTO phones (name, number) VALUES (?, ?)", undef, $_[0], $_[1]);
}

sub _delete {
    $dbh->do("DELETE FROM phones WHERE id = ?", undef, $_[0]);
}

sub _update {
    my ($id, $name, $number) = @_;

    my $set;
    if ($name && $number) {
        $set = "name = " . $dbh->quote($name) . ", number = " . $dbh->quote($number);
    }
    elsif ($name) {
        $set = "name = " . $dbh->quote($name);
    }
    elsif ($number) {
        $set = "number = " . $dbh->quote($number);
    }

    $dbh->do("UPDATE phones SET $set WHERE id = ?", undef, $id);
}