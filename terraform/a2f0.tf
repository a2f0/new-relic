resource "newrelic_synthetics_monitor" "a2f0" {
  name       = "a2f0-terraform"
  type       = "SIMPLE"
  frequency  = 1
  status     = "ENABLED"
  locations  = ["AWS_US_EAST_1"]
  uri        = "https://a2f0.net"
  verify_ssl = true
}

resource "newrelic_synthetics_alert_condition" "a2f0" {
  policy_id = newrelic_alert_policy.policy_with_channels.id

  name       = "a2f0-terraform"
  monitor_id = newrelic_synthetics_monitor.a2f0.id
}
