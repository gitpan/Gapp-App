package Gapp::App::Component;
{
  $Gapp::App::Component::VERSION = '0.007';
}

use Moose;
use MooseX::StrictConstructor;
use MooseX::SemiAffordanceAccessor;

with 'Gapp::App::Role::HasApp';

1;

