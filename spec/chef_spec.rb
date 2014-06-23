require "spec_helper"

describe "ubuntu-base::chef" do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end

  it "includes recipes" do
    expect(chef_run).to include_recipe "chef-client"
    expect(chef_run).to include_recipe "omnibus_updater"
    expect(chef_run).to include_recipe "chef-client::config"
  end
end
