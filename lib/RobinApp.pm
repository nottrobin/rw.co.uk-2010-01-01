package RobinApp;

use strict;
use warnings;

use Catalyst::Runtime '5.70';

# Set flags and add plugins for the application
use Catalyst( 
    '-Debug',          # Debug mode - useful robinapp_server.pl log messages
    'ConfigLoader',    # Load config from YAML file in App home dir
    'Static::Simple',  # Serve static files in App root dir

    # Authentication plugins
    'Authentication',
    'Authentication::Store::DBIC',
    'Authentication::Credential::Password',

    # Role-based authorization
    'Authorization::Roles',
    'Authorization::ACL',

    # Session plugins
    'Session',
    'Session::Store::FastMmap',
    'Session::State::Cookie',

    'StackTrace',      # Print useful error messages to browser debug screen
);

our $VERSION = '0.01';

# Configure the application. 
#
# Note that settings in RobinApp.yml (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with a external configuration file acting as an override for
# local deployment.

__PACKAGE__->config( name => 'RobinApp' );

# Start the application
__PACKAGE__->setup;

# Authorization::ACL Rules
__PACKAGE__->deny_access_unless(
    "/books/form_create",
    ['admin'],
);
__PACKAGE__->deny_access_unless(
    "/books/form_create_do",
    ['admin'],
);
__PACKAGE__->deny_access_unless(
    "/books/delete",
    ['user','admin']
);
__PACKAGE__->deny_access_unless(
    "/books/url_create",
    ['admin'],
);


=head1 NAME

RobinApp - Catalyst based application

=head1 SYNOPSIS

    script/robinapp_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<RobinApp::Controller::Root>, L<Catalyst>

=head1 AUTHOR

root

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
