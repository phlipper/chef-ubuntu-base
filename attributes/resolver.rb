require "chef/sugar"

# resolver cookbook
namespace "resolver" do
  nameservers %w[
    8.8.8.8
    8.8.4.4
  ]
end
