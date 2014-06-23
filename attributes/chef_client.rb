require "chef/sugar"

# chef-client cookbook
namespace "chef_client" do
  interval 1800
  splay 300
end
