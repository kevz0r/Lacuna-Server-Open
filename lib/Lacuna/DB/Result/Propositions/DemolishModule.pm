package Lacuna::DB::Result::Propositions::DemolishModule;

use Moose;
use utf8;
no warnings qw(uninitialized);
extends 'Lacuna::DB::Result::Propositions';

before pass => sub {
    my ($self) = @_;
    my $station = $self->station;
    my ($building) = grep {$self->scratch->{building_id}} @{$station->building_cache};
    if (defined $building) {
        $building->demolish;
    }
    else {
        $self->pass_extra_message('Unfortunately, by the time the proposition passed, the module had already been demolished, effectively nullifying the vote.');
    }
};

no Moose;
__PACKAGE__->meta->make_immutable(inline_constructor => 0);
