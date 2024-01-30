#!/bin/bash

APP_URL="https://www.google.com"

check_application_status() {
    local http_status
    http_status=$(curl -s -o /dev/null -w "%{http_code}" "$APP_URL")

    if [ "$http_status" -eq 200 ]; then
        echo "Application is UP. HTTP Status Code: $http_status"
        echo "It is available"
    else
        echo "Application is DOWN. HTTP Status Code: $http_status"
        echo "It is unavailable or not responding"
    fi
}

main() {
    echo "Application Health Checker"

    check_application_status
}

main
