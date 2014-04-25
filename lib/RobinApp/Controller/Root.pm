package RobinApp::Controller::Root;

use strict;
use warnings;
use base 'Catalyst::Controller';

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config->{namespace} = '';

=head1 NAME

RobinApp::Controller::Root - Root Controller for RobinApp

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=cut

=head2 default

=cut

sub default : Private {
    my ( $self, $c ) = @_;

    # Hello World
    $c->response->body( $c->welcome_message );
}

=head2 auto

Check if there is a user and if not forward to login page

=cut

sub auto : Private {
    # Context
    my ($self, $c) = @_;

    # If they are not looking for the login page
    if($c->request->path !~ /user\//) {
        # If the user doesn't exist
	if( !$c->user_exists() ) {
	    # Log
	    $c->log->debug('***Root::auto - User not found, forwarding to /user/login');
	    
	    # Store original request page to redirect to later
	    $c->session->{'initial_request'} = $c->request->path;
	    
	    # Redirect to login
	    $c->response->redirect($c->uri_for('/user/login'));
	    # Return 0 to disable application
	    return 0;
	}
    }

    # If they got this far they're allowed to see the page
    return 1;
}

=head2 end

Attempt to render a view, if needed.

=cut 

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

root

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
