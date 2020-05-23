package Finance::Currency::Convert::SCSB;

use strict;
use warnings;

our $VERSION = '0.001';

use Exporter 'import';
our @EXPORT_OK = qw(get_currencies convert_currency);

use Mojo::UserAgent;

sub get_currencies {
}

sub convert_currency {
}

sub _dom {
    my $ua = Mojo::UserAgent->new;
    $ua->get('https://ibank.scsb.com.tw/netbank.portal?_nfpb=true&_pageLabel=page_other12&_nfls=false');
}

1;

__END__

=pod

=encoding utf-8

=head1 NAME

Finance::Currency::Convert::SCSB - Query currency exchange rates on
SCSB ( Shanghai Commercial and Savings Bank )

=head1 VERSION

0.1.0

=head1 DESCRIPTION

This module crawl and parses currency exchange rates listed on this web: L<https://ibank.scsb.com.tw/netbank.portal?_nfpb=true&_pageLabel=page_other12&_nfls=false> . All prices on this page are in TWD (Taiwan Dollar.) For this reason, it can only convert some non-TWD currency to TWD.

=head1 FUNCTIONS

The following functions are exportable, but not exported by default.

Some annotations with fictional Types are used in the following
documentation just for the purpose of explaination. No Type-validation
are implemented, nor are they defined. Not in this module.

"Num" referrer to a number, "Currency" is a short string such as
'TWD', 'USD'. The notation `Maybe[T]` means that the variable can
contain a value either be of type T, or C<undef>. See:
L<Types::Standard> or L<Moose::Util::TypeConstraints> for more
description of these notations.

=head2 convert_currency

Definition:

    ($error :Maybe[Str], $result :Maybe[Num]) =
        convert_currency(
            $amount :Num
            $from :Currency,
            $to :Currency
        )

When it is successful, C<$error> is C<undef> and C<$result> contained the parsed output.

When error of some kind happens, C<$error> contains the error message
and C<$result> is undef.

Example Usage:

    # Error-checking
    my ($err, $n) = convert_currency(100, 'USD', 'TWD');
    die "Error: $err": if $err;
    say "100 USD is about $n TWD";

    # Ignore error message. Checks the result directly.
    my $n = convert_currency(100, 'USD', 'TWD');
    if ( defined($n) ) {
        say "100 USD is about $n TWD";
    } else {
        say "Failed to convert 100 USD to TWD";
    }

=head2 get_currencies

With this function, the entire exchange rate table are parsed and returned in the special strucutre.

Definition:

    ($error :Maybe[Str], $result :Maybe[ArrayRef[Rate]]) =
        convert_currency(
            $amount :Num,
            $from :Currency,
            $to :Currency
        )

When it is successful, C<$error> is C<undef> and C<$result> contained the parsed output.

When error of some kind happens, C<$error> contains the error message
and C<$result> is undef.

Usage:

    # Error-checking
    my ($err, $o) = get_currencies();
    die "Error: $err": if $err;
    do_something($o);

    # Ignore error message. Checks the result directly.
    my $o = get_currencies();
    if ($o) {
        ...
    } else {
        ...
    }

The "Rate" type is a HashRef with 4 specific key-value pairs that looks like this:

    {
        zh_currency_name => "美金現金",
        en_currency_name => "USD CASH",
        buy_at           => 33.06,
        sell_at          => 33.56
    }

This structure is just a directly translation of the rate exchange
table shown on the source web page.

=head1 AUTHOR

Kang-min Liu <gugod@gugod.org>

=head1 LICENSE

This is free software, licensed under:

  The MIT (X11) License


