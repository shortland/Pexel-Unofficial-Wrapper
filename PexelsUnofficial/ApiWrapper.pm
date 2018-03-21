package PexelsUnofficial::ApiWrapper;

use strict;
use warnings;
use HTTP::Request::Common qw(GET);
use LWP::UserAgent;
use Exporter qw(import);

our @EXPORT_OK = qw(pexel_first_asurl pexel_specific_asurl pexel_random_asurl);

my $pexels_search_url = "https://www.pexels.com/search/";

sub get_pexel_page {
	my ($n, $p) = @_;
	$p = 1 if !defined $p;
	my $get_req = GET($pexels_search_url . $n . "/?page=" . $p);
	my $ua = LWP::UserAgent->new();
	$ua->agent("Unoff");
	my $get_res = $ua->request($get_req);
	return $get_res->content;
}

sub pexel_first_asurl {
	my ($n) = @_;
	my $p = get_pexel_page($n);
	my @res = ($p =~ m/srcset="((\w|:|\/|\.|-|\?|=|&|;)+ 1x)/g);
	return $res[0];
}

sub pexel_specific_asurl {
	my ($n, $c) = @_;
	return "Error: must define a specific image to get. Must be number 1-15" if !defined $c;
	return "Error: out of range. Must be number 1-15" if ($c > 15 || $c < 1);
	$c = ($c - 1) * 2;
	my $p = get_pexel_page($n);
	my @res = ($p =~ m/srcset="((\w|:|\/|\.|-|\?|=|&|;)+ 1x)/g);
	return $res[$c];
}

sub pexel_random_asurl {
	my ($n) = @_;
	return pexel_specific_asurl($n, 1 + int(rand(15)));
}