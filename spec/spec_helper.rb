require "rspec/expectations"
require "chefspec"
require "chefspec/server"
require "chefspec/berkshelf"

RSpec.configure do |config|
  config.platform  = "ubuntu"
  config.version   = "14.04"
  config.log_level = :error

  config.before do
    data_bag_path = "../../test/support/data_bags"
    Chef::Config[:data_bag_path] = File.expand_path(data_bag_path, __FILE__)
  end
end

at_exit { ChefSpec::Coverage.report! }
