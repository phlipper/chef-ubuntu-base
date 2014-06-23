require_relative "test_helper"

describe_recipe "ubuntu-base::default" do
  # include_recipe "chef-sugar"
  it "installs `chef-sugar`" do
    assert_sh "/opt/chef/embedded/bin/gem list | grep chef-sugar"
  end

  # include_recipe "users::sysadmins"

  # include_recipe "locale"
  it "configures the default locale" do
    file("/etc/default/locale").must_include "LANG=en_US.UTF-8"
    file("/etc/default/locale").must_include "LC_ALL=en_US.UTF-8"
  end

  # include_recipe "hostname"
  it "configures the hostname" do
    file("/etc/hostname").must_include node.name
  end

  # include_recipe "resolver"
  it "configures the resolver" do
    file("/etc/resolv.conf").must_include "8.8.4.4"
    file("/etc/resolv.conf").must_include "8.8.8.8"
  end

  # include_recipe "ubuntu"
  it "configures the ubuntu defaults" do
    file("/etc/apt/sources.list").must_include "amd64"

    file("/etc/apt/sources.list").wont_include "i386"
    file("/etc/apt/sources.list").wont_include "deb-src"
  end

  # include_recipe "unattended-upgrades"

  # include_recipe "timezone"
  it "configures the timezone" do
    file("/etc/timezone").must_include "Etc/UTC"
  end

  # include_recipe "ntp"
  it "configures ntp" do
    file("/etc/ntp.conf").must_include "0.pool.ntp.org"
    file("/etc/ntp.conf").must_include "1.pool.ntp.org"
    file("/etc/ntp.conf").must_include "2.pool.ntp.org"
    file("/etc/ntp.conf").must_include "3.pool.ntp.org"
  end

  # include_recipe "sysctl::apply"

  # include_recipe "build-essential"
  it "installs build-essential" do
    package("build-essential").must_be_installed
  end

  # include_recipe "ubuntu-base::motd"
  # include_recipe "ubuntu-base::environment"
  # include_recipe "ubuntu-base::packages"
  # include_recipe "ubuntu-base::chef"
  # include_recipe "ubuntu-base::logging"
  # include_recipe "ubuntu-base::shell"
  # include_recipe "ubuntu-base::security"
  # include_recipe "ubuntu-base::mailer"
  # include_recipe "ubuntu-base::monitoring"
  # include_recipe "ubuntu-base::development"

  # include_recipe "minitest-handler"
  it "installs `minitest-chef-handler` if " do
    if node["ubuntu-base"]["enable_minitest"]
      assert_sh "/opt/chef/embedded/bin/gem list | grep minitest-chef-handler"
    else
      true
    end
  end
end
