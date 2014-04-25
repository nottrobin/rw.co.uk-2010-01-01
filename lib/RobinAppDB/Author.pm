package RobinAppDB::Author;

=head1 NAME

RobinAppDB::Author - A DB Model object for authors

=cut

# Inherit DBIC
use base 'DBIx::Class';

# Required components
__PACKAGE__->load_components('PK::Auto', 'Core');

# Table config
__PACKAGE__->table('authors');
__PACKAGE__->add_columns('id', 'first_name', 'last_name');
__PACKAGE__->set_primary_key('id');

# Relationships
__PACKAGE__->has_many(
    book_author => 'RobinAppDB::BookAuthor',
    'author_id'
);
__PACKAGE__->many_to_many(
    books => 'book_author',
    'book'
);

1;

