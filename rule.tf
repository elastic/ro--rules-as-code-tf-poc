terraform {
  required_providers {
    elasticstack = {
      source  = "elastic/elasticstack"
      version = "0.4.0"
    }
  }
}

provider "elasticstack" {
  elasticsearch {
    username  = "elastic"
    password  = "changeme"
    endpoints = ["http://localhost:9200"]
  }
}

# helpful to avoid repeating the same values or expressions multiple times
locals {
  # tags to be assigned to all resources
  common_action = jsonencode({
    # reference to a connector
    "id" : "${elasticstack_elasticsearch_index_connector.my_index_connector.id}",

    "group" : "threshold met",
    "params" : {
      "documents" : [{
        "rule_id" : "{{rule.id}}",
        "alert_id" : "{{alert.id}}"
      }]
    }
  })
}

# Rule definition, id generated by us in kibana
resource "elasticstack_elasticsearch_rule" "my_rule" {
  name         = "rule 1"
  consumer     = "alerts"
  rule_type_id = ".index-threshold"
  notify_when  = "onActionGroupChange"

  schedule = jsonencode({
    interval = "1m"
  })

  params = jsonencode({
    aggType             = "avg"
    termSize            = 6
    thresholdComparator = ">"
    timeWindowSize      = 5
    timeWindowUnit      = "m"
    groupBy             = "top"
    threshold           = [1000]
    index               = [".test-index"]
    timeField           = "@timestamp"
    aggField            = "sheet.version"
    termField           = "name.keyword"
  })

  action = [
    local.common_action
  ]
}

# Second rule definition, just to see locals working as action parameter
resource "elasticstack_elasticsearch_rule" "my_second_rule" {
  name         = "rule 2"
  consumer     = "alerts"
  rule_type_id = ".index-threshold"
  notify_when  = "onActionGroupChange"

  schedule = jsonencode({
    interval = "1m"
  })

  params = jsonencode({
    aggType             = "avg"
    termSize            = 6
    thresholdComparator = ">"
    timeWindowSize      = 5
    timeWindowUnit      = "m"
    groupBy             = "top"
    threshold           = [1000]
    index               = [".test-index"]
    timeField           = "@timestamp"
    aggField            = "sheet.version"
    termField           = "name.keyword"
  })

  action = [
    local.common_action
  ]
}

# Connector definition, will be used by both rules
resource "elasticstack_elasticsearch_index_connector" "my_index_connector" {
  name              = "index-connector-1"
  connector_type_id = ".index"

  config = jsonencode({
    index = ".test-index"
  })
}