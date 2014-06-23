require "spec_helper"

describe "ubuntu-base::datadog" do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end

  before do
    stub_command "apt-cache search datadog-agent | grep datadog-agent"
  end

  it "does not include recipes by default" do
    expect(chef_run).to_not include_recipe "datadog::dd-agent"
    expect(chef_run).to_not include_recipe "datadog::dd-handler"
    expect(chef_run).to_not include_recipe "datadog::network"
  end

  describe "when node[datadog][api_key] is set" do
    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set["datadog"]["api_key"] = "abc123"
        node.set["datadog"]["application_key"] = "def456"
      end.converge(described_recipe)
    end

    it "includes recipes" do
      expect(chef_run).to include_recipe "datadog::dd-agent"
      expect(chef_run).to include_recipe "datadog::dd-handler"
      expect(chef_run).to include_recipe "datadog::network"
    end
  end
end
