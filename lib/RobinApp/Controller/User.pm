package RobinApp::Controller::User;

use strict;
use warnings;
use base 'Catalyst::Controller';
use Data::Dumper;

=head1 NAME

RobinApp::Controller::User - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index 

=cut

sub index : Private {
    my ( $self, $c ) = @_;

    $c->response->body('Matched RobinApp::Controller::User in User.');
}

=head2 login

Log the user in

=cut

sub login : Local {
    # Context
    my ($self, $c) = @_;

    # Get username and password
    my $username = $c->request->params->{'username'} || '';
    my $password = $c->request->params->{'password'} || '';

    # Check values were found
    if( $username && $password ) {
        # log in user
	$c->log->debug("loggin in user: $username, $password");
	if( $c->login($username, $password) ) {
	    # success - redirect to initial request path or to books list
	    if ( $c->session->{'initial_request'} ) {
	        $c->response->redirect( $c->uri_for( '/' . $c->session->{'initial_request'} ) );
            } else {
	        $c->response->redirect( $c->uri_for( '/books/list' ) );
	    }
            
	    return;
	} else {
	    # Failed to log in. Say so
	    $c->stash->{'error_msg'} = "Bas username or password.";
	}
    }

    # Send to login page
    $c->stash->{'template'} = 'user/login.tt2';
}

=head2 logout

Logs the user out

=cut

sub logout : Local {
    # Context
    my ($self, $c) = @_;

    # Clear user's state
    $c->logout();

    # Send response
    $c->response->redirect($c->uri_for('/'));
}


=head1 AUTHOR

root

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
