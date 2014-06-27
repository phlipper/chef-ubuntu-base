#
# Cookbook Name:: ubuntu-base
# Recipe:: motd
#

template "/etc/motd.chef" do
  source "motd.chef.erb"
  owner "root"
  group "root"
  mode "0644"
end

file "/etc/update-motd.d/00-header" do
  content [
    "#!/bin/sh",
    "/usr/bin/test -f /etc/motd.chef && /bin/cat /etc/motd.chef"
  ].join("\n")
  owner "root"
  group "root"
  mode "0755"
end

file "/etc/update-motd.d/10-help-text" do
  action :delete
  ignore_failure true
end
