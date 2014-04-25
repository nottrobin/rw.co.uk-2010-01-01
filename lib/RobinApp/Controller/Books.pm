package RobinApp::Controller::Books;

use strict;
use warnings;
use base 'Catalyst::Controller';
use Data::Dumper;


=head1 NAME

RobinApp::Controller::Books - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index 

=cut

sub index : Private {
    my ( $self, $c ) = @_;

    $c->response->body('Matched RobinApp::Controller::Books in Books.');
}

=head2 list

Fetch all books from the database - display with books/list.tt2

=cut

sub list : Local {
    # Get context objects
    my ($self, $c) = @_;

    # Retrieve a list of books from the model - store in stash
    $c->stash->{'books'} = [$c->model('RobinAppDB::Book')->all];

    # Pass View the appropriate template
    $c->stash->{'template'} = 'books/list.tt2';
}

=head2 url_create

Create a book from the URL

=cut

sub url_create : Local {
    # Get context and URL arguments - passed through in @_
    my ($self, $c, $title, $rating, $author_id) = @_;

    # Create a new book
    my $book = $c->model('RobinAppDB::Book')->create({
        title => $title,
        rating => $rating
    });

    # Join book to an author
    $book->create_related('book_authors', {author_id => $author_id});

    # Add book to the stash
    $c->stash->{'book'} = $book;

    # Pass the template name to View
    $c->stash->{'template'} = 'books/create_done.tt2';
}

=head2 form_create

Display form to add a book

=cut

sub form_create : Local {
    # Retrieve context
    my ($self, $c) = @_;

    # Set the template
    $c->stash->{'template'} = 'books/form_create.tt2';
}

=head2 form_create_do

Store information from book add form

=cut

sub form_create_do : Local {
    # Context
    my ($self, $c) = @_;

    # Retrieve values from form
    my $title     = $c->request->params->{'title'}  || 'N/A';
    my $rating    = $c->request->params->{'rating'} || 'N/A';
    my $author_id = $c->request->params->{'author_id'} || '1';

    # Create the book
    my $book = $c->model('RobinAppDB::Book')->create({
        title => $title,
	rating => $rating,
    });
    # Add author relationship
    $book->create_related('book_authors',{author_id => $author_id});

    my $author_last_name = [$book->authors()]->[0]->last_name();

    # Report book created on status
    $c->stash->{'status_msg'} = 'Book created. ' . $author_last_name;

    # Set template
    $c->forward('list');
}

=head2 delete

Delete a book

=cut

sub delete : Local {
    # $id = primary key of book to delete
    my ($self, $c, $id) = @_;

    # Find the book and delete it
    $c->model('RobinAppDB::Book')->search({id => $id})->delete_all;

    # Set status message
    $c->stash->{'status_msg'} = 'Book deleted.';

    # Forward to list controller
    $c->forward('list');
}

=head2 access_denied

Authorization::ACL access denied

=cut

sub access_denied : Private {
    my ($self, $c) = @_;

    # Set error message
    $c->stash->{'error_msg'} = 'Unauthorized!';

    # Display the list
    $c->forward('list');
}

=head1 AUTHOR

root

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
