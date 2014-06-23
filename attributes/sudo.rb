require "chef/sugar"

# sudo cookbook
namespace "authorization" do
  namespace "sudo" do
    groups %w[sysadmin]
    include_sudoers_d true
    passwordless true
  end
end
