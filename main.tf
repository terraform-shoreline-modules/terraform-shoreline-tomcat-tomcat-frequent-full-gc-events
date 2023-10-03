terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "tomcat_frequent_full_gc_events" {
  source    = "./modules/tomcat_frequent_full_gc_events"

  providers = {
    shoreline = shoreline
  }
}