#!/usr/bin/env perl
use JSON;
use DBI;
use DBD::mysql;

open my $fh, "<", "/home/dotcloud/environment.json" or die $!;
my $env = JSON::decode_json(join '', <$fh>);


my $database = 'test';
my $user = $env->{DOTCLOUD_DB_MYSQL_LOGIN};
my $password = $env->{DOTCLOUD_DB_MYSQL_PASSWORD};
my $host = $env->{DOTCLOUD_DB_MYSQL_HOST};
my $port = $env->{DOTCLOUD_DB_MYSQL_PORT};
my $dbh = DBI->connect("DBI:mysql:hostname=$host;port=$port;", $user, $password) or 
    die "Couldn't connect to database: " . DBI->errstr;

DBI->exec("CREATE DATABASE IF NOT EXISTS $database;");