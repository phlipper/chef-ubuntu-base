# chef-ubuntu-base  [![Build Status](http://img.shields.io/travis-ci/phlipper/chef-ubuntu-base.png)](https://travis-ci.org/phlipper/chef-ubuntu-base)

## Description

Bootstrap an opinionated Ubuntu base image.

This cookbook is meant to be used in a base role, or with [Vagrant](http://www.vagrantup.com) or [Packer](http://packer.io).

## Requirements

### Supported Platforms

The following platforms are supported by this cookbook, meaning that the recipes run on these platforms without error:

* Ubuntu 14.04

### Cookbooks

* [afw](https://github.com/jvehent/AFW)
* [brightbox-ruby](https://github.com/phlipper/chef-brightbox-ruby)
* [build-essential](http://github.com/opscode-cookbooks/build-essential)
* [chef-client](http://github.com/opscode-cookbooks/chef-client)
* [chef-sugar](https://github.com/sethvargo/chef-sugar)
* [chkrootkit](https://github.com/gregpalmier/chkrootkit-cookbook)
* [datadog](https://github.com/DataDog/chef-datadog)
* [fail2ban](http://github.com/opscode-cookbooks/fail2ban)
* [grc](https://github.com/phlipper/chef-grc)
* [hostname](https://github.com/3ofcoins/chef-cookbook-hostname)
* [htop](https://github.com/phlipper/chef-htop)
* [locale](http://github.com/hw-cookbooks/locale)
* [logrotate](http://github.com/opscode-cookbooks/logrotate)
* [logwatch](http://github.com/opscode-cookbooks/logwatch)
* [minitest-handler](https://github.com/btm/minitest-handler-cookbook)
* [newrelic-sysmond](https://github.com/phlipper/chef-newrelic-sysmond)
* [nodejs](https://github.com/phlipper/chef-nodejs)
* [ntp](http://github.com/opscode-cookbooks/ntp)
* [omnibus_updater](https://github.com/hw-cookbooks/omnibus_updater)
* [openssh](http://github.com/opscode-cookbooks/openssh)
* [papertrail](https://github.com/librato/papertrail-cookbook)
* [postfix](http://github.com/opscode-cookbooks/postfix)
* [resolver](http://github.com/opscode-cookbooks/resolver)
* [rkhunter](https://github.com/gregpalmier/rkhunter-cookbook)
* [sudo](http://github.com/opscode-cookbooks/sudo)
* [sysctl](https://github.com/onehealth-cookbooks/sysctl)
* [sysstat](https://github.com/retr0h/cookbook-sysstat)
* [timezone](http://community.opscode.com/cookbooks/timezone)
* [tmux](http://github.com/opscode-cookbooks/tmux)
* [ubuntu](http://github.com/opscode-cookbooks/ubuntu)
* [unattended-upgrades](https://github.com/phlipper/chef-unattended-upgrades)
* [users](https://github.com/sethvargo-cookbooks/users)
* [zsh](http://github.com/opscode-cookbooks/zsh)


## Recipes

* `chef` - Configure Chef client
* `datadog` - Configure Datadog integration
* `default` - Default recipe
* `development` - Install packages for development (ruby, nodejs, etc.)
* `environment` - Configure system environment
* `logging` - Configure system logging components
* `mailer` - Configure system mail relay
* `monitoring` - Configure system monitoring services
* `motd` - Configure system MOTD
* `packages` - Install and purge system packages
* `security` - Configure system security components
* `shell` - Configure shell components


## Usage

Simply include `recipe[ubuntu-base]` in your `run_list`.

_Note: You may need to ensure that `recipe[chef-sugar]` already exists in your run list._

## Attributes

These attributes are defined using the `chef-sugar` DSL syntax.

```ruby
# ubuntu-base cookbook
namespace "ubuntu-base" do
  banned_packages %w[
    friendly-recovery laptop-detect libx11-6 ntfs-3g os-prober powermgmt-base
    ppp
  ]

  enable_minitest false
  enable_nodejs false
  enable_ruby false

  environment_variables(
    "PATH" => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
    "TMOUT" => "600"  # OpenSSH client timeout
  )

  motd_note ""

  packages %w[
    curl dstat gdb git-core htop iftop inotail iotop libxml2-dev libxslt1-dev
    lsof man-db manpages mtr-tiny procinfo psmisc realpath rsync socat sysstat
    tree vim wget zip
  ]
end

# afw cookbook
namespace "afw" do
  enable_input_drop true
  enable_output_drop false

  namespace "rules" do
    namespace "Inbound SSH" do
      protocol "tcp"
      direction "in"
      interface "default"
      user "sshd"
      source "0.0.0.0/0"
      dport "22"
    end
  end
end

# chef-client cookbook
namespace "chef_client" do
  interval 1800
  splay 300
end

# chkrootkit cookbook
namespace "chkrootkit" do
  run_daily true
end

# datadog cookbook
namespace "datadog" do
  api_key ""  # datadog recipe raises an exception if this is `nil`
  network(
    instances: [
      { collect_connection_state: "false", excluded_interfaces: %w[lo lo0] }
    ]
  )
end

# hostname cookbook
set_fqdn "*"

# locale cookbook
namespace "locale" do
  lang "en_US.UTF-8"
  lc_all "en_US.UTF-8"
end

# openssh cookbook
namespace "openssh" do
  namespace "server" do
    accept_env "LANG LC_*"
    allow_groups %w[sysadmin deploy]
    allow_tcp_forwarding "no"
    client_alive_count_max 0
    client_alive_interval 300
    hostbased_authentication "no"
    ignore_rhosts "yes"
    log_level "INFO"
    login_grace_time "30"
    max_startups "3:50:75"
    password_authentication "no"
    permit_root_login "no"
    print_motd "no"
    protocol "2"
    strict_modes "yes"
    subsystem "sftp internal-sftp"
    use_dns "no"
    use_privilege_separation "yes"
    x11_forwarding "no"
  end
end

# postfix cookbook
mail_type "client"

# resolver cookbook
namespace "resolver" do
  nameservers %w[
    8.8.8.8
    8.8.4.4
  ]
end

# rkhunter cookbook
namespace "rkhunter" do
  apt_autogen true
end

# sudo cookbook
namespace "authorization" do
  namespace "sudo" do
    groups %w[sysadmin]
    include_sudoers_d true
    passwordless true
  end
end

# sysctl cookbook
namespace "sysctl" do
  namespace "params" do
    namespace "net" do
      namespace "ipv4" do
        tcp_timestamps 0  # disable tcp timestamps
        tcp_syncookies 1  # enable syn cookies (prevent common 'syn flood attack')
        ip_forward 0  # disable Packet forwarding between interfaces
        icmp_echo_ignore_broadcasts 1  # ignore all ICMP ECHO and TIMESTAMP requests sent to it via broadcast/multicast
        icmp_ignore_bogus_error_responses 1  # disable logging of bogus responses to broadcast frames

        namespace "conf" do
          namespace "all" do
            log_martians 1  # log packets with impossible addresses to kernel log
            rp_filter 1  # do source validation by reversed path (Recommended option for single homed hosts)
            send_redirects 0  # don't send redirects
            accept_source_route 0  # don't accept packets with SRR option
          end
        end
      end
    end
  end
end

# sysstat cookbook
namespace "sysstat" do
  package_action "install"
end

# timezone cookbook
tz "Etc/UTC"

# ubuntu cookbook
namespace "ubuntu" do
  architectures %w[amd64]
  include_source_packages false
end
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## License

**chef-ubuntu-base**

* Freely distributable and licensed under the [MIT license](http://phlipper.mit-license.org/2014/license.html).
* Copyright (c) 2014 Phil Cohen (github@phlippers.net) [![endorse](http://api.coderwall.com/phlipper/endorsecount.png)](http://coderwall.com/phlipper)  [![Gittip](http://img.shields.io/gittip/phlipper.png)](https://www.gittip.com/phlipper/)
* http://phlippers.net/
