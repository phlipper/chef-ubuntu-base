require "spec_helper"

describe "ubuntu-base::default" do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end

  before do
    stub_command "which sudo"
  end

  it "includes recipes" do
    expect(chef_run).to include_recipe "chef-sugar"
    expect(chef_run).to install_chef_gem "chef-sugar"

    expect(chef_run).to include_recipe "users::sysadmins"

    expect(chef_run).to include_recipe "locale"
    expect(chef_run).to include_recipe "hostname"
    expect(chef_run).to include_recipe "resolver"

    expect(chef_run).to include_recipe "ubuntu"
    expect(chef_run).to include_recipe "unattended-upgrades"

    expect(chef_run).to include_recipe "timezone"
    expect(chef_run).to include_recipe "ntp"
    expect(chef_run).to include_recipe "sysctl::apply"
    expect(chef_run).to include_recipe "build-essential"

    expect(chef_run).to include_recipe "ubuntu-base::motd"
    expect(chef_run).to include_recipe "ubuntu-base::environment"
    expect(chef_run).to include_recipe "ubuntu-base::packages"
    expect(chef_run).to include_recipe "ubuntu-base::chef"
    expect(chef_run).to include_recipe "ubuntu-base::logging"
    expect(chef_run).to include_recipe "ubuntu-base::shell"
    expect(chef_run).to include_recipe "ubuntu-base::security"
    expect(chef_run).to include_recipe "ubuntu-base::mailer"
    expect(chef_run).to include_recipe "ubuntu-base::monitoring"
    expect(chef_run).to include_recipe "ubuntu-base::development"
  end

  describe "minitest-handler" do
    context "by default" do
      it { expect(chef_run).to_not include_recipe "minitest-handler" }
    end

    context "when `enable_minitest` is `true`" do
      let(:chef_run) do
        ChefSpec::Runner.new do |node|
          node.set["ubuntu-base"]["enable_minitest"] = true
        end.converge(described_recipe)
      end

      it { expect(chef_run).to include_recipe "minitest-handler" }
    end
  end
end
