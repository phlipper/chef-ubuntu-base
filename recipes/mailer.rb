#
# Cookbook Name:: ubuntu-base
# Recipe:: mailer
#

# node.set["postfix"]["main"]["smtp_sasl_password_maps"] = "static:#{key}:#{k}"

# include_recipe "postfix::sasl_auth"
include_recipe "postfix::aliases"
