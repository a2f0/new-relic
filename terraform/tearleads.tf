resource "newrelic_synthetics_monitor" "tearleads-api" {
  name       = "tearleads-api-terraform"
  type       = "SIMPLE"
  frequency  = 1
  status     = "ENABLED"
  locations  = ["AWS_US_EAST_1"]
  uri        = "https://api.tearleads.com/healthcheck/"
  verify_ssl = true
}

resource "newrelic_synthetics_alert_condition" "tearleads-api" {
  policy_id  = newrelic_alert_policy.policy_with_channels.id
  name       = "tearleads-api-terraform"
  monitor_id = newrelic_synthetics_monitor.tearleads-api.id
}

resource "newrelic_synthetics_monitor" "tearleads-web" {
  name       = "tearleads-web-terraform"
  type       = "SIMPLE"
  frequency  = 1
  status     = "ENABLED"
  locations  = ["AWS_US_EAST_1"]
  uri        = "https://tearleads.com"
  verify_ssl = true
}

resource "newrelic_synthetics_alert_condition" "tearleads-web" {
  policy_id  = newrelic_alert_policy.policy_with_channels.id
  name       = "tearleads-web-terraform"
  monitor_id = newrelic_synthetics_monitor.tearleads-web.id
}
