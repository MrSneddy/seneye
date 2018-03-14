#!/bin/bash
while true; do

# Get the data
echo "Getting data from Seneye API..."
data=$(curl -s 'https://api.seneye.com/v1/devices/7612?IncludeState=1&user=mrsneddy@mac.com&pwd=')

#get the device details

devices=$(curl -s 'https://api.seneye.com/v1/devices?user=mrsneddy@mac.com&pwd=F22y3xW2!')

echo $devices


# Sort the data
temperature=$(echo "$data" | jq '.exps.temperature.curr' | sed -e s/[^0-9.]//g)
ph=$(echo "$data" | jq '.exps.ph.curr' | sed -e s/[^0-9.]//g)
nh3=$(echo "$data" | jq '.exps.nh3.curr' | sed -e s/[^0-9.]//g)
light=$(echo "$data" | jq '.exps.light.curr' | sed -e s/[^0-9.]//g) 
# Calculate slide expiry days
currentdate=$(date +%s)
unixexpiry=$(echo "$data" | jq '.status.slide_expires' | sed -e s/[^0-9.]//g)
math1=$(echo ""$unixexpiry"-"$currentdate"" | bc)
daysremaining=$(echo ""$math1" / 60 / 60 / 24" | bc)

# Display data in terminal
echo "temperature:" "$temperature"
echo "ph:" "$ph"
echo "nh3:" "$nh3"
echo "light:" "$light"
echo "slide days remaining:" "$daysremaining"

# Load the data into Domoticz
#echo "Sending data to Domoticz..."
#curl -s "http://USERNAME:PASSWORD@192.168.0.5/json.htm?type=command&param=udevice&idx=619&svalue=${temperature}"
#curl -s "http://USERNAME:PASSWORD@192.168.0.5/json.htm?type=command&param=udevice&idx=620&svalue=${ph}"
#curl -s "http://USERNAME:PASSWORD@192.168.0.5/json.htm?type=command&param=udevice&idx=621&svalue=${nh3}"
#curl -s "http://USERNAME:PASSWORD@192.168.0.5/json.htm?type=command&param=udevice&idx=622&svalue=${daysremaining}"


# Refresh data every 10 minutes
sleep 600
done
