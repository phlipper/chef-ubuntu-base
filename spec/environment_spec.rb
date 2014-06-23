require "spec_helper"

describe "ubuntu-base::environment" do
  let(:chef_run) do
    ChefSpec::Runner.new do |node|
      node.set["ubuntu-base"]["environment_variables"] = { "FOO" => "BAR" }
    end.converge(described_recipe)
  end

  it "creates the `/etc/environment` file" do
    expect(chef_run).to create_file("/etc/environment").with(mode: "0644")
    expect(chef_run).to(
      render_file("/etc/environment").with_content(%(FOO="BAR"))
    )
  end
end
