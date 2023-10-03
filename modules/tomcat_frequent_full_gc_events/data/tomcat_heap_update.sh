bash

#!/bin/bash



# Define variables

TOMCAT_HOME=${PATH_TO_TOMCAT}

HEAP_SIZE=${NEW_HEAP_SIZE}



# Stop Tomcat service

sudo systemctl stop tomcat



# Set new heap size

sed -i "s/-Xmx[0-9]*m/-Xmx${HEAP_SIZE}m/" $TOMCAT_HOME/bin/catalina.sh



# Start Tomcat service

sudo systemctl start tomcat