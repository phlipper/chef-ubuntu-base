require "spec_helper"

describe "ubuntu-base::packages" do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end

  let(:default_pkgs_to_install) do
    %w[
      curl dstat gdb git-core htop iftop inotail iotop libxml2-dev libxslt1-dev
      lsof man-db manpages mtr-tiny procinfo psmisc realpath rsync socat sysstat
      tree vim wget zip
    ]
  end

  let(:default_pkgs_to_purge) do
    %w[
      friendly-recovery laptop-detect libx11-6 ntfs-3g os-prober powermgmt-base
      ppp
    ]
  end

  it "tests default packages in a brittle manner" do
    default_pkgs_to_install.each do |pkg|
      expect(chef_run).to install_package pkg
    end

    default_pkgs_to_purge.each do |pkg|
      expect(chef_run).to purge_package pkg
    end
  end

  describe "with specified attributes" do
    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set["ubuntu-base"]["packages"] = %w[foo bar]
        node.set["ubuntu-base"]["banned_packages"] = %w[baz qux]
      end.converge(described_recipe)
    end

    it "installs packages" do
      expect(chef_run).to install_package "foo"
      expect(chef_run).to install_package "bar"
    end

    it "purges packages" do
      expect(chef_run).to purge_package "baz"
      expect(chef_run).to purge_package "qux"
    end
  end
end
