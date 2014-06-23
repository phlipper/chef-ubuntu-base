#
# Cookbook Name:: ubuntu-base
# Recipe:: environment
#

env_content = node["ubuntu-base"]["environment_variables"].map do |k, v|
  %(#{k}="#{v}")
end.join("\n")

file "/etc/environment" do
  content env_content
  mode "0644"
end
