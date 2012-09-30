#!/usr/bin/env perl
use Mojolicious::Lite;
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
my $dbh = DBI->connect("DBI:mysql:$database:$host:$port", $user, $password) or 
    die "Couldn't connect to database: " . DBI->errstr;

app->config(hypnotoad => {listen => ['http://*:'.$env->{PORT_WWW}]});

get '/' => sub {
    my $self = shift;

    $self->render(text => 'Hello World! from Mojolicious!');
};

app->start;

# dotcloud run db echo "CREATE DATABASE test;" | mysql