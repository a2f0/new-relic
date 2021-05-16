resource "newrelic_synthetics_monitor" "devopsrockstars" {
  name       = "devopsrockstars-terraform"
  type       = "SIMPLE"
  frequency  = 1
  status     = "ENABLED"
  locations  = ["AWS_US_EAST_1"]
  uri        = "https://devopsrockstars.com"
  verify_ssl = true
}

resource "newrelic_synthetics_alert_condition" "devopsrockstars" {
  policy_id = newrelic_alert_policy.policy_with_channels.id

  name       = "devopsrockstars-terraform"
  monitor_id = newrelic_synthetics_monitor.devopsrockstars.id
}
