require "chef/sugar"

# sysctl cookbook
namespace "sysctl" do
  namespace "params" do
    namespace "net" do
      namespace "ipv4" do
        tcp_timestamps 0  # disable tcp timestamps
        tcp_syncookies 1  # enable syn cookies (prevent common 'syn flood attack')
        ip_forward 0  # disable Packet forwarding between interfaces
        icmp_echo_ignore_broadcasts 1  # ignore all ICMP ECHO and TIMESTAMP requests sent to it via broadcast/multicast
        icmp_ignore_bogus_error_responses 1  # disable logging of bogus responses to broadcast frames

        namespace "conf" do
          namespace "all" do
            log_martians 1  # log packets with impossible addresses to kernel log
            rp_filter 1  # do source validation by reversed path (Recommended option for single homed hosts)
            send_redirects 0  # don't send redirects
            accept_source_route 0  # don't accept packets with SRR option
          end
        end
      end
    end
  end
end
