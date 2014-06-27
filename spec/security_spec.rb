require "spec_helper"

describe "ubuntu-base::security" do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end

  before do
    stub_command "which sudo"
  end

  it "includes recipes" do
    expect(chef_run).to include_recipe "openssh"
    expect(chef_run).to include_recipe "afw"
    expect(chef_run).to include_recipe "sudo"
    expect(chef_run).to include_recipe "fail2ban"
    expect(chef_run).to include_recipe "chkrootkit"
    expect(chef_run).to include_recipe "rkhunter"
  end
end
