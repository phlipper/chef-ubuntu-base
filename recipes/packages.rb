#
# Cookbook Name:: ubuntu-base
# Recipe:: packages
#

node["ubuntu-base"]["packages"].each do |name|
  package name do
    action :install
  end
end

node["ubuntu-base"]["banned_packages"].each do |name|
  package name do
    action :purge
  end
end
