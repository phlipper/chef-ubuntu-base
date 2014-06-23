#
# Cookbook Name:: ubuntu-base
# Recipe:: default
#

include_recipe "chef-sugar"

include_recipe "users::sysadmins"

include_recipe "locale"
include_recipe "hostname"
include_recipe "resolver"

include_recipe "ubuntu"
include_recipe "unattended-upgrades"

include_recipe "timezone"
include_recipe "ntp"
include_recipe "sysctl::apply"
include_recipe "build-essential"

include_recipe "ubuntu-base::motd"
include_recipe "ubuntu-base::environment"
include_recipe "ubuntu-base::packages"
include_recipe "ubuntu-base::chef"
include_recipe "ubuntu-base::logging"
include_recipe "ubuntu-base::shell"
include_recipe "ubuntu-base::security"
include_recipe "ubuntu-base::mailer"
include_recipe "ubuntu-base::monitoring"
include_recipe "ubuntu-base::development"

include_recipe "minitest-handler" if node["ubuntu-base"]["enable_minitest"]
