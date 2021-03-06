require "chef/sugar"

# ubuntu-base
namespace "ubuntu-base" do
  banned_packages %w[
    crda friendly-recovery language-pack-gnome-en laptop-detect libx11-6 nano
    nfs-common ntfs-3g os-prober powermgmt-base ppp rpcbind sgml-base usbutils
    watershed whiptail wireless-regdb
  ]

  enable_minitest false
  enable_nodejs false
  enable_ruby false

  environment_variables(
    "PATH" => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
    "TMOUT" => "600"  # OpenSSH client timeout
  )

  motd_note ""

  packages %w[
    curl dstat gdb git-core htop iftop inotail iotop libxml2-dev libxslt1-dev
    lsof man-db manpages mtr-tiny procinfo psmisc realpath rsync socat sysstat
    tree vim wget zip
  ]
end
