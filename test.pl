#!/usr/bin/perl

use PexelsUnofficial::ApiWrapper qw(pexel_first_asurl pexel_specific_asurl pexel_random_asurl);

# get the first image of "cat"
print pexel_first_asurl("cat") . "\n";

# get the 8th image of "cat". within the inclusive range of 1-15
print pexel_specific_asurl("cat", 8) . "\n";

# get image of "cat", will randomly pick 1-15
print pexel_random_asurl("cat") . "\n";