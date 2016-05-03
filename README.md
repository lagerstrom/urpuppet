Urpuppet
=======

Urpuppet is your puppet[1]. It's puppet in a masterless setup.
You only need to clone this repository or get a copy of it
to start using puppet. It also has hiera[2] support.

Documentation
-------------
Urpuppet is as puppet with some scripting done on top. Therefor all the documentation for puppet is applicable to Urpuppet as well. The documentation for Puppet and related projects can be found online at the
[Puppet Docs site](https://docs.puppetlabs.com).

Installation
------------
Installing Urpuppet is as easy as cloning this repo and running one sciprt. It's also this script that you will run everytime you would like to trigger a puppet run.

Usage:

    git clone git@github.com:lagerstrom/urpuppet.git
    cd urpuppet
    ./urpuppet

Urpuppet to infinity and beyond
------------
After you have done the installation everything is setup and finished to start using. From here you can check back to this repository and pull down the latest changes and run Urpuppet again to apply the latest fixes. You can also start to modify the files to suite your needs even better. Below I will give you a quick start to add your own user to you system.

Because urpuppet works like a puppet apply all the flags you can supply to puppet apply works for urpuppet as well.

For example:

    ./urpuppet --test --noop

This will show a verbose output and not apply any puppet changes because of the --noop flag.

Let urpuppet care about users
---

Now we will go through how to add our own user to the hiera config file. This will make urpuppet to create the user if it does not exists. To do this we need to open the file `urpuppet/hiera-data/operatingsystem/Ubuntu/common.yaml`

To add the user chucky, we will need to add the following lines at the end of the file.

    # User configuration
    accounts::users:
      chucky:
        comment: "This user is created by urpuppet"
        groups: ["adm", "cdrom", "sudo", "dip", "plugdev", "docker"]
        shell: "/bin/zsh"

As you can see chucky is part of a couple of groups. We are also assigning zsh to be the default shell for chucky.

Directory structure
-----

* hiera-data = Where all hiera data is stored.
* manifests  = Where the manifests are stored. Will use the site.pp by default.
* modules    = Where all modules are stored.

Contribute
-------------

If you think you have an idea of getting Urpuppet to be even better. Please tell me or send a pull request. That will help making the Urpuppet project better over time.


References
--
1. https://puppetlabs.com/puppet/what-is-puppet
2. https://docs.puppetlabs.com/hiera/1/
