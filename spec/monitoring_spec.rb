require "spec_helper"

describe "ubuntu-base::monitoring" do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end

  it "includes recipes" do
    expect(chef_run).to include_recipe "htop"
    expect(chef_run).to include_recipe "sysstat"
    expect(chef_run).to include_recipe "ubuntu-base::datadog"

    expect(chef_run).to_not include_recipe "newrelic-sysmond"
  end

  describe "when node[new_relic][license_key] is set" do
    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set["new_relic"]["license_key"] = "abc123"
      end.converge(described_recipe)
    end

    it { expect(chef_run).to include_recipe "newrelic-sysmond" }
  end
end
