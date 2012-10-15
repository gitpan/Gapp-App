package Gapp::App::Plugin;
{
  $Gapp::App::Plugin::VERSION = '0.006';
}

use Moose;
use MooseX::StrictConstructor;
use MooseX::SemiAffordanceAccessor;

with 'Gapp::App::Role::HasApp';

1;

