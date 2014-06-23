#
# Cookbook Name:: ubuntu-base
# Recipe:: development
#

include_recipe "nodejs" if node["ubuntu-base"]["enable_nodejs"]

include_recipe "brightbox-ruby" if node["ubuntu-base"]["enable_ruby"]
