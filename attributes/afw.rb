require "chef/sugar"

# afw cookbook
namespace "afw" do
  enable_input_drop true
  enable_output_drop false

  namespace "rules" do
    namespace "Inbound SSH" do
      protocol "tcp"
      direction "in"
      interface "default"
      user "sshd"
      source "0.0.0.0/0"
      dport "22"
    end
  end
end
