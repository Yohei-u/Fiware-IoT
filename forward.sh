#!/bin/ash

while !((mosquitto_sub -E -t t/e/s/t))
do
	sleep 2
done

mosquitto_sub -t shellies/shellyht-749A22/sensor/temperature | while read -r message
do
    mosquitto_pub -t ul/apiKey/shellyht-749A22/attrs -m "t|${message}" -h mosquitto
done