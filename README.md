
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Tomcat Frequent Full GC Events
---

Tomcat is a widely used open source web server and servlet container software. Full GC (Garbage Collection) is a process that runs in Java Virtual Machine (JVM) to reclaim memory occupied by objects that are no longer in use. When Full GC events happen too frequently, it can cause performance issues and lead to application downtime. This incident type refers to the occurrence of frequent Full GC events in Tomcat.

### Parameters
```shell
export TOMCAT_PID="PLACEHOLDER"

export TOMCAT_LOG_FILE="PLACEHOLDER"

export NEW_HEAP_SIZE="PLACEHOLDER"

export PATH_TO_TOMCAT="PLACEHOLDER"
```

## Debug

### Check the system load
```shell
uptime
```

### Check memory usage
```shell
free -m
```

### Check swap usage
```shell
swapon -s
```

### Check disk usage
```shell
df -h
```

### Monitor the Java heap usage in real-time
```shell
jmap -histo ${TOMCAT_PID}
```

### Check the Tomcat log files for errors
```shell
tail -f ${TOMCAT_LOG_FILE}
```

### Get a thread dump of the Tomcat process
```shell
jstack ${TOMCAT_PID}
```

### Check the Java heap usage and GC statistics
```shell
jstat -gc ${TOMCAT_PID}
```

## Repair

### Increase the heap size of Tomcat to mitigate frequent full garbage collection events.
```shell
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


```