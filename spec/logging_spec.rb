require "spec_helper"

describe "ubuntu-base::logging" do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end

  it "includes recipes" do
    expect(chef_run).to include_recipe "logwatch"
    expect(chef_run).to include_recipe "logrotate"
    expect(chef_run).to_not include_recipe "papertrail"
  end

  describe "when node[papertrail][remote_port] is set" do
    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set["papertrail"]["remote_port"] = 123
      end.converge(described_recipe)
    end

    it "includes the recipe" do
      expect(chef_run).to include_recipe "papertrail"
    end
  end
end
