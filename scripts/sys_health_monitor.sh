#!/bin/bash

CPU_THRESHOLD=80
MEMORY_THRESHOLD=70
DISK_THRESHOLD=50

find_cpu() {
    local cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    if (( $(echo "$cpu_usage > $CPU_THRESHOLD" | bc -l) )); then
        echo "CPU usage is high: $cpu_usage%" >> monitoring_log.txt
    fi
}

find_memory() {
    local memory_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    if (( $(echo "$memory_usage > $MEMORY_THRESHOLD" | bc -l) )); then
        echo "Memory usage is high: $memory_usage%" >> monitoring_log.txt
    fi
}

find_disk() {
    local disk_usage=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
    if (( disk_usage >= DISK_THRESHOLD )); then
        echo "Disk usage is high: $disk_usage%" >> monitoring_log.txt
    fi
}

find_processes() {
    local processes=$(ps aux --no-heading | wc -l)
    if (( processes > 500 )); then
        echo "Number of running processes is high: $processes" >> monitoring_log.txt
    fi
}

main() {
    echo "Get System Health Monitoring"
    find_cpu
    find_memory
    find_disk
    find_processes
}

main
