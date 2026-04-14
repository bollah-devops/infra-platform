
#!/bin/bash

TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
LOG="/var/log/monitor/health.log"
STATUS="OK"

# Check 1 — Nginx running
if ! systemctl is-active --quiet nginx; then
    STATUS="CRITICAL"
    echo "$TIMESTAMP - CRITICAL - Nginx is NOT running" >> $LOG
fi

# Check 2 — Docker container running
if ! docker ps | grep -q infra-platform; then
    STATUS="CRITICAL"
    echo "$TIMESTAMP - CRITICAL - Flask container is NOT running" >> $LOG
fi

# Check 3 — App responding
if ! curl -sf http://localhost/health > /dev/null; then
    STATUS="CRITICAL"
    echo "$TIMESTAMP - CRITICAL - App is NOT responding" >> $LOG
fi

# Final status
if [ "$STATUS" = "OK" ]; then
    echo "$TIMESTAMP - OK - all systems up" >> $LOG
fi















# #!/bin/bash

# TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
# LOG="/var/log/monitor/health.log"

# STATUS="OK"

# # check 1 -Ngnix running

# if ! systemctl is-active --quiet nginx; then
#     STATUS="CRITICAL"
#     echo "$TIMESTAMP - Ngnix is NOT running" >> $LOG
# fi

# # check 2 - Docker container running

# if ! docker ps | grep -q flask-app; then
#     STATUS="CRITICAL"
#     echo "$TIMESTAMP - Flask container is NOT running" >> $LOG
# fi

# # check 3 - App response

# if ! curl -f http://localhost > /dev/null 2>&1; then
#     STATUS="CRITICAL"
#     echo "$TIMESTAMP - App isn NOT responding" >> $LOG
# fi

# #Final Status

# if [ "$STATUS" = "OK" ]; then
#     echo "$TIMESTAMP - OK" >> $LOG
# else
#     echo "$TIMESTAMP - CRITICAL" >> $LOG
# fi        