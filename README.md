# System Health Reporter

A Bash CLI tool that generates a system health report
directly in your terminal or saves it to a log file.

## Features
- Displays hostname, uptime, CPU load, memory and disk usage
- Color-coded warnings when thresholds are crossed
- Supports --log flag to save reports to a file
- Can be scheduled with cron for automatic monitoring

## Usage
# Show report in terminal
healthcheck

# Save report to log file
healthcheck --log

# Schedule with cron (every day at 8am)
0 8 * * * /usr/local/bin/healthcheck --log

## Installation
git clone https://github.com/ahm3dra2a/system-health-reporter.git
cd system-health-reporter
chmod +x healthcheck.sh
sudo cp healthcheck.sh /usr/local/bin/healthcheck

## Requirements
- Linux
- Bash
- Standard tools: awk, grep, df, free, uptime