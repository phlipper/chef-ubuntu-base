#
# Cookbook Name:: ubuntu-base
# Recipe:: iptables
#

include_recipe "iptables"

node["ubuntu-base"]["iptables_rules"].each_with_index do |rule, index|
  iptables_rule "#{index.to_s.rjust(2, "0")}-#{rule}" do
    source "iptables-#{rule}.erb"
  end
end
