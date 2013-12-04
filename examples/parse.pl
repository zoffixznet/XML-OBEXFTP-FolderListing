#!/usr/bin/env perl

use strict;
use warnings;
use lib '../lib';
use XML::OBEXFTP::FolderListing;


my $data =<<'END_DATA';
<?xml version="1.0" ?>
<!DOCTYPE folder-listing SYSTEM "obex-folder-listing.dtd">
<folder-listing>
<parent-folder />
<folder name="audio" size="0" type="folder" modified="19700101T000000Z" user-perm="RW" />
<folder name="video" size="0" type="folder" modified="19700101T000000Z" user-perm="RW" />
<folder name="picture" size="0" type="folder" modified="19700101T000000Z" user-perm="RW" />
<file name="31-01-08_2213.jpg" size="27665" type="image/jpeg" modified="20080131T221123Z" user-perm="RW" />
<file name="26-01-08_1228.jpg" size="40196" type="image/jpeg" modified="20080126T122836Z" user-perm="RW" />
<file name="05-02-08_2043.jpg" size="33210" type="image/jpeg" modified="20080205T204310Z" user-perm="RW" />
<file name="26-01-08_0343.jpg" size="40802" type="image/jpeg" modified="20080126T034339Z" user-perm="RW" />
<file name="05-02-08_2312.jpg" size="33399" type="image/jpeg" modified="20080205T230946Z" user-perm="RW" />
<file name="05-02-08_2047.jpg" size="21318" type="image/jpeg" modified="20080205T204358Z" user-perm="RW" />
</folder-listing>
END_DATA

my $p = XML::OBEXFTP::FolderListing->new;

$p->parse($data);

for ( @{ $p->folders } ) {
    printf "Folder: %s\n\tPermissions: %s\n\tLast-Modified: %s\n\n",
            $_, $p->perms( $_, 'folder' ), $p->modified( $_, 'folder' );
}

for my $file ( @{ $p->files } ) {
    printf "File: %s\n\tPermissions: %s\n\tSize: %s\n\tType: %s\n\t"
            . "Last-Modified: %s\n\n",
            $file, map { $p->$_( $file ) } qw( perms size type modified );
}
