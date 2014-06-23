#
# Cookbook Name:: ubuntu-base
# Recipe:: logging
#

include_recipe "logwatch"
include_recipe "logrotate"

include_recipe "papertrail" if node.deep_fetch("papertrail", "remote_port")
