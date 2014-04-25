package RobinAppDB::Book;

=head1 NAME

RobinAppDB::Book - A model object representing a book

=cut

# Inherit DBIC
use base 'DBIx::Class';

# Required components
__PACKAGE__->load_components('PK::Auto', 'Core');

# Table config
__PACKAGE__->table('books');
__PACKAGE__->add_columns('id', 'title', 'rating');
__PACKAGE__->set_primary_key('id');

# Relationships
__PACKAGE__->has_many(
    book_authors => 'RobinAppDB::BookAuthor',
    'book_id'
);
__PACKAGE__->many_to_many(
    authors => 'book_authors',
    'author'
);

1;

