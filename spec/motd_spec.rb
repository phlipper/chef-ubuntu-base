require "spec_helper"

describe "ubuntu-base::motd" do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end

  it "creates the `/etc/motd.chef` file" do
    expect(chef_run).to create_template("/etc/motd.chef").with(
      source: "motd.chef.erb",
      owner: "root",
      group: "root",
      mode: "0644"
    )
  end

  it "creates the `/etc/update-motd.d/00-header` file" do
    expect(chef_run).to create_file("/etc/update-motd.d/00-header").with(
      owner: "root",
      group: "root",
      mode: "0755"
    )
  end

  it "deletes the `/etc/update-motd.d/10-help-text` file" do
    expect(chef_run).to delete_file("/etc/update-motd.d/10-help-text")
  end
end
