package RobinAppDB::BookAuthor;

=head1 NAME

RobinAppDB::BookAuthor - A model object to link authors to books

=cut

# Inherit DBIC
use base 'DBIx::Class';

# Required components
__PACKAGE__->load_components('PK::Auto', 'Core');

# Table config
__PACKAGE__->table('book_authors');
__PACKAGE__->add_columns('book_id', 'author_id');
__PACKAGE__->set_primary_key('book_id', 'author_id');

# Relationships
__PACKAGE__->belongs_to(
    book => 'RobinAppDB::Book',
    'book_id'
);
__PACKAGE__->belongs_to(
    author => 'RobinAppDB::Author',
    'author_id'
);

1;

