package RobinAppDB;

=head1 NAME

RobinAppDB - DBIC Schema Class

=cut

# Inherit DBIC schema
use base qw/DBIx::Class::Schema/;

# Load DB Model classes
__PACKAGE__->load_classes({
    RobinAppDB => [(
        # Book functionality
	'Book',
	'BookAuthor',
	'Author',

	# Authentication
	'User',
	'UserRole',
	'Role',
    )]
});

1;

