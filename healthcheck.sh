#!/bin/bash

# ── Mode Detection ─────────────────────────────
if [ "$1" == "--log" ]; then
    exec >> ~/healthcheck.log 2>&1
fi

# ── Data Collection ────────────────────────────
realDateTime=$(date "+%Y-%m-%d %H:%M:%S")
hostName=$(hostname)
upTime=$(uptime -p)
cpuLoad=$(uptime | awk -F 'load average: ' '{print $2}')
memUsage=$(free -h | grep "Mem:" | awk '{print $3, "/ " $2}')
diskUsage=$(df -h / | awk 'NR==2 {print $3, "/ " $2, "("$5")"}')

# ── Threshold Calculation (raw integers) ───────
diskPercent=$(df / | awk 'NR==2 {print $5}' | tr -d '%')
memPercent=$(free | grep 'Mem:' | awk '{print int($3 * 100 / $2)}')

warningFlag=0

# ── Report Output ──────────────────────────────
echo
echo "========================================="
echo "  System Health Report"
echo "  $realDateTime"
echo "========================================="
echo "  Host       : $hostName"
echo "  Uptime     : $upTime"
echo "-----------------------------------------"
echo "  CPU Load   : $cpuLoad"
echo "  Memory     : $memUsage"
echo "  Disk       : $diskUsage"
echo "-----------------------------------------"

# ── Warnings ───────────────────────────────────
if [ "$diskPercent" -ge 80 ]; then
    echo -e "\e[33m  ⚠️  WARNING: Disk usage is above 80% \e[0m"
    warningFlag=1
fi

if [ "$memPercent" -ge 80 ]; then
    echo -e "\e[33m  ⚠️  WARNING: Memory usage is above 80% \e[0m"
    warningFlag=1
fi

if [ "$warningFlag" -eq 0 ]; then
    echo -e "\e[32m  ✅  All Systems Normal \e[0m"
fi

echo "========================================="