require "chef/sugar"

# datadog cookbook
namespace "datadog" do
  api_key ""  # datadog recipe raises an exception if this is `nil`
  network(
    instances: [
      { collect_connection_state: "false", excluded_interfaces: %w[lo lo0] }
    ]
  )
end
