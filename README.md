Name: urpuppet

Urpuppet is your puppet[1]. It's puppet in a masterless setup.
You only need to clone this repository or get a copy of it
to start using puppet. It also has hiera[2] support.

See my example modules and hiera configuration to get a better idea of
what you can do with this.


Usage:

    ./urpuppet


Will apply the manifests/site.pp manifest. Will also use the hiera conifg
which can be found in hiera-data/hiera.yaml and will search for modules in
the modules directory.

You can append any puppet flag at the end of urpuppet.
For example:

    ./urpuppet -vvv

Will show you more verbose output.


Directory structure:

hiera-data = Where all hiera data is stored.
manifests  = Where the manifests are stored. Will use the site.pp by default.
modules    = Where all modules are stored.



1. https://puppetlabs.com/puppet/what-is-puppet
2. https://docs.puppetlabs.com/hiera/1/