#
# Cookbook Name:: ubuntu-base
# Recipe:: monitoring
#

include_recipe "ubuntu-base::datadog"

unless node.deep_fetch("new_relic", "license_key").to_s.empty?
  include_recipe "newrelic-sysmond"
end

include_recipe "htop"
include_recipe "sysstat"
