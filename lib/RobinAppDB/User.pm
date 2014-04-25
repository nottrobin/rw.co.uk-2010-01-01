package RobinAppDB::User;

=head1 NAME

RobinAppDB::User - The DBIC Model object for Users

=cut

use base ('DBIx::Class');

# Required components
__PACKAGE__->load_components('PK::Auto','Core');

# Table config
__PACKAGE__->table('users');
__PACKAGE__->add_columns('id','username','password','email_address','first_name','last_name');
__PACKAGE__->set_primary_key('id');

# Relationships
__PACKAGE__->has_many(user_roles => 'RobinAppDB::UserRole', 'user_id');
__PACKAGE__->many_to_many(
    roles => 'user_roles',
    'role'
);

1;

