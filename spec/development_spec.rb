require "spec_helper"

describe "ubuntu-base::development" do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end

  it "includes no recipes by default" do
    expect(chef_run).to_not include_recipe "brightbox-ruby"
    expect(chef_run).to_not include_recipe "nodejs"
  end

  describe "brightbox-ruby" do
    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set["ubuntu-base"]["enable_ruby"] = true
      end.converge(described_recipe)
    end

    it { expect(chef_run).to include_recipe "brightbox-ruby" }
  end

  describe "nodejs" do
    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set["ubuntu-base"]["enable_nodejs"] = true
      end.converge(described_recipe)
    end

    it { expect(chef_run).to include_recipe "nodejs" }
  end
end
