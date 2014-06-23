require "chef/sugar"

# openssh cookbook
namespace "openssh" do
  namespace "server" do
    accept_env "LANG LC_*"
    allow_groups %w[sysadmin deploy]
    allow_tcp_forwarding "no"
    client_alive_count_max 0
    client_alive_interval 300
    hostbased_authentication "no"
    ignore_rhosts "yes"
    log_level "INFO"
    login_grace_time "30"
    max_startups "3:50:75"
    password_authentication "no"
    permit_root_login "no"
    print_motd "no"
    protocol "2"
    strict_modes "yes"
    subsystem "sftp internal-sftp"
    use_dns "no"
    use_privilege_separation "yes"
    x11_forwarding "no"
  end
end
