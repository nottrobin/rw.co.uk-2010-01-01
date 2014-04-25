package RobinApp::Model::RobinAppDB;

use strict;
use base 'Catalyst::Model::DBIC::Schema';

__PACKAGE__->config(
    schema_class => 'RobinAppDB',
    connect_info => [
        'dbi:mysql:robinwin_robinapp',
        'robinwin_catalys',
        'K=;:1wnyHtSK',
        { AutoCommit => 1 },
        
    ],
);

=head1 NAME

RobinApp::Model::RobinAppDB - Catalyst DBIC Schema Model
=head1 SYNOPSIS

See L<RobinApp>

=head1 DESCRIPTION

L<Catalyst::Model::DBIC::Schema> Model using schema L<RobinAppDB>

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
