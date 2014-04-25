package RobinAppDB::UserRole;

=head1 NAME

RobinAppDB::UserRole - The DBIC Model object for the many-to-many relationships between User and Role

=cut

use base ('DBIx::Class');

# Required components
__PACKAGE__->load_components('PK::Auto','Core');

# Table config
__PACKAGE__->table('user_roles');
__PACKAGE__->add_columns('user_id','role_id');
__PACKAGE__->set_primary_key('user_id','role_id');

# Relationships
__PACKAGE__->belongs_to(user => 'RobinAppDB::User', 'user_id');
__PACKAGE__->belongs_to(role => 'RobinAppDB::Role', 'role_id');

1;

