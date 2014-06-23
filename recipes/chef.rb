#
# Cookbook Name:: ubuntu-base
# Recipe:: chef
#

include_recipe "chef-client"
include_recipe "omnibus_updater"
include_recipe "chef-client::config"
