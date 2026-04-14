#!/bin/bash

TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
HEALTH_LOG="/var/log/monitor/health.log"
ALERT_LOG="/var/log/monitor/alerts.log"

mkdir -p /var/log/monitor

# Read the last 10 minutes of logs
RECENT_LOGS=$(awk -v date="$(date --date='10 minutes ago' '+%Y-%m-%d %H:%M:%S')" '$0 >= date' $HEALTH_LOG)

# Count CRITICAL lines
CRITICAL_COUNT=$(echo "$RECENT_LOGS" | grep -c "CRITICAL")

# If more than 3 CRITICALs trigger alert
if [ "$CRITICAL_COUNT" -gt 3 ]; then
    echo "$TIMESTAMP - ALERT - $CRITICAL_COUNT critical events in last 10 minutes" >> $ALERT_LOG
fi