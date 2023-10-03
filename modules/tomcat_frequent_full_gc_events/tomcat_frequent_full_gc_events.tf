resource "shoreline_notebook" "tomcat_frequent_full_gc_events" {
  name       = "tomcat_frequent_full_gc_events"
  data       = file("${path.module}/data/tomcat_frequent_full_gc_events.json")
  depends_on = [shoreline_action.invoke_tomcat_heap_update]
}

resource "shoreline_file" "tomcat_heap_update" {
  name             = "tomcat_heap_update"
  input_file       = "${path.module}/data/tomcat_heap_update.sh"
  md5              = filemd5("${path.module}/data/tomcat_heap_update.sh")
  description      = "Increase the heap size of Tomcat to mitigate frequent full garbage collection events."
  destination_path = "/agent/scripts/tomcat_heap_update.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_tomcat_heap_update" {
  name        = "invoke_tomcat_heap_update"
  description = "Increase the heap size of Tomcat to mitigate frequent full garbage collection events."
  command     = "`chmod +x /agent/scripts/tomcat_heap_update.sh && /agent/scripts/tomcat_heap_update.sh`"
  params      = ["PATH_TO_TOMCAT","NEW_HEAP_SIZE"]
  file_deps   = ["tomcat_heap_update"]
  enabled     = true
  depends_on  = [shoreline_file.tomcat_heap_update]
}

