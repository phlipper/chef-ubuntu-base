require "spec_helper"

describe "ubuntu-base::shell" do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end

  it "includes recipes" do
    expect(chef_run).to include_recipe "tmux"
    expect(chef_run).to include_recipe "grc"
    expect(chef_run).to include_recipe "zsh"
  end
end
