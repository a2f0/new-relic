terraform {
  required_version = "~> 0.15.0"
  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
      version = "~> 2.21.0"
    }
  }
}

provider "newrelic" {
  account_id = var.new_relic_account_id
  api_key    = var.new_relic_api_key
  region     = "US"
}

resource "newrelic_alert_channel" "slack_channel" {
  name = "slack-terraform"
  type = "slack"

  config {
    url     = var.slack_webhook_url
    channel = "notifications"
  }
}

resource "newrelic_alert_policy" "policy_with_channels" {
  name                = "terraform-slack-channel"
  incident_preference = "PER_CONDITION"

  channel_ids = [
    newrelic_alert_channel.slack_channel.id,
  ]
}

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
