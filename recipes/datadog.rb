#
# Cookbook Name:: ubuntu-base
# Recipe:: datadog
#

return if node.deep_fetch("datadog", "api_key").to_s.empty?

include_recipe "datadog::dd-agent"
include_recipe "datadog::dd-handler"
include_recipe "datadog::network"
