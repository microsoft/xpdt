#!/bin/bash

## Rui Leote - September 2026
##
## Blocked quick scan triggered by mdatp - troubleshooting script.
##
## This script is used to troubleshoot mdatp quick scans that don't finish in due time
## and need to be cancelled manually. It involves a timeout value that will define for
## how long the scan will run. It's set by default to 4 hours, 14400 seconds. This aims 
## at showing that the quick scan didn't end in the time window set in the TIMEOUT var.
## A report will be presented with the result of the scan that can be used to draw conclusions
## on wether the quick scan finished or not. The timeout value can be reduced if the scan
## finishes in 4 hours, to try and confirm how long the quick scan is taking to finish.

LOGFILE="mdatp_quickscan_$(date +%Y%m%d_%H%M%S).log"
TIMEOUT=14400 

START_EPOCH=$(date +%s.%N)
START_TIME=$(date '+%Y-%m-%d %H:%M:%S')

{
    echo "=================================================="
    echo "Microsoft Defender Quick Scan"
    echo "Start Time : $START_TIME"
    echo "Timeout    : ${TIMEOUT} seconds"
    echo "=================================================="
    echo
} > "$LOGFILE"

# Start the scan and capture all output
mdatp scan quick >> "$LOGFILE" 2>&1 &
SCAN_PID=$!

# Wait up to TIMEOUT seconds
COUNTER=0
while kill -0 "$SCAN_PID" 2>/dev/null; do
    sleep 1
    COUNTER=$((COUNTER + 1))

    if [ "$COUNTER" -ge "$TIMEOUT" ]; then
        echo "" >> "$LOGFILE"
        echo "*** Scan did NOT finish within ${TIMEOUT} seconds ***" >> "$LOGFILE"
        echo "*** Terminating scan process (PID $SCAN_PID) ***" >> "$LOGFILE"

        kill -TERM "$SCAN_PID" 2>/dev/null
        sleep 2

        # Force kill if still running
        if kill -0 "$SCAN_PID" 2>/dev/null; then
            kill -KILL "$SCAN_PID" 2>/dev/null
        fi

        STATUS="NOT FINISHED"
        break
    fi
done

# If we exited because the process completed
if ! kill -0 "$SCAN_PID" 2>/dev/null; then
    wait "$SCAN_PID" 2>/dev/null
    if [ -z "$STATUS" ]; then
        STATUS="COMPLETED"
    fi
fi

END_EPOCH=$(date +%s.%N)
END_TIME=$(date '+%Y-%m-%d %H:%M:%S')

ELAPSED=$(awk "BEGIN {printf \"%.3f\", $END_EPOCH - $START_EPOCH}")

{
    echo
    echo "=================================================="
    echo "Scan Summary"
    echo "=================================================="
    echo "Status         : $STATUS"
    echo "Start Time     : $START_TIME"
    echo "Finish Time    : $END_TIME"
    echo "Elapsed Time   : ${ELAPSED} seconds"
    echo "=================================================="
} >> "$LOGFILE"

echo "Log file created: $LOGFILE"

##
## EOF
##
