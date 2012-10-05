#!/usr/bin/env perl
use Mojolicious::Lite;
use JSON;
use DBI;
use DBD::mysql;

my $envFilename = "/home/dotcloud/environment.json";
my ($user, $password, $host, $port, $env, $webPort);

if ( -e $envFilename ) {
    open my $fh, "<", $envFilename or die $!;
    $env = JSON::decode_json(join '', <$fh>);
    $user = $env->{DOTCLOUD_DB_MYSQL_LOGIN};
    $password = $env->{DOTCLOUD_DB_MYSQL_PASSWORD};
    $host = $env->{DOTCLOUD_DB_MYSQL_HOST};
    $port = $env->{DOTCLOUD_DB_MYSQL_PORT};
    $webPort = $env->{PORT_WWW};
}
else {
    # local development environment
    $user = "root";
    $password = "root";
    $host = "localhost";
    $port = "3306";
    $webPort = "8080";
}

my $database = 'test';
my $dbh = DBI->connect("DBI:mysql:database=$database;host=$host;port=$port", $user, $password) or 
    die "Couldn't connect to database: " . DBI->errstr;

app->config(hypnotoad => {listen => ['http://*:' . $webPort]});

get '/' => sub {
    my $self = shift;
    $self->render(text => 'Hello World! from Mojolicious!');
};

app->start;