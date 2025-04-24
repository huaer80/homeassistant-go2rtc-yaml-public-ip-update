#!/bin/bash

# File that contains the stored public IP
IP_FILE="/volume1/docker/homeassistant/go2rtc.yaml"

# Get the current public IP address
current_ip=$(curl -s https://api.ipify.org)

# Check if the IP file exists
if [[ ! -f "$IP_FILE" ]]; then
  echo "IP file does not exist. Creating a new file."
  echo "$current_ip" > "$IP_FILE"
  echo "IP file created with IP: $current_ip"
  exit 0
fi

# Read all lines except the last one (and preserve them)
lines=$(head -n -1 "$IP_FILE")

# Read the last line of the file
last_line=$(tail -n 1 "$IP_FILE")

# Extract the IP address from the last line using a regex (this assumes the IP is at the end of the line)
stored_ip=$(echo "$last_line" | grep -oP '\b(?:\d{1,3}\.){3}\d{1,3}\b')

# Compare the current IP with the stored IP
if [[ "$current_ip" != "$stored_ip" ]]; then
  echo "IP has changed. Updating the last line with the new IP."
  # Create the new file content: previous lines + updated last line
  echo "$lines" > "$IP_FILE"  # Write the existing lines back to the file
  echo "    - $current_ip:8555" >> "$IP_FILE"  # Append the updated last line with the new IP
  echo "IP file updated with new IP: $current_ip"
  #Restart homeassistant docker
  synowebapi --exec api=SYNO.Docker.Container version=1 method=restart name=homeassistant
  echo "Restarting homeassistant container"
else
  echo "IP is the same. No update needed."
fi
