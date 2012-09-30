use ExtUtils::MakeMaker;

WriteMakefile(
        NAME => "dummy",
        PREREQ_PM => {
           'JSON' => 0,
           'Mojolicious' => 3.43,
           'DBI' => 0,
           'DBD::mysql' => 0,
       },
)D: