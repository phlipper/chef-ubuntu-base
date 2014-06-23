require "spec_helper"

describe "ubuntu-base::iptables" do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end

  it { expect(chef_run).to include_recipe "iptables" }
end
