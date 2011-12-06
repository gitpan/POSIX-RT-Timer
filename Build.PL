use 5.008001;
use strict;
use warnings;
use Devel::CheckLib;
use Module::Build;

my @extra_linker_flags = map { "-l$_" } grep { check_lib(lib => $_) } qw/rt/;

if ($^O eq 'MSWin32') {
  print STDERR "OS not supported\n";
  exit 0;
}

my $builder = Module::Build->new(
  module_name         => 'POSIX::RT::Timer',
  'build_requires' => {
    'File::Find' => '0',
    'File::Temp' => '0',
    'Module::Build' => '0.3601',
    'POSIX::RT::Signal' => '0',
    'Signal::Mask' => '0',
    'Test::Exception' => '0',
    'Test::More' => '0.88',
    'Time::HiRes' => '0'
  },
  'configure_requires' => {
    'Devel::CheckLib' => '0',
    'Module::Build' => '0.3601'
  },
  'requires' => {
    'Carp' => '0',
    'POSIX' => '0',
    'XSLoader' => '0',
    'perl' => '5.008001',
    'strict' => '0',
    'warnings' => '0'
  },
  extra_linker_flags  => \@extra_linker_flags,
);

$builder->create_build_script();
