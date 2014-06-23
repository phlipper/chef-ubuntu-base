require "chef/sugar"

# ubuntu cookbook
namespace "ubuntu" do
  architectures %w[amd64]
  include_source_packages false
end
