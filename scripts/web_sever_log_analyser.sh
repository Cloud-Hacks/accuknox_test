#!/bin/bash

# sudo -i
# apt install apache2
# service apache2 start

MYAPACHE_LOG_FILE="/var/log/apache2/access.log"

if [ ! -f "$MYAPACHE_LOG_FILE" ]; then
    echo "Error: Log file not found."
    exit 1
fi

analyse_logs() {
    echo "Number of 404 errors: $(grep ' 404 ' $MYAPACHE_LOG_FILE | wc -l)"

    echo -e "\nMost requested pages:"
    grep -oP '"GET \K[^"]+' $MYAPACHE_LOG_FILE | awk '{print $1}' | sort | uniq -c | sort -nr

    echo -e "\nIP addresses with the most requests:"
    awk '{print $1}' $MYAPACHE_LOG_FILE | sort | uniq -c | sort -nr
}

main() {
    echo "Web Server Health Check"
    analyse_logs
}

main
