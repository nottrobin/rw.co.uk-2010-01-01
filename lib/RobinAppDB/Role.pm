package RobinAppDB::Role;

=head1 NAME

RobinAppDB::Role - The DBIC Model object for user roles

=cut

use base ('DBIx::Class');

# Required components
__PACKAGE__->load_components('PK::Auto','Core');

# Table config
__PACKAGE__->table('roles');
__PACKAGE__->add_columns('id','role');
__PACKAGE__->set_primary_key('id');

# Relationships
__PACKAGE__->has_many(user_roles => 'RobinAppDB::UserRole', 'role_id');
__PACKAGE__->many_to_many(
    'users' => 'user_roles',
    'user'
);

1;

