#!/bin/bash

APP_URL="https://www.google.com"

check_application_status() {
    local http_status
    http_status=$(curl -s -o /dev/null -w "%{http_code}" "$APP_URL")

    if [ "$http_status" -eq 200 ]; then
        echo "Application is available with HTTP status code $http_status"
    else
        echo "Application is unavailable or not responding with HTTP status code $http_status"
    fi
}

main() {
    echo "Application Health Checker"

    check_application_status
}

main
