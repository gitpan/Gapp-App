#!/usr/bin/perl -w
use strict;
use warnings;


use Archive::Zip;
use File::Basename qw( fileparse );
use Getopt::Long;

use Gapp::App::Plugin::MetaFile;

# set defaults
my %ARG;
$ARG{extension} = 'zip';

# process command line options
GetOptions( \%ARG, 'source|s=s', 'version|v=s', 'target|t=s', 'package|p=s', 'extension|e=s');

if ( ! $ARG{source} ) {
    print "usage: $0 -s=dir\n";
    exit;
}

$ARG{source} =~ s/\\/\//g;

if ( ! $ARG{package} ) {
    
    my @path = split '/', $ARG{source};
    $ARG{package} = $path[-1];
}



# check for xml file

my $meta_path =  $ARG{source} . '/' . $ARG{package} . '.xml' ;
if ( ! -f $meta_path ) {
    print "Could not find meta file: $meta_path\n";
    exit;
}

my $meta = Gapp::App::Plugin::MetaFile->new;
$meta->load_file( $meta_path );

# get version from meta file if not set

$ARG{version} = $meta->version if ! defined $ARG{version};

my $package_name = $ARG{package} . ( defined $ARG{version} ? '-v' . $ARG{version} : '' );

if ( ! $ARG{target} ) {
    $ARG{target} = $package_name . '.' . $ARG{extension};
}




my $zip = Archive::Zip->new;
$zip->addTree( $ARG{source}, $package_name );
$zip->writeToFileNamed( $ARG{target} );



