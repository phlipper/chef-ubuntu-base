require "chef/sugar"

# iptables cookbook
namespace "iptables" do
  allow_ping false
  install_rules false
end
