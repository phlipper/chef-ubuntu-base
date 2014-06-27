#
# Cookbook Name:: ubuntu-base
# Recipe:: security
#

include_recipe "openssh"
include_recipe "afw"
include_recipe "sudo"
include_recipe "fail2ban"
include_recipe "chkrootkit"
include_recipe "rkhunter"
