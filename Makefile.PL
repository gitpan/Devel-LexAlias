use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.

my $module = 'LexAlias.pm';
WriteMakefile(
              'NAME'      => 'Devel::LexAlias',
              'VERSION_FROM' => $module, # finds $VERSION
              'LIBS'      => [''],   # e.g., '-lm'
              'PREREQ_PM' => { 'Test::More'=> 0 },
              'DEFINE'    => '',     # e.g., '-DHAVE_SOMETHING'
              'INC'       => '',     # e.g., '-I/usr/include/other'
             );

use Config;
use File::Spec::Functions;
sub MY::postamble {
    my $perl     = $Config{perlpath};
    my $pod2text = catfile($Config{bin}, "pod2text");
    return <<EOF
README: $module
\t$perl $pod2text $module > README
EOF
}
